param(
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"
. ../deps/spiral/scripts/core.ps1


& ../deps/spiral/scripts/publish-tree.ps1 -Root .. -Include '*.tsv', '*.txt', '*.lua', '*.xml', '*.spi.html', '*.spi.ipynb', '*.spi.livemd'
