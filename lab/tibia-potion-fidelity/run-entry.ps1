param(
    [Parameter(Mandatory)] [string] $Entry,
    [string] $Source = (Join-Path $PSScriptRoot '../../src'),
    [string] $Label = '',
    [string[]] $Rewrite = @()
)
$ErrorActionPreference = 'Stop'
$name = [IO.Path]::GetFileNameWithoutExtension($Entry)
$runs = Join-Path $env:LOCALAPPDATA "spiral-bin/runs/tibia-potion-fidelity/$name$Label"
New-Item -ItemType Directory -Force $runs | Out-Null
Get-ChildItem $runs -Filter '*.spi' | Remove-Item
Copy-Item (Join-Path $Source '*.spi') $runs
Copy-Item $Entry $runs
foreach ($r in $Rewrite) {
    $file, $old, $new = $r -split '\|', 3
    $path = Join-Path $runs "$file.spi"
    $text = [IO.File]::ReadAllText($path)
    if (!$text.Contains($old)) { throw "run-entry.ps1 / rewrite / $file has no $old" }
    [IO.File]::WriteAllText($path, $text.Replace($old, $new))
}
$modules = (Get-Content (Join-Path $Source 'package.spiproj') | Where-Object { $_ -match '^\s{4}\w' } | ForEach-Object { $_.Trim() }) + $name
[IO.File]::WriteAllText((Join-Path $runs 'package.spiproj'), "packages: |core-`nmodules:`n$(($modules | ForEach-Object { "    $_" }) -join "`n")`n")
$env:SPIRAL_COMPILER_PACKAGE_DIR = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot '../../deps/spiral')) 'deps/The-Spiral-Language/VS Code Plugin')
$dotnet = Join-Path $env:LOCALAPPDATA 'spiral-bin/toolchains/dotnet/dotnet.exe'
$compiler = Join-Path $env:LOCALAPPDATA 'spiral-bin/bin/single-flight/SpiralCompiler/Release/net11.0/SpiralCompiler.dll'
$c = Join-Path $runs "$name.c"
& $dotnet $compiler --backend C (Join-Path $runs "$name.spi") $c 2>&1 | Select-Object -Last 2 | Write-Host
if ($LASTEXITCODE -ne 0) { throw "run-entry.ps1 / $name / compile failed" }
$exe = Join-Path $runs "$name.exe"
& gcc -O2 -o $exe $c -lm
if ($LASTEXITCODE -ne 0) { throw "run-entry.ps1 / $name / gcc failed" }
& $exe
