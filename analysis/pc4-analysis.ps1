param(
    [Parameter(Mandatory)] [string[]] $Logs,
    [int] $FormulaMs = 486, [int] $FormulaSlackMs = 60,
    [int] $BaseMs = 702, [int] $BaseSlackMs = 30
)
$ErrorActionPreference = 'Stop'
$kept = [Collections.Generic.List[int]]::new()
$turns = 0
foreach ($log in $Logs) {
    $previousDirection = 0
    $speed = 'unknown'
    foreach ($line in Get-Content $log) {
        $login = [regex]::Match($line, 'in game as .* speed (\S+)')
        if ($login.Success) { $speed = $login.Groups[1].Value }
        $walkStart = [regex]::Match($line, 'knight walk starts at .* speed (\S+)')
        if ($walkStart.Success) { $speed = $walkStart.Groups[1].Value }
        $step = [regex]::Match($line, ' knight-straight step (\d+),(\d+),\d+ -> (\d+),(\d+),\d+; interval after its (\S+) step (\d+) ms')
        if (!$step.Success) { continue }
        $direction = [math]::Sign([int]$step.Groups[3].Value - [int]$step.Groups[1].Value) + 10 * [math]::Sign([int]$step.Groups[4].Value - [int]$step.Groups[2].Value)
        $interval = [int]$step.Groups[6].Value
        if ($step.Groups[5].Value -eq 'knight-straight' -and $direction -eq $previousDirection) { $kept.Add($interval) } else { $turns++ }
        $previousDirection = $direction
    }
    "PC-4 / $([IO.Path]::GetFileName($log)) / client speed when the walk starts $speed"
}
if ($kept.Count -eq 0) { throw 'PC-4 / no knight-straight intervals outside turns' }
$sorted = @($kept | Sort-Object)
$median = if ($sorted.Count % 2) { $sorted[($sorted.Count - 1) / 2] } else { ($sorted[$sorted.Count / 2 - 1] + $sorted[$sorted.Count / 2]) / 2 }
"PC-4 / intervals kept $($sorted.Count), excluded at turns $turns, median $median ms, min $($sorted[0]), max $($sorted[-1])"
$verdict = if ($median -ge $FormulaMs -and $median -le $FormulaMs + $FormulaSlackMs) { "formula speed: the server steps a level-30 knight in about $FormulaMs ms" }
    elseif ([math]::Abs($median - $BaseMs) -le $BaseSlackMs) { "level-8 base speed: about $BaseMs ms; the fast chase pace needs another cause" }
    else { 'neither band: report the value' }
"PC-4 / decision: $verdict"
