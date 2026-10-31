param(
    [System.Collections.Specialized.OrderedDictionary] $Candidates = [ordered]@{ bundle = @() },
    [double] $Pr17Rules = [double]::NaN,
    [double] $Pr17RulesSe = [double]::NaN,
    [double] $Pr17Retreat = [double]::NaN,
    [double] $Pr17RetreatSe = [double]::NaN
)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $repo 'live/paths.ps1')
$kitPaths = 'C:\home\git\kit\kit.exe', 'C:\home\git\eoie\kit.exe', 'C:\home\git\eoie\eoie.exe'
$kit = (Get-Command kit -ErrorAction Ignore).Source ?? @($kitPaths | Where-Object { Test-Path -LiteralPath $_ })[0]
$scratch = (New-Item -ItemType Directory -Force (Join-Path $repo 'target/score')).FullName

function Get-Moments([object[]] $rows, [string] $group, [string] $column) {
    $table = Join-Path $scratch "$column.tsv"
    $rows | Export-Csv $table -Delimiter "`t" -NoTypeInformation -UseQuotes Never
    $grouping = if ($group -eq 'all') { @() } else { @('--group', $group) }
    $stats = @(& $kit table query $table @grouping --count $column --mean $column --sd $column --quiet | ConvertFrom-Csv -Delimiter "`t" | Where-Object { $_."count_$column" -match '^\d+$' })
    foreach ($s in $stats) { [pscustomobject]@{ group = $s.$group; n = [int]$s."count_$column"; mean = [double]$s."mean_$column"; var = [math]::Pow([double]$s."sd_$column", 2) } }
}
function Get-RetreatLogs([string] $results) {
    foreach ($row in @(Import-Csv (Join-Path $TibiaResults $results) -Delimiter "`t" | Where-Object competitor -eq 'spiral-retreat')) {
        $stamp = [datetime]$row.timestamp
        Get-ChildItem $TibiaLogs -Filter "*-cyclops-spiral-retreat-$($row.run).log" |
            Where-Object { [math]::Abs(([datetime]::ParseExact($_.Name.Substring(0, 15), 'yyyyMMdd-HHmmss', $null) - $stamp).TotalSeconds) -le 5 } |
            Select-Object -First 1 -ExpandProperty FullName
    }
}
function Get-Tables([string] $label, [string[]] $builders, [int] $shield) {
    $rows = @(& (Join-Path $PSScriptRoot 'predict.ps1') -Label $label -Candidate $builders -Shield $shield)
    [pscustomobject]@{
        clear = @($rows | Where-Object { $_ -match '^1\t' } | ConvertFrom-Csv -Delimiter "`t" -Header table, arm, clear, steps, taken, damage, potions, cleared_ms)
        hunter = @($rows | Where-Object { $_ -match '^2\t' } | ConvertFrom-Csv -Delimiter "`t" -Header table, run, kills, cleared, elapsed, potions, taken, damage)
        hunt = @($rows | Where-Object { $_ -match '^3\t' } | ConvertFrom-Csv -Delimiter "`t" -Header table, hunt, kills, taken, damage, potions)
    }
}

$logs = @(Get-RetreatLogs 'arena-results-cyclops-pr12.tsv') + @(Get-RetreatLogs 'arena-results-cyclops-pr16.tsv')
$stepsTable = Join-Path $scratch 'live-steps.tsv'
& $kit table logs @logs --count steps='step away from' --out $stepsTable | Out-Null
$live = Get-Moments @(Import-Csv $stepsTable -Delimiter "`t" | Select-Object steps) all steps

$rows = foreach ($name in $Candidates.Keys) {
    $builders = @($Candidates[$name])
    $s11 = Get-Tables "$name-s11" $builders 11
    $s12 = Get-Tables "$name-s12" $builders 12
    $p11 = @(Get-Moments $s11.clear arm potions)
    $p12 = @(Get-Moments $s12.clear arm potions)
    $mean = { param($set, $arm) ($set | Where-Object group -eq "$arm").mean }
    $targets = [ordered]@{
        'PR-11 rules' = @{ model = (& $mean $p11 0); live = 14.42; se = 0.47; gate = $false }
        'PR-12 retreat' = @{ model = 0.25 * (& $mean $p11 1) + 0.75 * (& $mean $p12 1); live = 12.75; se = 0.46; gate = $false }
        'PR-16 rules' = @{ model = (& $mean $p11 0); live = 14.35; se = 0.650; gate = $true }
        'PR-16 retreat' = @{ model = (& $mean $p11 1); live = 12.45; se = 0.540; gate = $true }
    }
    if (![double]::IsNaN($Pr17Rules)) {
        $targets['PR-17 rules'] = @{ model = (& $mean $p11 0); live = $Pr17Rules; se = $Pr17RulesSe; gate = $true }
        $targets['PR-17 retreat'] = @{ model = (& $mean $p11 1); live = $Pr17Retreat; se = $Pr17RetreatSe; gate = $true }
    }
    $ts = [ordered]@{}
    foreach ($key in $targets.Keys) { $g = $targets[$key]; $ts[$key] = ($g.model - $g.live) / $g.se }
    $gated = @($targets.Keys | Where-Object { $targets[$_].gate } | ForEach-Object { $ts[$_] })
    $model = Get-Moments $s11.clear arm steps | Where-Object group -eq '1'
    $tSteps = ($live.mean - $model.mean) / [math]::Sqrt($live.var / $live.n + $model.var / $model.n)
    $hunter = @($s11.hunter | Where-Object cleared -eq '1').Count
    $kills = Get-Moments @($s12.hunt | Select-Object kills) all kills
    $tKills = ($kills.mean - 12.80) / (1.87 / [math]::Sqrt(10))
    [pscustomobject]@{
        candidate = $name
        t = ($ts.Keys | ForEach-Object { '{0} {1:N2}' -f $_, $ts[$_] }) -join '; '
        a_arms = @($gated | Where-Object { [math]::Abs($_) -gt 2.09 }).Count -eq 0
        steps = '{0:N1}' -f $model.mean; b_steps = [math]::Abs($tSteps) -le 2
        hunter = $hunter; c_hunter = $hunter -ge 45 -and $hunter -le 80
        hunter_hits = '{0:N2}' -f ($s11.hunter | ForEach-Object { [int]$_.taken } | Measure-Object -Average).Average
        hunter_potions = '{0:N2}' -f ($s11.hunter | ForEach-Object { [int]$_.potions } | Measure-Object -Average).Average
        kills = '{0:N2}' -f $kills.mean; d_kills = [math]::Abs($tKills) -le 2.26
        hunt_potions = '{0:N2}' -f ($s12.hunt | ForEach-Object { [int]$_.potions } | Measure-Object -Average).Average
        S = [math]::Round((($gated | ForEach-Object { $_ * $_ }) | Measure-Object -Sum).Sum, 2)
        changes = $builders.Count
    }
}
$rows | Format-List | Out-String -Width 250
$passing = @($rows | Where-Object { $_.a_arms -and $_.b_steps -and $_.c_hunter -and $_.d_kills } | Sort-Object changes, S)
if ($passing) { "D16 / adopt $($passing[0].candidate) (fewest changes, then lowest S $($passing[0].S))" } else { 'D16 / no candidate passes all of (a)-(d); the bundle stays' }
