param([int] $Runs = 3, [string] $Monster = 'troll', [int] $MonsterCount = 3, [int] $AxeSkill = 30, [int] $Level = 8, [int] $HealBelow = 120, [int] $StrikeAbove = 40, [int] $FullExperience = 90, [int] $TimeoutSeconds = 240, [int] $KiteAt = 3, [int] $RetreatAt = 2, [string[]] $Competitors = @('spiral-policy', 'vbot'), [string] $Out = (Join-Path (Split-Path $PSScriptRoot -Parent) 'results\rows\arena_results.spi'), [string] $SpawnFile = '', [string] $KnightAt = '', [int] $RunMs = 0, [string] $Scenario = '', [string] $Ally = '', [string] $AllyAt = '', [string] $ServerGauge = '')
$ErrorActionPreference = 'Stop'
$Competitors = @($Competitors -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
$root = $PSScriptRoot
. (Join-Path $PSScriptRoot 'paths.ps1')
$scenarioScript = Join-Path $root 'run-policy-scenario.ps1'
$env:TIBIA_ARENA_FULL_EXPERIENCE = "$FullExperience"
if ($RunMs -gt 0) { $env:TIBIA_ARENA_RUN_MS = "$RunMs" }
$label = if ($Scenario) { $Scenario } else { $Monster -replace '[:,]', '_' }
if (-not (Test-Path $Out)) { New-ResultTable $Out "timestamp`tcompetitor`trun`tmonster`tcount`texperience`tcleared_ms`tlowest_health`tactions_allowed`tactions_dropped`tpotions`tgold`tdeaths`tforeign_potions`tforeign_actions" }
. (Join-Path $root 'arena-check.ps1')
$gaugeInstalled = ''
$gaugeTrace = ''
if ($ServerGauge) {
    $canaryDir = Join-Path $TibiaWorld 'canary'
    $gaugeInstalled = Join-Path $canaryDir ('data\scripts\' + (Split-Path $ServerGauge -Leaf))
    $gaugeTrace = Join-Path $canaryDir (([IO.Path]::GetFileNameWithoutExtension($ServerGauge) -replace '_', '-') + '.log')
    if (Test-Path -LiteralPath $gaugeInstalled) { throw "server gauge already installed at $gaugeInstalled; not touching it" }
    if (Test-Path -LiteralPath $gaugeTrace) { Remove-Item -LiteralPath $gaugeTrace }
    Copy-Item -LiteralPath $ServerGauge -Destination $gaugeInstalled
    "server gauge installed: $gaugeInstalled"
}

function Read-Number([string[]] $lines, [string] $pattern) {
    $found = ''
    foreach ($line in $lines) { if ($line -match $pattern) { $found = $Matches[1] } }
    $found
}

function Write-ArenaRow([string[]] $lines, [string] $who) {
    $experience = Read-Number $lines 'experience \+(\d+)'
    $cleared = Read-Number $lines 'cleared at (\d+) ms'
    $lowest = Read-Number $lines 'lowest(?: health)? (\d+)'
    $allowed = Read-Number $lines 'actions allowed (\d+)'
    $dropped = Read-Number $lines 'dropped (\d+)'
    $potions = @($lines | Where-Object { $_ -match 'Using one of \d+ health potions' }).Count
    $gold = ($lines | Where-Object { $_ -match 'Loot of' } | ForEach-Object { [regex]::Matches($_, '\|(\d+) gold coins') | ForEach-Object { [int]$_.Groups[1].Value } } | Measure-Object -Sum).Sum
    $deaths = @($lines | Where-Object { $_ -match 'You are dead' }).Count
    $foreign = if ($who -like 'spiral-*' -or $who -like 'random-control*') { Get-ForeignActivity $lines } else { $null }
    $row = "$(Get-Date -Format s)`t$who`t$run`t$(if ($Scenario) { $Scenario } else { $Monster })`t$MonsterCount`t$experience`t$cleared`t$lowest`t$allowed`t$dropped`t$potions`t$gold`t$deaths`t$(if ($foreign) { $foreign.ForeignPotions })`t$(if ($foreign) { $foreign.ForeignActions })"
    Add-ResultRow $Out $row
    $row
}

try {
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
            $scenarioArgs = @('-NoProfile', '-File', $scenarioScript, '-Monster', $Monster, '-MonsterCount', $MonsterCount, '-AxeSkill', $AxeSkill, '-TimeoutSeconds', $TimeoutSeconds, '-Level', $Level, '-HealBelow', $HealBelow, '-StrikeAbove', $StrikeAbove)
            if ($SpawnFile) { $scenarioArgs += @('-SpawnFile', $SpawnFile) }
            if ($KnightAt) { $scenarioArgs += @('-KnightAt', $KnightAt) }
            if ($Ally) { $scenarioArgs += @('-Ally', $Ally, '-AllyAt', $AllyAt) }
            if ($competitor -eq 'vbot') { $scenarioArgs += @('-GaugeBody', 'vbot', '-Bot', 'vBot') }
            if ($competitor -eq 'nexbot') { $scenarioArgs += @('-GaugeBody', 'nexbot', '-Bot', 'nExBot') }
            if ($competitor -eq 'random-control') { $scenarioArgs += @('-GaugeBody', 'random') }
            foreach ($attempt in 1..2) {
                $lines = @(pwsh @scenarioArgs 2>&1 | ForEach-Object { "$_" })
                $logDir = $TibiaLogs
                New-Item -ItemType Directory -Force $logDir | Out-Null
                $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
                $allyLog = Read-Number $lines '== ally log (.+)$'
                $allyLines = if ($allyLog) { @(Get-Content $allyLog) } else { @() }
                $crashed = (Test-CrashedHunt $lines) -or ($allyLog -and (Test-CrashedHunt $allyLines))
                $tag = if ($crashed) { "crash$attempt-" } else { '' }
                $lines | Set-Content (Join-Path $logDir ("{0}-{1}-{2}-{3}{4}.log" -f $stamp, $label, $competitor, $tag, $run))
                if ($allyLog) { $allyLines | Set-Content (Join-Path $logDir ("{0}-{1}-{2}-ally-{3}{4}.log" -f $stamp, $label, $competitor, $tag, $run)) }
                if ($crashed) {
                    $verdict = if ($attempt -eq 1) { 'rerun once' } else { 'counted as missing' }
                    "== crash rule: $competitor run $run attempt $attempt finished '$(Get-FinishReason $lines)', ally '$(if ($allyLog) { Get-FinishReason $allyLines })': $verdict"
                    continue
                }
                Write-ArenaRow $lines $competitor
                if ($allyLog) { Write-ArenaRow $allyLines "$competitor-ally" }
                break
            }
        }
    }
}
finally {
    if ($gaugeInstalled -and (Test-Path -LiteralPath $gaugeInstalled)) { Remove-Item -LiteralPath $gaugeInstalled; "server gauge removed: $gaugeInstalled" }
    if ($gaugeTrace -and (Test-Path -LiteralPath $gaugeTrace)) {
        $kept = Join-Path $TibiaLogs ("{0}-{1}-{2}" -f (Get-Date -Format 'yyyyMMdd-HHmmss'), $label, (Split-Path $gaugeTrace -Leaf))
        Move-Item -LiteralPath $gaugeTrace -Destination $kept
        "server gauge trace: $kept"
    }
}
