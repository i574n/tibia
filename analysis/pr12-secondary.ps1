param(
    [string] $Logs = '',
    [datetime] $From = '2026-10-18 15:42',
    [datetime] $To = '2026-10-20 09:26',
    [string[]] $Competitors = @('spiral-retreat', 'nexbot'),
    [int] $WindowMs = 10000
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '../live/paths.ps1')
if (!$Logs) { $Logs = $TibiaLogs }
foreach ($competitor in $Competitors) {
    $files = @(Get-ChildItem $Logs -Filter "*-cyclops-$competitor-*.log" | Where-Object { $_.LastWriteTime -ge $From -and $_.LastWriteTime -le $To })
    $early = [Collections.Generic.List[int]]::new()
    $late = [Collections.Generic.List[int]]::new()
    $floorChanges = 0
    $unstarted = 0
    foreach ($file in $files) {
        $started = $false
        $startMs = 0
        $hitsEarly = 0
        $hitsLate = 0
        $belowGround = $false
        foreach ($line in Get-Content $file.FullName) {
            if ($line -match '(\d+),(\d+),6\b') { $belowGround = $true }
            $botStart = [regex]::Match($line, 'client bot starts @t\+(\d+)')
            if ($botStart.Success) { $started = $true; $startMs = [int]$botStart.Groups[1].Value; continue }
            if ($line -match 'policy starts at ') { $started = $true; $startMs = 0; continue }
            if (!$started) { continue }
            $hit = [regex]::Match($line, 'You lose \d+ hitpoints due to an attack by .*@t\+(\d+)')
            if (!$hit.Success) { continue }
            if ([int]$hit.Groups[1].Value - $startMs -lt $WindowMs) { $hitsEarly++ } else { $hitsLate++ }
        }
        if (!$started) { $unstarted++; continue }
        $early.Add($hitsEarly)
        $late.Add($hitsLate)
        if ($belowGround) { $floorChanges++ }
    }
    $mean = { param($xs) if ($xs.Count) { [math]::Round(($xs | Measure-Object -Average).Average, 2) } else { 'n/a' } }
    "PR-12 secondary / $competitor / logs $($files.Count) (no start marker $unstarted) / hits in the first $($WindowMs / 1000) s $(& $mean $early) per run / hits after $(& $mean $late) per run / runs with a floor change $floorChanges"
}
