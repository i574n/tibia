$TibiaLive = $PSScriptRoot
$TibiaRepo = Split-Path $PSScriptRoot -Parent
$TibiaSource = Join-Path $TibiaRepo 'src'
$TibiaResults = Join-Path $TibiaRepo 'results'
$TibiaWorld = if ($env:TIBIA_WORLD) { $env:TIBIA_WORLD } else { Join-Path $HOME 'tibia-local' }
$TibiaLogs = Join-Path $TibiaWorld 'arena-logs'
$MariaDbBin = if ($env:TIBIA_MARIADB_BIN) { $env:TIBIA_MARIADB_BIN } else { Join-Path $HOME 'scoop\apps\mariadb\current\bin' }
$SpiralRoot = @($env:SPIRAL_ROOT, (Join-Path $TibiaRepo 'deps/spiral'), (Join-Path (Split-Path $TibiaRepo -Parent) 'spiral')) |
    Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
$TibiaArena = Join-Path $TibiaRepo 'apps\arena'
$TibiaArenaTarget = Join-Path $TibiaRepo 'target\arena'

function Update-ArenaProbes {
    $sources = @(Get-ChildItem $TibiaArena, $TibiaSource -File | Where-Object { $_.Extension -in '.spi', '.spiproj', '.toml' })
    $newest = ($sources | Measure-Object LastWriteTimeUtc -Maximum).Maximum
    $outputs = @(Get-ChildItem $TibiaArenaTarget -File -Filter '*.lua' -ErrorAction Ignore)
    $oldest = if ($outputs) { ($outputs | Measure-Object LastWriteTimeUtc -Minimum).Minimum } else { [datetime]::MinValue }
    if ($oldest -lt $newest) { & (Join-Path $TibiaArena 'build.ps1') | Out-Host }
}
