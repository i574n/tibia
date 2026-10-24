param([string] $Results = (Join-Path (Split-Path $PSScriptRoot -Parent) 'results\arena-results-cyclops.tsv'), [string] $Monster = 'cyclops', [datetime] $Since = [datetime]::MinValue)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
$eoie = (Get-Command eoie -ErrorAction Ignore).Source ?? 'C:\home\git\eoie\eoie.exe'

& $eoie table query $Results --group competitor --count cleared_ms --mean cleared_ms,potions --sd cleared_ms,potions --min lowest_health --sum deaths
if ($LASTEXITCODE -ne 0) { throw "arena-summary / eoie table query failed ($LASTEXITCODE)" }

$logs = @(Get-ChildItem $TibiaLogs -Filter "*-$Monster-*.log" | Where-Object {
    $parts = $_.BaseName -split "-$Monster-"
    $parts.Count -ge 2 -and [datetime]::ParseExact($parts[0], 'yyyyMMdd-HHmmss', $null) -ge $Since
} | ForEach-Object FullName)
if (!$logs) { "damage taken / no $Monster logs since $($Since.ToString('s'))"; return }
$damage = Join-Path (New-Item -ItemType Directory -Force (Join-Path $TibiaRepo 'target/summary')).FullName "damage-$Monster.tsv"
& $eoie table logs @logs --field competitor="-$Monster-(.+)-\d+\.log$" --sum damage='You lose (\d+) hitpoints? due to an attack' --out $damage | Out-Null
if ($LASTEXITCODE -ne 0) { throw "arena-summary / eoie table logs failed ($LASTEXITCODE)" }
"damage taken since $($Since.ToString('s')), logs with at least one hit:"
& $eoie table query $damage --where 'damage>0' --group competitor --count damage --mean damage --sd damage
