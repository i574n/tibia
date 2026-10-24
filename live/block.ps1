param(
    [Parameter(Mandatory)] [string] $Results,
    [string[]] $Ledger = @(),
    [Parameter(Mandatory)] [datetime] $StartBy,
    [string[]] $SecondaryLedger = @(),
    [string] $Label = 'tibia live block',
    [int] $Minutes = 120,
    [Parameter(ValueFromRemainingArguments)] [string[]] $Arena = @()
)
$ErrorActionPreference = 'Stop'
$Ledger = @($Ledger | ForEach-Object { $_ -split ',' } | Where-Object { $_ })
$SecondaryLedger = @($SecondaryLedger | ForEach-Object { $_ -split ',' } | Where-Object { $_ })
. (Join-Path $PSScriptRoot 'paths.ps1')
$eoie = (Get-Command eoie -ErrorAction Ignore).Source ?? 'C:\home\git\eoie\eoie.exe'
$table = Join-Path $TibiaResults $Results
$ledgerDir = Join-Path $TibiaRepo 'target\ledger'
$wait = [int][math]::Floor(($StartBy - (Get-Date)).TotalMinutes)
if ($wait -lt 1) { "block / past $($StartBy.ToString('HH:mm')) before the window request, skipped"; return }
"block / $Label / requesting a live-gui window, waiting at most $wait min"
& $eoie window run live-gui $Minutes --label $Label --wait $wait -- pwsh -NoProfile -File (Join-Path $TibiaLive 'run-arena.ps1') @Arena -Out $table
"block / window run exit $LASTEXITCODE at $(Get-Date -Format s)"
if (!(Test-Path $table)) { "block / no results table: the block did not run"; return }
foreach ($id in $Ledger) { & $eoie experiment analyze $ledgerDir $id $table }
$rows = @(Import-Csv $table -Delimiter "`t")
$logs = @(foreach ($row in $rows) {
    $stamp = [datetime]$row.timestamp
    Get-ChildItem $TibiaLogs -Filter "*-$($row.monster)-$($row.competitor)-$($row.run).log" |
        Where-Object { [math]::Abs(([datetime]::ParseExact($_.Name.Substring(0, 15), 'yyyyMMdd-HHmmss', $null) - $stamp).TotalSeconds) -le 5 } |
        Select-Object -First 1 -ExpandProperty FullName
})
"block / secondary, descriptive: $($logs.Count) logs for $($rows.Count) rows"
$boosted = @($logs | ForEach-Object { Select-String -LiteralPath $_ -Pattern 'boosted creature: ([^.]+)\.' | Select-Object -First 1 } | ForEach-Object { $_.Matches[0].Groups[1].Value } | Sort-Object -Unique)
"block / boosted creature in these logs: $(if ($boosted.Count) { $boosted -join ', ' } else { 'none logged' })"
$spawnedKinds = @($Arena | Where-Object { $_ -match '^(troll|cyclops|hunter)$' }) + @('Troll', 'Cyclops')
if (@($boosted | Where-Object { $spawnedKinds -contains $_ }).Count) { "block / WARNING: a spawned kind was boosted, so respawns ran twice as fast (spawn_monster.cpp boostedrate); spawn-based results are not comparable" }
$secondary = Join-Path $TibiaResults ([IO.Path]::GetFileNameWithoutExtension($Results) + '-secondary.tsv')
& $eoie table logs @logs --field arm='-(spiral-\w+|\w+)-\d+\.log' --count steps='step away from' --count taken='You lose \d+ hitpoints due to an attack' --count potions='Using one of \d+ health potions' --out $secondary
& $eoie table query $secondary --group arm --count file --mean steps,taken,potions --sd steps,taken
foreach ($id in $SecondaryLedger) { & $eoie experiment analyze $ledgerDir $id $secondary }
