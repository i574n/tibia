param([Parameter(Mandatory)] [string] $RunLog, [int] $TimeoutSeconds = 240)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
New-Item -ItemType Directory -Force $TibiaLogs | Out-Null
$huntLog = Join-Path $TibiaLogs "$(Get-Date -Format 'yyyyMMdd-HHmmss')-executor-hunt.log"
$lines = @(& pwsh -NoProfile -File (Join-Path $PSScriptRoot 'run-policy-scenario.ps1') -ExternalWorld -TimeoutSeconds $TimeoutSeconds 2>&1 | ForEach-Object { "$_" })
[IO.File]::WriteAllLines($huntLog, $lines)
$experience = ''
foreach ($line in $lines) { if ($line -match 'experience \+(\d+)') { $experience = $Matches[1] } }
if (-not $experience) { "run-hunt / no experience line; hunt log $huntLog"; exit 1 }
[IO.File]::WriteAllText($RunLog, "experience $experience`n")
"run-hunt / experience $experience; hunt log $huntLog"
