$TibiaLive = $PSScriptRoot
$TibiaRepo = Split-Path $PSScriptRoot -Parent
$TibiaSource = Join-Path $TibiaRepo 'src'
$TibiaResults = Join-Path $TibiaRepo 'results'
$TibiaWorld = if ($env:TIBIA_WORLD) { $env:TIBIA_WORLD } else { Join-Path $HOME 'tibia-local' }
$TibiaLogs = Join-Path $TibiaWorld 'arena-logs'
$MariaDbBin = if ($env:TIBIA_MARIADB_BIN) { $env:TIBIA_MARIADB_BIN } else { Join-Path $HOME 'scoop\apps\mariadb\current\bin' }
$SpiralRoot = @($env:SPIRAL_ROOT, (Join-Path $TibiaRepo 'deps/spiral'), (Join-Path (Split-Path $TibiaRepo -Parent) 'spiral')) |
    Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
$TibiaKit = (Get-Command kit -ErrorAction Ignore).Source ?? (Join-Path $env:LOCALAPPDATA 'kit\bin\kit.exe')
$TibiaArena = Join-Path $TibiaRepo 'apps\arena'

function Read-ResultRows([string] $Table, [string[]] $Columns) {
    $rows = @(& $TibiaKit table query $Table --cols ($Columns -join ',') --limit 1000000 --quiet)
    if ($LASTEXITCODE -ne 0) { throw "paths / kit table query $Table failed ($LASTEXITCODE)" }
    @($rows | ConvertFrom-Csv -Delimiter "`t")
}

function New-ResultTable([string] $Table, [string] $Header) {
    $scratch = Join-Path ([IO.Path]::GetTempPath()) "tibia-table-$PID.tsv"
    [IO.File]::WriteAllText($scratch, "$Header`n")
    & $TibiaKit table to-spi $scratch $Table --whole --open table_rows | Out-Null
    $exit = $LASTEXITCODE
    [IO.File]::Delete($scratch)
    if ($exit -ne 0) { throw "paths / kit table to-spi for $Table failed ($exit)" }
}

function Add-ResultRow([string] $Table, [string] $Row) {
    & $TibiaKit table append $Table --row-tsv $Row | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "paths / kit table append $Table failed ($LASTEXITCODE)" }
}
$TibiaArenaTarget = Join-Path $TibiaRepo 'target\arena'

function Update-ArenaProbes {
    $sources = @(Get-ChildItem $TibiaArena, $TibiaSource -File | Where-Object { $_.Extension -in '.spi', '.toml' })
    $newest = ($sources | Measure-Object LastWriteTimeUtc -Maximum).Maximum
    $outputs = @(Get-ChildItem $TibiaArenaTarget -File -Filter '*.lua' -ErrorAction Ignore)
    $oldest = if ($outputs) { ($outputs | Measure-Object LastWriteTimeUtc -Minimum).Minimum } else { [datetime]::MinValue }
    if ($oldest -lt $newest) { & (Join-Path $TibiaArena 'build.ps1') | Out-Host }
}
