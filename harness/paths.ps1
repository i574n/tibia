$TibiaHarness = $PSScriptRoot
$TibiaRepo = Split-Path $PSScriptRoot -Parent
$TibiaResults = Join-Path $TibiaRepo 'results'
$TibiaWorld = if ($env:TIBIA_WORLD) { $env:TIBIA_WORLD } else { Join-Path $HOME 'tibia-local' }
$TibiaLogs = Join-Path $TibiaWorld 'arena-logs'
$MariaDbBin = if ($env:TIBIA_MARIADB_BIN) { $env:TIBIA_MARIADB_BIN } else { Join-Path $HOME 'scoop\apps\mariadb\current\bin' }
$SpiralRoot = @($env:SPIRAL_ROOT, (Join-Path $TibiaRepo 'deps/spiral'), (Join-Path (Split-Path $TibiaRepo -Parent) 'spiral')) |
    Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
