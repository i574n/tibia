param(
    $fast,
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"


pwsh init.ps1 -fast $($fast ?? '')

. ../deps/polyglot/scripts/core.ps1

{ pwsh build.ps1 -Exclude gpu_sim,hunt_sim -Label short } | Invoke-Block

{ pwsh build.ps1 -Files gpu_sim,hunt_sim -Label long-gpu } | Invoke-Block

{ pwsh publish.ps1 } | Invoke-Block
