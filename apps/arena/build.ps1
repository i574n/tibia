param(
    $ScriptDir = $PSScriptRoot
)
Push-Location $ScriptDir
$ErrorActionPreference = "Stop"
try {
    . ../../deps/spiral/scripts/core.ps1
    . ../../deps/spiral/lib/spiral/lib.ps1

    $hostCalls = Select-String -Path lua.spi -Pattern '\b(os|io|debug)\.|\bg_\w+|\b(require|dofile|loadfile)\b'
    if ($hostCalls) { throw "build.ps1 / lua.spi must stay host-free for sandboxed VMs such as Dota bots, host calls go in client.spi:`n$($hostCalls -join "`n")" }

    $targetDir = (New-Item -ItemType Directory -Force "../../target/arena").FullName
    $lua = Get-Command lua -ErrorAction Ignore
    $gauges = Get-ChildItem . -File -Filter "*.spi" | Where-Object { Select-String -Path $_.FullName -Pattern '^(inl|:=) main \(\)' -Quiet } | Sort-Object Name
    foreach ($gauge in $gauges) {
        $name = "tibia/apps/arena/$($gauge.BaseName)"
        $out = Join-Path $targetDir "$($gauge.BaseName).lua"
        if (!(BuildSpiral $gauge.FullName $out $name -Backend Lua)) { throw "LUA-FAILED $name / compile" }
        if ($lua) {
            $syntax = & $lua.Source -e "local f, e = loadfile([[$out]]); if not f then print(e); os.exit(1) end"
            if ($LASTEXITCODE -ne 0) { throw "LUA-FAILED $name / parse: $syntax" }
            Write-Output "LUA-OK $name / $out"
        } else {
            Write-Output "LUA-COMPILED $name / $out (no lua on PATH, parse not checked)"
        }
    }
    if (!$gauges) { throw "build.ps1 / no gauge with a main in $ScriptDir" }
} finally {
    Pop-Location
}
