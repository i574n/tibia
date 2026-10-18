param(
    [datetime] $Since = (Get-Date).AddHours(-1),
    [datetime] $Until = [datetime]::MaxValue,
    [string[]] $Windows = @(),
    [string] $Logs = (Join-Path ($env:TIBIA_WORLD ?? (Join-Path $HOME 'tibia-local')) 'arena-logs')
)
$runs = Get-ChildItem $Logs -Filter '*cyclops*spiral-policy*.log' | Where-Object { $at = $_.LastWriteTime; if ($Windows) { @($Windows | Where-Object { $from, $to = $_ -split '\.\.'; $at -ge [datetime]$from -and $at -le [datetime]$to }).Count -gt 0 } else { $at -ge $Since -and $at -le $Until } } | Sort-Object Name
$rows = foreach ($log in $runs) {
    $lines = Get-Content $log.FullName
    $histogram = $lines | Select-String 'adjacent time by count: 0 (\d+) 1 (\d+) 2 (\d+) 3 (\d+) ms' | Select-Object -Last 1
    if (!$histogram) { continue }
    $byCount = @{ 0 = 0; 1 = 0; 2 = 0; 3 = 0 }
    foreach ($hit in $lines | Select-String 'hit at \d+ ms with (\d+) adjacent') { $n = [Math]::Min(3, [int]$hit.Matches[0].Groups[1].Value); $byCount[$n]++ }
    $damage = ($lines | Select-String 'You lose (\d+) hitpoints? due to an attack by a cyclops' | ForEach-Object { [int]$_.Matches[0].Groups[1].Value } | Measure-Object -Sum -Average)
    $g = $histogram.Matches[0].Groups
    $clear = $lines | Select-String 'cleared at (\d+) ms' | Select-Object -Last 1
    [pscustomobject]@{
        Log = $log.Name
        Zero = [int]$g[1].Value / 1000; One = [int]$g[2].Value / 1000; Two = [int]$g[3].Value / 1000; Three = [int]$g[4].Value / 1000
        Clear = if ($clear) { [int]$clear.Matches[0].Groups[1].Value / 1000 } else { $null }
        Hits = $damage.Count; PerHit = [math]::Round($damage.Average, 2)
        HitsAt1 = $byCount[1]; HitsAt2 = $byCount[2]; HitsAt3 = $byCount[3]
    }
}
$rows | Format-Table -AutoSize | Out-String -Width 200
if ($rows) {
    $mean = { param($name) [math]::Round(($rows | Measure-Object $name -Average).Average, 1) }
    "runs $(@($rows).Count): seconds adjacent per clear by count 0 $(& $mean 'Zero') / 1 $(& $mean 'One') / 2 $(& $mean 'Two') / 3 $(& $mean 'Three'); landed hits $(& $mean 'Hits') at $(& $mean 'PerHit') per hit; hits while 1/2/3 adjacent $(& $mean 'HitsAt1') / $(& $mean 'HitsAt2') / $(& $mean 'HitsAt3')"
}
if (@($rows).Count -gt 1) {
    foreach ($name in 'Three', 'Clear', 'Hits', 'PerHit') {
        $s = $rows | Measure-Object $name -Average -StandardDeviation
        "{0}: mean {1:N2} sd {2:N2} se {3:N2}" -f $name, $s.Average, $s.StandardDeviation, ($s.StandardDeviation / [math]::Sqrt($s.Count))
    }
}
