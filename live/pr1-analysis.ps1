param([string] $Results = (Join-Path (Split-Path $PSScriptRoot -Parent) 'results\arena-results-cyclops-pr1.tsv'), [string] $Treatment = 'spiral-retreat', [string] $Baseline = 'vbot', [int] $Planned = 60, [string] $Label = 'PR-1', [switch] $ExcludeForeign)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
$logDir = $TibiaLogs

function Get-Summary([double[]] $values) {
    $n = $values.Count
    $mean = ($values | Measure-Object -Average).Average
    $variance = (($values | ForEach-Object { ($_ - $mean) * ($_ - $mean) }) | Measure-Object -Sum).Sum / ($n - 1)
    [pscustomobject]@{ N = $n; Mean = $mean; Variance = $variance; Sd = [Math]::Sqrt($variance) }
}

function Get-StudentQuantile([double] $df) {
    $z = 1.959963984540054
    $g1 = ($z * $z * $z + $z) / 4
    $g2 = (5 * [Math]::Pow($z, 5) + 16 * $z * $z * $z + 3 * $z) / 96
    $g3 = (3 * [Math]::Pow($z, 7) + 19 * [Math]::Pow($z, 5) + 17 * $z * $z * $z - 15 * $z) / 384
    $z + $g1 / $df + $g2 / ($df * $df) + $g3 / ($df * $df * $df)
}

function Get-Welch([double[]] $a, [double[]] $b) {
    $x = Get-Summary $a
    $y = Get-Summary $b
    $se2 = $x.Variance / $x.N + $y.Variance / $y.N
    $se = [Math]::Sqrt($se2)
    $df = $se2 * $se2 / ([Math]::Pow($x.Variance / $x.N, 2) / ($x.N - 1) + [Math]::Pow($y.Variance / $y.N, 2) / ($y.N - 1))
    $q = Get-StudentQuantile $df
    $difference = $x.Mean - $y.Mean
    [pscustomobject]@{ A = $x; B = $y; Difference = $difference; T = $difference / $se; Df = $df; Low = $difference - $q * $se; High = $difference + $q * $se; Critical = $q }
}

$rows = Import-Csv $Results -Delimiter "`t"
if ($ExcludeForeign) {
    $foreignRows = @($rows | Where-Object { ($_.foreign_potions -and [int]$_.foreign_potions -gt 0) -or ($_.foreign_actions -and [int]$_.foreign_actions -gt 0) })
    "excluded for foreign activity (arena failures): $($foreignRows.Count)" + $(if ($foreignRows.Count) { ' -> ' + (($foreignRows | ForEach-Object { "$($_.competitor) $($_.timestamp)" }) -join ', ') } else { '' })
    $rows = @($rows | Where-Object { $foreignRows -notcontains $_ })
}
$treatmentRows = @($rows | Where-Object competitor -eq $Treatment)
$baselineRows = @($rows | Where-Object competitor -eq $Baseline)
"$Label analysis of $Results"
"runs: $Treatment $($treatmentRows.Count), $Baseline $($baselineRows.Count) (pre-registered: $Planned each)"

$primary = Get-Welch @($treatmentRows | ForEach-Object { [double]$_.potions }) @($baselineRows | ForEach-Object { [double]$_.potions })
"PRIMARY potions: {0} {1:N2} +- {2:N2} vs {3} {4:N2} +- {5:N2}; difference {6:N2} (95% CI {7:N2} .. {8:N2}); Welch t {9:N2}, df {10:N1}, two-sided critical {11:N2}" -f $Treatment, $primary.A.Mean, $primary.A.Sd, $Baseline, $primary.B.Mean, $primary.B.Sd, $primary.Difference, $primary.Low, $primary.High, $primary.T, $primary.Df, $primary.Critical
$verdict = if ($primary.High -lt 0) { "SIGNIFICANT: $Treatment uses fewer potions" } elseif ($primary.Low -gt 0) { "SIGNIFICANT: $Treatment uses more potions" } else { 'NO DIFFERENCE SHOWN' }
"VERDICT (pre-registered, alpha 0.05): $verdict"

"secondary, descriptive only:"
$cleared = Get-Welch @($treatmentRows | Where-Object { $_.cleared_ms } | ForEach-Object { [double]$_.cleared_ms / 1000 }) @($baselineRows | Where-Object { $_.cleared_ms } | ForEach-Object { [double]$_.cleared_ms / 1000 })
"  clear time s: {0:N1} vs {1:N1} (difference {2:N1}, CI {3:N1} .. {4:N1})" -f $cleared.A.Mean, $cleared.B.Mean, $cleared.Difference, $cleared.Low, $cleared.High
"  deaths: {0} vs {1}; cleared: {2}/{3} vs {4}/{5}" -f (($treatmentRows | ForEach-Object { [int]$_.deaths }) | Measure-Object -Sum).Sum, (($baselineRows | ForEach-Object { [int]$_.deaths }) | Measure-Object -Sum).Sum, @($treatmentRows | Where-Object { $_.cleared_ms }).Count, $treatmentRows.Count, @($baselineRows | Where-Object { $_.cleared_ms }).Count, $baselineRows.Count
"  lowest health: {0:N1} vs {1:N1}" -f (Get-Summary @($treatmentRows | ForEach-Object { [double]$_.lowest_health })).Mean, (Get-Summary @($baselineRows | ForEach-Object { [double]$_.lowest_health })).Mean

$first = [datetime](($rows | Select-Object -First 1).timestamp)
$damage = @{}
foreach ($log in Get-ChildItem $logDir -Filter '*-cyclops-*.log' | Where-Object { $_.LastWriteTime -ge $first.AddMinutes(-5) }) {
    $competitor = if ($log.Name -match '-cyclops-(.+)-\d+\.log$') { $Matches[1] } else { '' }
    $stamp = [datetime]::ParseExact(($log.Name -split '-cyclops-')[0], 'yyyyMMdd-HHmmss', $null).ToString('s')
    if ($rows | Where-Object { $_.timestamp -eq $stamp -and $_.competitor -eq $competitor }) {
        $damage["$competitor|$stamp"] = (Select-String -Path $log.FullName -Pattern 'You lose (\d+) hitpoints? due to an attack' | ForEach-Object { [int]$_.Matches[0].Groups[1].Value } | Measure-Object -Sum).Sum
    }
}
$taken = @($damage.Keys | Where-Object { $_ -like "$Treatment|*" } | ForEach-Object { [double]$damage[$_] })
$given = @($damage.Keys | Where-Object { $_ -like "$Baseline|*" } | ForEach-Object { [double]$damage[$_] })
if ($taken.Count -gt 1 -and $given.Count -gt 1) {
    $hurt = Get-Welch $taken $given
    "  damage taken (logs matched to rows: {0} and {1}): {2:N0} vs {3:N0} (difference {4:N0}, CI {5:N0} .. {6:N0})" -f $taken.Count, $given.Count, $hurt.A.Mean, $hurt.B.Mean, $hurt.Difference, $hurt.Low, $hurt.High
}
