param(
    [string] $Label = 'bundle',
    [string[]] $Candidate = @(),
    [int] $Shield = 11,
    [string] $Out = ''
)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$work = Join-Path $repo "target/predict/$Label"
Remove-Item $work -Recurse -Force -ErrorAction Ignore
New-Item -ItemType Directory -Force (Join-Path $work 'src'), (Join-Path $work 'apps/predict') | Out-Null
Copy-Item (Join-Path $repo 'src/*') (Join-Path $work 'src')
Copy-Item (Join-Path $repo 'apps/predict/*') (Join-Path $work 'apps/predict')
function Set-Text([string] $path, [string] $old, [string] $new) {
    $text = [IO.File]::ReadAllText($path)
    if (!$text.Contains($old)) { throw "predict / $path has no '$old'" }
    [IO.File]::WriteAllText($path, $text.Replace($old, $new))
}
$lib = (Resolve-Path (Join-Path $repo 'deps/spiral/lib')).Path -replace '\\', '/'
Set-Text (Join-Path $work 'apps/predict/package.spiproj') 'packageDir: ../../deps/spiral/lib' "packageDir: $lib"
if ($Candidate.Count) {
    $chain = ($Candidate | ForEach-Object { "|> $_" }) -join ' '
    $predict = Join-Path $work 'apps/predict/predict.spi'
    $identity = @('inl', ':=') | ForEach-Object { "$_ candidate (c : camp) : camp = c" } | Where-Object { [IO.File]::ReadAllText($predict).Contains($_) } | Select-Object -First 1
    Set-Text $predict ($identity ?? 'inl candidate (c : camp) : camp = c') "$identity $chain"
}
if ($Shield -ne 11) {
    Set-Text (Join-Path $work 'src/combat.spi') 'shielded_defense 11i32 dwarven_shield' "shielded_defense ${Shield}i32 dwarven_shield"
}
$env:SPIRAL_COMPILER_PACKAGE_DIR = Join-Path (Resolve-Path (Join-Path $repo 'deps/spiral')) 'deps/The-Spiral-Language/VS Code Plugin'
$dotnet = Join-Path $env:LOCALAPPDATA "spiral-bin/toolchains/dotnet/dotnet$(if ($IsWindows) { '.exe' })"
$compiler = Join-Path $env:LOCALAPPDATA 'spiral-bin/bin/single-flight/SpiralCompiler/Release/net11.0/SpiralCompiler.dll'
$c = Join-Path $work 'predict.c'
& $dotnet $compiler --backend C (Join-Path $work 'apps/predict/predict.spi') $c 2>&1 | Select-Object -Last 2 | Write-Host
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / compile failed" }
$exe = Join-Path $work "predict$(if ($IsWindows) { '.exe' })"
& gcc -O2 -o $exe $c -lm
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / gcc failed" }
$rows = @(& $exe)
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / run failed ($LASTEXITCODE)" }
if ($Out) { $rows | Set-Content $Out } else { $rows }
