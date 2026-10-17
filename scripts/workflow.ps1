param(
    $fast,
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"


pwsh init.ps1 -fast $($fast ?? '')

. ../deps/polyglot/scripts/core.ps1

{ pwsh build.ps1 } | Invoke-Block

{ pwsh publish.ps1 } | Invoke-Block
