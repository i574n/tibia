param([string[]] $Logs, [int] $GridMs = 2000, [int] $ToleranceMs = 60, [int] $ThinkMs = 1000)
$onGrid = 0; $offGrid = 0; $stepOnGrid = 0; $stepInWindow = 0; $stepOther = 0; $residuals = @()
foreach ($log in $Logs) {
    $events = foreach ($line in Get-Content $log) {
        if ($line -match 'due to your\s+attack\. @t\+(\d+)') { [pscustomobject]@{ kind = 'hit'; t = [int]$Matches[1] } }
        elseif ($line -match 'step away from .* @t\+(\d+)') { [pscustomobject]@{ kind = 'step'; t = [int]$Matches[1] } }
        elseif ($line -match 'You gained \d+ experience points\. @t\+(\d+)') { [pscustomobject]@{ kind = 'kill'; t = [int]$Matches[1] } }
    }
    $events = @($events | Sort-Object t)
    $previous = $null; $stepped = $false; $killed = $false
    foreach ($e in $events) {
        if ($e.kind -eq 'step') { $stepped = $true; continue }
        if ($e.kind -eq 'kill') { $killed = $true; continue }
        if ($previous -ne $null -and -not $killed) {
            $residual = ($e.t - $previous) % $GridMs
            $grid = $residual -le $ToleranceMs -or $residual -ge $GridMs - $ToleranceMs
            if ($stepped) {
                $residuals += $residual
                if ($grid) { $stepOnGrid++ } elseif ($residual -le $ThinkMs + $ToleranceMs) { $stepInWindow++ } else { $stepOther++ }
            } else {
                if ($grid) { $onGrid++ } else { $offGrid++ }
            }
        }
        $previous = $e.t; $stepped = $false; $killed = $false
    }
}
$plain = $onGrid + $offGrid
$spanning = $stepOnGrid + $stepInWindow + $stepOther
"logs $($Logs.Count)"
"pairs without a step or kill: $plain, on the $GridMs ms grid (+-$ToleranceMs): $onGrid ($(if ($plain) { [math]::Round(100 * $onGrid / $plain, 1) } else { 0 })%)"
"pairs spanning a knight step (no kill): $spanning; on grid $stepOnGrid, late by $ToleranceMs..$($ThinkMs + $ToleranceMs) ms $stepInWindow ($(if ($spanning) { [math]::Round(100 * $stepInWindow / $spanning, 1) } else { 0 })%), other $stepOther"
"step-pair residuals (ms mod $GridMs): $(($residuals | Sort-Object) -join ' ')"
