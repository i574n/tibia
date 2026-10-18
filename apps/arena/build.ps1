param(
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"
. ../../deps/polyglot/scripts/core.ps1
. ../../deps/spiral/lib/spiral/lib.ps1


$targetDir = (New-Item -ItemType Directory -Force "../../target/arena").FullName
$lua = Get-Command lua -ErrorAction Ignore
$probes = Get-ChildItem . -File -Filter "*.spi" | Where-Object { Select-String -Path $_.FullName -Pattern '^inl main \(\)' -Quiet } | Sort-Object Name
foreach ($probe in $probes) {
    $name = "tibia/apps/arena/$($probe.BaseName)"
    $out = Join-Path $targetDir "$($probe.BaseName).lua"
    if (!(BuildSpiral $probe.FullName $out $name -Backend Lua)) { throw "LUA-FAILED $name / compile" }
    if ($lua) {
        $syntax = & $lua.Source -e "local f, e = loadfile([[$out]]); if not f then print(e); os.exit(1) end"
        if ($LASTEXITCODE -ne 0) { throw "LUA-FAILED $name / parse: $syntax" }
        Write-Output "LUA-OK $name / $out"
    } else {
        Write-Output "LUA-COMPILED $name / $out (no lua on PATH, parse not checked)"
    }
}
if (!$probes) { throw "build.ps1 / no probe with a main in $ScriptDir" }
