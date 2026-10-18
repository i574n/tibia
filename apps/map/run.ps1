param(
    [switch] $Update,
    $ScriptDir = $PSScriptRoot
)
$ErrorActionPreference = 'Stop'
. (Join-Path $ScriptDir '../../live/paths.ps1')

$repo = (Resolve-Path (Join-Path $ScriptDir '../..')).Path
$spiral = (Resolve-Path (Join-Path $repo 'deps/spiral')).Path
$out = (New-Item -ItemType Directory -Force (Join-Path $repo 'target/map')).FullName
$env:SPIRAL_COMPILER_PACKAGE_DIR = Join-Path $spiral 'deps/The-Spiral-Language/VS Code Plugin'
$env:SPIRAL_WORKSPACE_ROOT = Join-Path $spiral 'apps/compiler/tmp'
$dotnet = Join-Path $env:LOCALAPPDATA "spiral-bin/toolchains/dotnet/dotnet$(if ($IsWindows) { '.exe' })"
$compiler = Join-Path $env:LOCALAPPDATA 'spiral-bin/bin/single-flight/SpiralCompiler/Release/net11.0/SpiralCompiler.dll'
& $dotnet $compiler --backend Rust (Join-Path $ScriptDir 'map.spi') (Join-Path $out 'map.rs')
if ($LASTEXITCODE -ne 0) { throw "map / spiral compile failed ($LASTEXITCODE)" }
$exe = Join-Path $out "map$(if ($IsWindows) { '.exe' })"
rustc --edition 2024 -O -A warnings -o $exe (Join-Path $out 'map.rs')
if ($LASTEXITCODE -ne 0) { throw "map / rustc failed ($LASTEXITCODE)" }

$canary = Join-Path $TibiaWorld 'canary'
$env:TIBIA_MAP_APPEARANCES = Join-Path $canary 'data/items/appearances.dat'
$env:TIBIA_MAP_ITEMS = Join-Path $canary 'data/items/items.xml'
$env:TIBIA_MAP_OTBM = Join-Path $canary 'data-canary/world/canary.otbm'
$output = @(& $exe)
if ($LASTEXITCODE -ne 0) { throw "map / run failed ($LASTEXITCODE)" }
$dumpAt = [array]::FindIndex([string[]]$output, [Predicate[string]] { param($line) $line.StartsWith('walkability around ') })
$generated = $output[0..($dumpAt - 1)]
$listingAt = [array]::FindIndex([string[]]$output, [Predicate[string]] { param($line) $line.StartsWith('floor-change tiles ') })
$dump = $output[$dumpAt..($listingAt - 1)]
$listing = Join-Path $out 'floor-changes.txt'
[IO.File]::WriteAllText($listing, ($output[$listingAt..($output.Count - 1)] -join "`n") + "`n")
"map / floor-change listing in $listing"
$region = Join-Path $repo 'results/arena-region-r30.txt'
$committed = @(Get-Content $region)
if (($committed -join "`n") -ne ($dump -join "`n")) { throw "map / the walkability dump differs from results/arena-region-r30.txt" }
"map / walkability dump matches results/arena-region-r30.txt ($($dump.Count - 1) rows)"

$scan = @(Get-Content (Join-Path $repo 'results/arena-spot-scan-r12.txt'))
$marker = [array]::FindIndex([string[]]$scan, [Predicate[string]] { param($line) $line.Contains('client-loaded check') })
$center = [regex]::Match($scan[$marker + 1], 'scan around (\d+),(\d+),(\d+)')
$cx, $cy = [int]$center.Groups[1].Value, [int]$center.Groups[2].Value
$dumpCenter = [regex]::Match($dump[0], 'walkability around (\d+),(\d+),\d+ radius (\d+)')
$mx, $my, $radius = [int]$dumpCenter.Groups[1].Value, [int]$dumpCenter.Groups[2].Value, [int]$dumpCenter.Groups[3].Value
$agree = 0; $cells = 0
foreach ($line in $scan[($marker + 2)..($marker + 26)]) {
    $row = [regex]::Match($line, '^\s*([+-]?\d+) (\S+)$')
    if (!$row.Success) { continue }
    $dy = [int]$row.Groups[1].Value
    $marks = $row.Groups[2].Value
    for ($column = 0; $column -lt $marks.Length; $column++) {
        if ($marks[$column] -eq '?') { continue }
        $x = $cx - 12 + $column; $y = $cy + $dy
        $mapWalkable = $dump[1 + $y - $my + $radius][5 + $x - $mx + $radius] -eq '.'
        $cells++
        if ($mapWalkable -eq ($marks[$column] -ne '#')) { $agree++ }
    }
}
"map / live client scan: $cells cells, agree $agree, disagree $($cells - $agree)"
$terrainPath = Join-Path $repo 'src/terrain.spi'
$terrain = [Collections.Generic.List[string]]::new([string[]](Get-Content $terrainPath))
$differ = @()
for ($k = 0; $k -lt $generated.Count; $k += 2) {
    $name = ($generated[$k] -split ' ')[1]
    $at = $terrain.FindIndex([Predicate[string]] { param($line) $line.StartsWith("let $name ") })
    if ($at -lt 0) { throw "map / src/terrain.spi has no definition of $name" }
    if ($terrain[$at] -ne $generated[$k] -or $terrain[$at + 1] -ne $generated[$k + 1]) {
        $differ += $name
        $terrain[$at] = $generated[$k]
        $terrain[$at + 1] = $generated[$k + 1]
    }
}
if (!$differ) { "map / src/terrain.spi matches the server map ($($generated.Count / 2) definitions)"; return }
if ($Update) {
    [IO.File]::WriteAllText($terrainPath, ($terrain -join "`n") + "`n")
    "map / rewrote $($differ -join ', ') in src/terrain.spi from the server map"
} else {
    throw "map / src/terrain.spi differs from the server map in $($differ -join ', '); rerun with -Update to rewrite them"
}
