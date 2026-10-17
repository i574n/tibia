param(
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"
. ../deps/polyglot/scripts/core.ps1


{ pwsh ../deps/spiral/scripts/publish-tree.ps1 -Root .. -Include '*.tsv', '*.txt', '*.lua', '*.xml' } | Invoke-Block
