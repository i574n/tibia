param(
    [Parameter(Mandatory)] [string] $Exe,
    [string] $WorkingDirectory = (Split-Path $Exe),
    [int] $TimeoutSeconds = 120,
    [string] $DesktopName = 'tibia-probe'
)
$ErrorActionPreference = 'Stop'

Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

public static class OffscreenDesktop {
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct StartupInfo {
        public int cb; public string lpReserved; public string lpDesktop; public string lpTitle;
        public int dwX; public int dwY; public int dwXSize; public int dwYSize;
        public int dwXCountChars; public int dwYCountChars; public int dwFillAttribute;
        public int dwFlags; public short wShowWindow; public short cbReserved2;
        public IntPtr lpReserved2; public IntPtr hStdInput; public IntPtr hStdOutput; public IntPtr hStdError;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct ProcessInformation {
        public IntPtr hProcess; public IntPtr hThread; public int dwProcessId; public int dwThreadId;
    }

    [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern IntPtr CreateDesktop(string name, IntPtr device, IntPtr devmode, int flags, uint access, IntPtr attributes);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool CloseDesktop(IntPtr desktop);

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern bool CreateProcess(string application, string commandLine, IntPtr processAttributes, IntPtr threadAttributes,
        bool inheritHandles, uint creationFlags, IntPtr environment, string currentDirectory, ref StartupInfo startupInfo, out ProcessInformation processInformation);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern uint WaitForSingleObject(IntPtr handle, uint milliseconds);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool GetExitCodeProcess(IntPtr process, out uint exitCode);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool TerminateProcess(IntPtr process, uint exitCode);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool CloseHandle(IntPtr handle);
}
'@

$desktopAllAccess = [uint32]0x01FF
$desktop = [OffscreenDesktop]::CreateDesktop($DesktopName, [IntPtr]::Zero, [IntPtr]::Zero, 0, $desktopAllAccess, [IntPtr]::Zero)
if ($desktop -eq [IntPtr]::Zero) { throw "CreateDesktop failed: $([Runtime.InteropServices.Marshal]::GetLastWin32Error())" }

try {
    $startup = New-Object OffscreenDesktop+StartupInfo
    $startup.cb = [Runtime.InteropServices.Marshal]::SizeOf($startup)
    $startup.lpDesktop = "WinSta0\$DesktopName"
    $process = New-Object OffscreenDesktop+ProcessInformation
    $created = [OffscreenDesktop]::CreateProcess($Exe, "`"$Exe`"", [IntPtr]::Zero, [IntPtr]::Zero, $false, 0, [IntPtr]::Zero, $WorkingDirectory, [ref] $startup, [ref] $process)
    if (-not $created) { throw "CreateProcess failed: $([Runtime.InteropServices.Marshal]::GetLastWin32Error())" }
    try {
        $waited = [OffscreenDesktop]::WaitForSingleObject($process.hProcess, [uint32]($TimeoutSeconds * 1000))
        if ($waited -ne 0) {
            [OffscreenDesktop]::TerminateProcess($process.hProcess, 124) | Out-Null
            "offscreen: killed after $TimeoutSeconds s"
        }
        $exitCode = [uint32]0
        [OffscreenDesktop]::GetExitCodeProcess($process.hProcess, [ref] $exitCode) | Out-Null
        "offscreen: pid $($process.dwProcessId) exit $exitCode on desktop $DesktopName"
    } finally {
        [OffscreenDesktop]::CloseHandle($process.hThread) | Out-Null
        [OffscreenDesktop]::CloseHandle($process.hProcess) | Out-Null
    }
} finally {
    [OffscreenDesktop]::CloseDesktop($desktop) | Out-Null
}
