param(
    [string[]] $Traces = @(),
    [string] $LiveLogs = '',
    [string] $LivePattern = '*hunter*.log',
    [string] $Listing = (Join-Path $PSScriptRoot '../target/map/floor-changes.txt')
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '../live/paths.ps1')
if (!$LiveLogs) { $LiveLogs = $TibiaLogs }
$kit = Join-Path $env:LOCALAPPDATA 'kit\bin\kit.exe'
$zone = "$((Resolve-Path $Listing).Path):^(?<value>\d+,\d+) protection-zone$"
function Measure-Seen([string[]] $paths, [string[]] $sections) {
    $rows = @()
    if ($paths) {
        $out = @(& $kit table sequences @paths @sections --count 'samples=seen at \d+,\d+:' `
            --count 'knight=seen at (?<value>\d+,\d+):' --in-set "knight=$zone" `
            --count 'monsters= (?<value>\d+,\d+)' --count-in 'monsters=seen at \d+,\d+:(?<rest>.*)$' --in-set "monsters=$zone" 2>&1 |
            ForEach-Object { "$_" })
        if ($LASTEXITCODE) { $out | Select-Object -Last 3; throw "pz-in-traces: kit table sequences exited $LASTEXITCODE" }
        $rows = @($out | Where-Object { $_ -and $_ -notmatch '^kit table ' } | ConvertFrom-Csv -Delimiter "`t")
    }
    [pscustomobject]@{
        runs = [math]::Max($rows.Count, 1)
        runs_touching_zone = @($rows | Where-Object { [int]$_.knight + [int]$_.monsters -gt 0 }).Count
        samples = ($rows | Measure-Object samples -Sum).Sum + 0
        knight_in_zone = ($rows | Measure-Object knight -Sum).Sum + 0
        monster_in_zone = ($rows | Measure-Object monsters -Sum).Sum + 0
    }
}
foreach ($trace in $Traces) {
    $r = Measure-Seen @($trace) @('--section-on', '^== (?<section>.*)$')
    "model $([IO.Path]::GetFileName($trace)): runs $($r.runs), runs touching a protection zone $($r.runs_touching_zone), samples $($r.samples), knight samples in zone $($r.knight_in_zone), monster positions in zone $($r.monster_in_zone)"
}
$live = @(Get-ChildItem $LiveLogs -Filter $LivePattern)
$r = Measure-Seen @($live.FullName) @()
"live $LivePattern ($($live.Count) logs): runs touching a protection zone $($r.runs_touching_zone), samples $($r.samples), knight samples in zone $($r.knight_in_zone), monster positions in zone $($r.monster_in_zone)"
