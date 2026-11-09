param(
    [string] $Label = 'bundle',
    [string[]] $Candidate = @(),
    [int] $Shield = 11,
    [string] $Out = '',
    [string] $Module = 'predict',
    [ValidateSet('c', 'rust', 'zig')] [string] $Backend = 'c',
    [switch] $SkipChecks,
    [switch] $CheckOnly
)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if (!$SkipChecks -and !$CheckOnly) {
    Push-Location
    try { & (Join-Path $PSScriptRoot 'build.ps1') -ChecksOnly | ForEach-Object { Write-Host "predict / $_" } }
    finally { Pop-Location }
}
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
function Set-Manifests([string] $dir, [string] $relative) {
    $toml = Join-Path $work "$dir/spiral.toml"
    if (!(Test-Path $toml)) { throw "predict / $dir has no spiral.toml" }
    Set-Text $toml "packageDir = '$relative'" "packageDir = '$lib'"
    $text = [IO.File]::ReadAllText($toml)
    if ($Module -ne 'predict' -and $dir -eq 'apps/predict' -and $text -match "(?m)^modules" -and $text -notmatch "(?m)^$Module\s*$") {
        $closing = $text.LastIndexOf("`n'''")
        if ($closing -lt 0) { throw "predict / $dir/spiral.toml has no closing ''' for its modules" }
        [IO.File]::WriteAllText($toml, $text.Insert($closing, "`n$Module"))
    }
}
Set-Manifests 'apps/predict' '../../deps/spiral/lib'
Set-Manifests 'src' '../deps/spiral/lib'
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
$cache = if ($env:SPIRAL_BIN_CACHE_DIR) { $env:SPIRAL_BIN_CACHE_DIR } elseif ($env:LOCALAPPDATA) { Join-Path $env:LOCALAPPDATA 'spiral-bin' } else { Join-Path $HOME '.cache/spiral-bin' }
$dotnet = Join-Path $cache "toolchains/dotnet/dotnet$(if ($IsWindows) { '.exe' })"
$compiler = Join-Path $cache 'bin/single-flight/SpiralCompiler/Release/net11.0/SpiralCompiler.dll'
if ($CheckOnly) {
    foreach ($entry in (Join-Path $work "apps/predict/$Module.spi"), (Join-Path $work 'src/hunting_pack.spi')) {
        & $dotnet $compiler --check --timeout-ms 120000 $entry 2>&1 | Select-Object -Last 2 | Write-Host
        if ($LASTEXITCODE -ne 0) { throw "predict / $Label / check failed for $entry (exit $LASTEXITCODE)" }
    }
    return
}
$target = @{
    c = @{ ext = 'c'; name = 'C'; build = { gcc -O2 -o $exe $source -lm } }
    rust = @{ ext = 'rs'; name = 'Rust'; build = { rustc --edition 2024 -O -A warnings -o $exe $source } }
    zig = @{ ext = 'zig'; name = 'Zig'; build = { zig build-exe $source -O ReleaseFast --stack 1073741824 -fno-emit-implib "-femit-bin=$exe" } }
}[$Backend]
$source = Join-Path $work "predict.$($target.ext)"
& $dotnet $compiler --backend $target.name (Join-Path $work "apps/predict/$Module.spi") $source 2>&1 | Select-Object -Last 2 | Write-Host
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / compile failed" }
$exe = Join-Path $work "predict$(if ($IsWindows) { '.exe' })"
& $target.build
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / $Backend build failed" }
$watch = [Diagnostics.Stopwatch]::StartNew()
$rows = @(& $exe)
$ms = $watch.ElapsedMilliseconds
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / run failed ($LASTEXITCODE)" }
$hunts = $rows | Select-String "^hunts`t(\d+)$" | Select-Object -Last 1
if ($hunts) {
    $metrics = (New-Item -ItemType Directory -Force (Join-Path $repo 'target/ci-metrics')).FullName
    $rate = $ms -le 0 ? 0 : [long][math]::Floor([long]$hunts.Matches[0].Groups[1].Value * 1000 / $ms)
    @('# TYPE tibia_sim_hunts_per_second gauge', "tibia_sim_hunts_per_second{backend=`"$Backend`"} $rate") | Set-Content (Join-Path $metrics "sim-$Label.prom")
    Write-Host "predict / $Label / $($hunts.Matches[0].Groups[1].Value) hunts in $ms ms = $rate hunts/s"
}
if ($Out) { $rows | Set-Content $Out } else { $rows }
