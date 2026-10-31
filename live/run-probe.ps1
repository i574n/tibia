param(
    [Parameter(Mandatory)] [string] $Script,
    [int] $TimeoutSeconds = 150,
    [string] $UserDir = '',
    [string] $AfterLine = '',
    [string] $InLog = ''
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
if ($AfterLine) {
    $deadline = (Get-Date).AddSeconds(120)
    while (-not (Select-String -Path $InLog -SimpleMatch $AfterLine -Quiet -ErrorAction SilentlyContinue)) {
        if ((Get-Date) -gt $deadline) { throw "run-probe / '$AfterLine' not in $InLog after 120 s" }
        Start-Sleep -Milliseconds 250
    }
}
$client = Join-Path $TibiaWorld 'otclient-src'
$profileDir = if ($UserDir) { $UserDir } else { $client }
$probeLog = if ($UserDir) { Join-Path $UserDir 'tibia-probe.log' } else { Join-Path $env:APPDATA 'otcr\otclient\otclient\tibia-probe.log' }
if ($UserDir) { New-Item -ItemType Directory -Force $UserDir | Out-Null }
Copy-Item $Script (Join-Path $profileDir 'otclientrc.lua') -Force
if (Test-Path $probeLog) { [IO.File]::Delete($probeLog) }
$launch = if ($UserDir) { "--user-dir=`"$UserDir`"" } else { '' }
& (Join-Path $PSScriptRoot 'run-offscreen.ps1') -Exe (Join-Path $client 'otclient_gl_x64.exe') -WorkingDirectory $client -TimeoutSeconds $TimeoutSeconds -Arguments $launch
if (Test-Path $probeLog) { Get-Content $probeLog }
