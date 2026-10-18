param([int] $Runs = 3, [string] $Monster = 'troll', [int] $MonsterCount = 3, [int] $AxeSkill = 30, [int] $Level = 8, [int] $HealBelow = 120, [int] $StrikeAbove = 40, [int] $FullExperience = 90, [int] $TimeoutSeconds = 240, [int] $KiteAt = 3, [int] $RetreatAt = 2, [string[]] $Competitors = @('spiral-policy', 'vbot'), [string] $Out = (Join-Path (Split-Path $PSScriptRoot -Parent) 'results\arena-results.tsv'))
$ErrorActionPreference = 'Stop'
$Competitors = @($Competitors -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
$root = $PSScriptRoot
. (Join-Path $PSScriptRoot 'paths.ps1')
$scenario = Join-Path $root 'run-policy-scenario.ps1'
$env:TIBIA_ARENA_FULL_EXPERIENCE = "$FullExperience"
$snapshot = Join-Path $env:TEMP ('tibia-arena-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Force $snapshot | Out-Null; Copy-Item (Join-Path $TibiaSource '*') $snapshot -Include '*.spi', 'package.spiproj'
"policy source snapshot: $snapshot"
if (-not (Test-Path $Out)) { "timestamp`tcompetitor`trun`tmonster`tcount`texperience`tcleared_ms`tlowest_health`tactions_allowed`tactions_dropped`tpotions`tgold`tdeaths`tforeign_potions`tforeign_actions" | Set-Content $Out }
. (Join-Path $root 'harness-check.ps1')

function Read-Number([string[]] $lines, [string] $pattern) {
    $found = ''
    foreach ($line in $lines) { if ($line -match $pattern) { $found = $Matches[1] } }
    $found
}

foreach ($run in 1..$Runs) {
    foreach ($competitor in $Competitors) {
        $competitorKiteAt, $competitorRetreatAt, $competitorTargeting = switch ($competitor) {
            'spiral-kiting' { "$KiteAt", '0', 'current' }
            'spiral-retreat' { '0', "$RetreatAt", 'reach' }
            'spiral-retreat-current' { '0', "$RetreatAt", 'current' }
            'spiral-reach' { '0', '0', 'reach' }
            default { '0', '0', 'current' }
        }
        $env:TIBIA_ARENA_KITE_AT = $competitorKiteAt
        $env:TIBIA_ARENA_RETREAT_AT = $competitorRetreatAt
        $env:TIBIA_ARENA_TARGETING = $competitorTargeting
        $scenarioArgs = @('-NoProfile', '-File', $scenario, '-Monster', $Monster, '-MonsterCount', $MonsterCount, '-AxeSkill', $AxeSkill, '-TimeoutSeconds', $TimeoutSeconds, '-TibiaDir', $snapshot, '-Level', $Level, '-HealBelow', $HealBelow, '-StrikeAbove', $StrikeAbove)
        if ($competitor -eq 'vbot') { $scenarioArgs += @('-ProbeBody', 'probe-vbot-body.lua', '-Bot', 'vBot') }
        if ($competitor -eq 'nexbot') { $scenarioArgs += @('-ProbeBody', 'probe-nexbot-body.lua', '-Bot', 'nExBot') }
        if ($competitor -eq 'random-control') { $scenarioArgs += @('-ProbeBody', 'probe-random-body.lua') }
        $lines = @(pwsh @scenarioArgs 2>&1 | ForEach-Object { "$_" })
        $logDir = $TibiaLogs
        New-Item -ItemType Directory -Force $logDir | Out-Null
        $lines | Set-Content (Join-Path $logDir ("{0}-{1}-{2}-{3}.log" -f (Get-Date -Format 'yyyyMMdd-HHmmss'), ($Monster -replace '[:,]', '_'), $competitor, $run))
        $experience = Read-Number $lines 'experience \+(\d+)'
        $cleared = Read-Number $lines 'cleared at (\d+) ms'
        $lowest = Read-Number $lines 'lowest(?: health)? (\d+)'
        $allowed = Read-Number $lines 'actions allowed (\d+)'
        $dropped = Read-Number $lines 'dropped (\d+)'
        $potions = @($lines | Where-Object { $_ -match 'Using one of \d+ health potions' }).Count
        $gold = ($lines | Where-Object { $_ -match 'Loot of' } | ForEach-Object { [regex]::Matches($_, '\|(\d+) gold coins') | ForEach-Object { [int]$_.Groups[1].Value } } | Measure-Object -Sum).Sum
        $deaths = @($lines | Where-Object { $_ -match 'You are dead' }).Count
        $foreign = if ($competitor -like 'spiral-*' -or $competitor -eq 'random-control') { Get-ForeignActivity $lines } else { $null }
        $row = "$(Get-Date -Format s)`t$competitor`t$run`t$Monster`t$MonsterCount`t$experience`t$cleared`t$lowest`t$allowed`t$dropped`t$potions`t$gold`t$deaths`t$(if ($foreign) { $foreign.ForeignPotions })`t$(if ($foreign) { $foreign.ForeignActions })"
        Add-Content $Out $row
        $row
    }
}
