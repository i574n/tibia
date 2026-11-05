param(
    [string] $Label = 'bundle',
    [string[]] $Candidate = @(),
    [int] $Shield = 11,
    [string] $Out = '',
    [string] $Module = 'predict',
    [ValidateSet('c', 'rust')] [string] $Backend = 'c'
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
function Set-Manifests([string] $dir, [string] $relative) {
    $toml = Join-Path $work "$dir/spiral.toml"; $proj = Join-Path $work "$dir/package.spiproj"
    if (!(Test-Path $toml) -and !(Test-Path $proj)) { throw "predict / $dir has neither spiral.toml nor package.spiproj" }
    if (Test-Path $toml) {
        Set-Text $toml "packageDir = '$relative'" "packageDir = '$lib'"
        $text = [IO.File]::ReadAllText($toml)
        if ($Module -ne 'predict' -and $dir -eq 'apps/predict' -and $text -match "(?m)^modules" -and $text -notmatch "(?m)^$Module\s*$") {
            Set-Text $toml "`npredict`n" "`npredict`n$Module`n"
        }
    }
    if (Test-Path $proj) {
        Set-Text $proj "packageDir: $relative" "packageDir: $lib"
        if ($Module -ne 'predict' -and $dir -eq 'apps/predict' -and [IO.File]::ReadAllText($proj) -notmatch "(?m)^\s+$Module\s*$") {
            Set-Text $proj '    predict' "    predict`n    $Module"
        }
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
$source = Join-Path $work "predict.$(if ($Backend -eq 'rust') { 'rs' } else { 'c' })"
& $dotnet $compiler --backend ($Backend -eq 'rust' ? 'Rust' : 'C') (Join-Path $work "apps/predict/$Module.spi") $source 2>&1 | Select-Object -Last 2 | Write-Host
if ($LASTEXITCODE -ne 0) { throw "predict / $Label / compile failed" }
$exe = Join-Path $work "predict$(if ($IsWindows) { '.exe' })"
if ($Backend -eq 'rust') { & rustc --edition 2024 -O -A warnings -o $exe $source } else { & gcc -O2 -o $exe $source -lm }
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
