param(
    [Parameter(Mandatory)] [string] $Exe,
    [string] $WorkingDirectory = (Split-Path $Exe),
    [int] $TimeoutSeconds = 120,
    [string] $DesktopName = 'tibia-probe',
    [string] $Arguments = ''
)
$ErrorActionPreference = 'Stop'

$launcher = Join-Path $PSScriptRoot '../target/offscreen/offscreen.exe'
if (!(Test-Path $launcher)) { & (Join-Path $PSScriptRoot '../apps/offscreen/build.ps1') | Out-Null }
$launch = @('--exe', $Exe, '--directory', $WorkingDirectory, '--timeout-seconds', "$TimeoutSeconds", '--desktop', $DesktopName)
if ($Arguments) { $launch += @('--arguments', $Arguments) }
& $launcher @launch
if ($LASTEXITCODE -ne 0) { throw "offscreen launcher failed ($LASTEXITCODE)" }
