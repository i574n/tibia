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
        if ((Get-Date) -gt $deadline) { throw "run-gauge / '$AfterLine' not in $InLog after 120 s" }
        Start-Sleep -Milliseconds 250
    }
}
$client = Join-Path $TibiaWorld 'otclient-src'
$profileDir = if ($UserDir) { $UserDir } else { $client }
$gaugeLog = if ($UserDir) { Join-Path $UserDir 'tibia-gauge.log' } else { Join-Path $env:APPDATA 'otcr\otclient\otclient\tibia-gauge.log' }
if ($UserDir) { New-Item -ItemType Directory -Force $UserDir | Out-Null }
Copy-Item $Script (Join-Path $profileDir 'otclientrc.lua') -Force
if (Test-Path $gaugeLog) { [IO.File]::Delete($gaugeLog) }
$launch = if ($UserDir) { "--user-dir=`"$UserDir`"" } else { '' }
& (Join-Path $PSScriptRoot 'run-offscreen.ps1') -Exe (Join-Path $client 'otclient_gl_x64.exe') -WorkingDirectory $client -TimeoutSeconds $TimeoutSeconds -Arguments $launch
if (Test-Path $gaugeLog) { Get-Content $gaugeLog }
