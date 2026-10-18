function Get-ForeignActivity([string[]] $lines) {
    $serverPotions = @($lines | Where-Object { $_ -match 'Using one of \d+ health potions' }).Count
    $ownPotions = @($lines | Where-Object { $_ -match 'heal \(potion\) at health' }).Count
    $ownOther = @($lines | Where-Object { $_ -match 'heal dropped by the action gate|\[tibia-probe\] (approach|strike) |\[tibia-probe\] hold at health' }).Count
    $walks = 0
    foreach ($line in $lines) { if ($line -match 'retreats (\d+) cornered \d+ gated (\d+)') { $walks = [int]$Matches[1] + [int]$Matches[2] } }
    $gated = $null
    foreach ($line in $lines) { if ($line -match 'actions allowed (\d+) dropped (\d+)') { $gated = [int]$Matches[1] + [int]$Matches[2] } }
    [pscustomobject]@{
        ServerPotions = $serverPotions
        OwnPotions = $ownPotions
        ForeignPotions = $serverPotions - $ownPotions
        GatedActions = $gated
        OwnActions = $ownPotions + $ownOther + $walks
        ForeignActions = if ($null -eq $gated) { $null } else { $gated - ($ownPotions + $ownOther + $walks) }
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    . (Join-Path $PSScriptRoot 'paths.ps1')
    $logDir = $TibiaLogs
    Get-ChildItem $logDir -Filter '*-spiral-*.log' | Sort-Object Name | ForEach-Object {
        $activity = Get-ForeignActivity @(Get-Content $_.FullName)
        [pscustomobject]@{ Log = $_.Name; ServerPotions = $activity.ServerPotions; OwnPotions = $activity.OwnPotions; ForeignPotions = $activity.ForeignPotions; GatedActions = $activity.GatedActions; OwnActions = $activity.OwnActions; ForeignActions = $activity.ForeignActions }
    }
}
