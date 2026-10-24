param(
    [string[]] $Traces = @(),
    [string] $LiveLogs = '',
    [string] $LivePattern = '*hunter*.log',
    [string] $Listing = (Join-Path $PSScriptRoot '../target/map/floor-changes.txt')
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '../live/paths.ps1')
if (!$LiveLogs) { $LiveLogs = $TibiaLogs }
$zone = @{}
foreach ($line in Get-Content $Listing) {
    $m = [regex]::Match($line, '^(\d+),(\d+) protection-zone$')
    if ($m.Success) { $zone["$($m.Groups[1].Value),$($m.Groups[2].Value)"] = $true }
}
function Measure-Seen([string[]] $lines) {
    $runs = 0; $runsTouching = 0; $knight = 0; $monsters = 0; $samples = 0; $touched = $false
    foreach ($line in $lines) {
        if ($line -match '^== ') { if ($touched) { $runsTouching++ }; $runs++; $touched = $false; continue }
        $seen = [regex]::Match($line, 'seen at (\d+),(\d+):(.*)$')
        if (!$seen.Success) { continue }
        $samples++
        if ($zone["$($seen.Groups[1].Value),$($seen.Groups[2].Value)"]) { $knight++; $touched = $true }
        foreach ($m in [regex]::Matches($seen.Groups[3].Value, ' (\d+),(\d+)')) {
            if ($zone["$($m.Groups[1].Value),$($m.Groups[2].Value)"]) { $monsters++; $touched = $true }
        }
    }
    if ($touched) { $runsTouching++ }
    [pscustomobject]@{ runs = [math]::Max($runs, 1); runs_touching_zone = $runsTouching; samples = $samples; knight_in_zone = $knight; monster_in_zone = $monsters }
}
foreach ($trace in $Traces) {
    $r = Measure-Seen @(Get-Content $trace)
    "model $([IO.Path]::GetFileName($trace)): runs $($r.runs), runs touching a protection zone $($r.runs_touching_zone), samples $($r.samples), knight samples in zone $($r.knight_in_zone), monster positions in zone $($r.monster_in_zone)"
}
$live = @(Get-ChildItem $LiveLogs -Filter $LivePattern)
$liveLines = foreach ($log in $live) { "== $($log.Name)"; Get-Content $log.FullName | Where-Object { $_ -match 'seen at ' } }
$r = Measure-Seen @($liveLines)
"live $LivePattern ($($live.Count) logs): runs touching a protection zone $($r.runs_touching_zone), samples $($r.samples), knight samples in zone $($r.knight_in_zone), monster positions in zone $($r.monster_in_zone)"
