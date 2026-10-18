param([string] $Results = (Join-Path (Split-Path $PSScriptRoot -Parent) 'results\arena-results-mixed-pr2.tsv'), [string] $Competitor = 'spiral-policy', [double] $PredictedPotions = 1.23, [double] $PredictedSeconds = 36.2, [int] $Planned = 20, [string] $Label = 'PR-2', [switch] $ExcludeForeign)
$ErrorActionPreference = 'Stop'

function Get-StudentQuantile([double] $df) {
    $z = 1.959963984540054
    $g1 = ($z * $z * $z + $z) / 4
    $g2 = (5 * [Math]::Pow($z, 5) + 16 * $z * $z * $z + 3 * $z) / 96
    $g3 = (3 * [Math]::Pow($z, 7) + 19 * [Math]::Pow($z, 5) + 17 * $z * $z * $z - 15 * $z) / 384
    $z + $g1 / $df + $g2 / ($df * $df) + $g3 / ($df * $df * $df)
}

function Get-OneSample([double[]] $values, [double] $predicted) {
    $n = $values.Count
    $mean = ($values | Measure-Object -Average).Average
    $sd = [Math]::Sqrt((($values | ForEach-Object { ($_ - $mean) * ($_ - $mean) }) | Measure-Object -Sum).Sum / ($n - 1))
    $se = $sd / [Math]::Sqrt($n)
    $critical = Get-StudentQuantile ($n - 1)
    [pscustomobject]@{ N = $n; Mean = $mean; Sd = $sd; T = ($mean - $predicted) / $se; Critical = $critical; Low = $mean - $critical * $se; High = $mean + $critical * $se }
}

$rows = @(Import-Csv $Results -Delimiter "`t" | Where-Object competitor -eq $Competitor)
if ($ExcludeForeign) {
    $foreignRows = @($rows | Where-Object { ($_.foreign_potions -and [int]$_.foreign_potions -gt 0) -or ($_.foreign_actions -and [int]$_.foreign_actions -gt 0) })
    "excluded for foreign activity (arena failures): $($foreignRows.Count)" + $(if ($foreignRows.Count) { ' -> ' + (($foreignRows | ForEach-Object { "$($_.competitor) $($_.timestamp)" }) -join ', ') } else { '' })
    $rows = @($rows | Where-Object { $foreignRows -notcontains $_ })
}
"$Label analysis of $Results"
"runs: $Competitor $($rows.Count) (pre-registered: $Planned)"
$potions = Get-OneSample @($rows | ForEach-Object { [double]$_.potions }) $PredictedPotions
$cleared = @($rows | Where-Object { $_.cleared_ms })
$seconds = Get-OneSample @($cleared | ForEach-Object { [double]$_.cleared_ms / 1000 }) $PredictedSeconds
"potions per clear: live {0:N2} +- {1:N2} (95% CI {2:N2} .. {3:N2}) vs predicted {4:N2}; t {5:N2}, two-sided critical {6:N2}" -f $potions.Mean, $potions.Sd, $potions.Low, $potions.High, $PredictedPotions, $potions.T, $potions.Critical
"clear time s: live {0:N1} +- {1:N1} (95% CI {2:N1} .. {3:N1}) vs predicted {4:N1}; t {5:N2}, two-sided critical {6:N2}; cleared {7}/{8}" -f $seconds.Mean, $seconds.Sd, $seconds.Low, $seconds.High, $PredictedSeconds, $seconds.T, $seconds.Critical, $cleared.Count, $rows.Count
"deaths: {0}" -f (($rows | ForEach-Object { [int]$_.deaths }) | Measure-Object -Sum).Sum
$within = [Math]::Abs($potions.T) -le $potions.Critical -and [Math]::Abs($seconds.T) -le $seconds.Critical
"VERDICT (pre-registered, alpha 0.05): " + $(if ($within) { 'the simulator predicts the mixed clear' } else { 'FIDELITY GAP: ' + ((@($(if ([Math]::Abs($potions.T) -gt $potions.Critical) { 'potions' }), $(if ([Math]::Abs($seconds.T) -gt $seconds.Critical) { 'clear time' })) | Where-Object { $_ }) -join ' and ') + ' outside the prediction' })
