param([string] $Results = (Join-Path (Split-Path $PSScriptRoot -Parent) 'results\arena-results-cyclops.tsv'), [string] $Monster = 'cyclops', [datetime] $Since = [datetime]::MinValue)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
$logDir = $TibiaLogs

function Get-Spread([double[]] $values) {
    if ($values.Count -eq 0) { return [pscustomobject]@{ Mean = [double]::NaN; Sd = [double]::NaN } }
    $mean = ($values | Measure-Object -Average).Average
    $sd = if ($values.Count -gt 1) { [Math]::Sqrt((($values | ForEach-Object { ($_ - $mean) * ($_ - $mean) }) | Measure-Object -Sum).Sum / ($values.Count - 1)) } else { 0 }
    [pscustomobject]@{ Mean = $mean; Sd = $sd }
}

$rows = Import-Csv $Results -Delimiter "`t" | Where-Object { [datetime]$_.timestamp -ge $Since }
$taken = @{}
Get-ChildItem $logDir -Filter "*-$Monster-*.log" | ForEach-Object {
    $parts = $_.BaseName -split "-$Monster-"
    $competitor = $parts[1] -replace '-\d+$', ''
    $stamp = [datetime]::ParseExact($parts[0], 'yyyyMMdd-HHmmss', $null)
    if ($stamp -ge $Since) {
        $hits = @(Select-String -Path $_.FullName -Pattern 'You lose (\d+) hitpoints? due to an attack' | ForEach-Object { [int]$_.Matches[0].Groups[1].Value })
        if ($hits.Count -gt 0) {
            if (-not $taken[$competitor]) { $taken[$competitor] = @() }
            $taken[$competitor] += ($hits | Measure-Object -Sum).Sum
        }
    }
}

$rows | Group-Object competitor | ForEach-Object {
    $group = $_.Group
    $cleared = @($group | Where-Object { $_.cleared_ms } | ForEach-Object { [double]$_.cleared_ms / 1000 })
    $clear = Get-Spread $cleared
    $potions = Get-Spread @($group | ForEach-Object { [double]$_.potions })
    $damage = Get-Spread @($taken[$_.Name] | ForEach-Object { [double]$_ })
    [pscustomobject]@{
        competitor = $_.Name
        runs = $group.Count
        cleared = "$($cleared.Count)/$($group.Count)"
        clear_s = '{0:N1} +- {1:N1}' -f $clear.Mean, $clear.Sd
        potions = '{0:N1} +- {1:N1}' -f $potions.Mean, $potions.Sd
        damage_taken = if ($taken[$_.Name]) { '{0:N0} +- {1:N0} ({2} logs)' -f $damage.Mean, $damage.Sd, $taken[$_.Name].Count } else { 'no damage lines' }
        lowest_health = [int]($group | ForEach-Object { [int]$_.lowest_health } | Measure-Object -Minimum).Minimum
        deaths = [int]($group | ForEach-Object { [int]$_.deaths } | Measure-Object -Sum).Sum
    }
} | Format-Table -AutoSize | Out-String -Width 200
