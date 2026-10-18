param(
    [Parameter(Mandatory)] [string] $Script,
    [int] $TimeoutSeconds = 150
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
$client = Join-Path $TibiaWorld 'otclient-src'
$probeLog = Join-Path $env:APPDATA 'otcr\otclient\otclient\tibia-probe.log'
Copy-Item $Script (Join-Path $client 'otclientrc.lua') -Force
if (Test-Path $probeLog) { [IO.File]::Delete($probeLog) }
& (Join-Path $PSScriptRoot 'run-offscreen.ps1') -Exe (Join-Path $client 'otclient_gl_x64.exe') -WorkingDirectory $client -TimeoutSeconds $TimeoutSeconds
if (Test-Path $probeLog) { Get-Content $probeLog }
