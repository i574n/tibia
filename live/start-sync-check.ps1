param(
    [Parameter(Mandatory)] [string[]] $Logs
)
$ErrorActionPreference = 'Stop'

$failed = 0
foreach ($log in $Logs) {
    $start = $null
    $firstAction = $null
    $firstActionText = ''
    foreach ($line in Get-Content $log) {
        if ($null -eq $start -and $line -match 'client bot starts @t\+(-?\d+)') { $start = [int]$Matches[1]; continue }
        if ($null -eq $firstAction -and $line -match 'server text \[\d+\]: (.*(due to your attack|health potion|You see).*) @t\+(-?\d+)') {
            $firstAction = [int]$Matches[3]
            $firstActionText = $Matches[1]
        }
    }
    $verdict = if ($null -eq $start) { 'NO START LINE' } elseif ($null -eq $firstAction) { 'no bot action logged' } elseif ($firstAction -ge $start) { 'ok' } else { 'EARLY' }
    if ($verdict -ne 'ok') { $failed++ }
    "{0}: bot start t+{1} ms, first action t+{2} ms ({3}): {4}" -f (Split-Path $log -Leaf), $start, $firstAction, $firstActionText, $verdict
}
if ($failed) { throw "start-sync check: $failed of $(@($Logs).Count) logs not ok" }
