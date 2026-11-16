param(
    [ValidateSet('Start', 'Stop', 'Status')] [string] $Action = 'Status'
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
$root = $TibiaWorld
$mariadb = $MariaDbBin
$dataDir = Join-Path $root 'mariadb-data'
$canaryDir = Join-Path $root 'canary'
$dbPort = 3317

function Test-Database {
    & "$mariadb\mariadb.exe" --host=127.0.0.1 --port=$dbPort -uroot -pcanary -e 'select 1' 2>$null | Out-Null
    $LASTEXITCODE -eq 0
}

function Start-Database {
    if (Test-Database) { return }
    Start-Process "$mariadb\mariadbd.exe" -ArgumentList "--datadir=$dataDir", "--port=$dbPort", '--bind-address=127.0.0.1', '--innodb-buffer-pool-size=128M' -WindowStyle Hidden | Out-Null
    foreach ($attempt in 1..60) {
        Start-Sleep -Milliseconds 500
        if (Test-Database) { return }
    }
    throw "mariadbd did not answer on port $dbPort"
}

function Start-Canary {
    if (Get-Process canary -ErrorAction SilentlyContinue) { return }
    $env:LUA_PATH = $null
    $env:LUA_CPATH = $null
    Start-Process (Join-Path $canaryDir 'canary.exe') -WorkingDirectory $canaryDir -RedirectStandardOutput (Join-Path $canaryDir 'world.log') -RedirectStandardError (Join-Path $canaryDir 'world.err') -WindowStyle Hidden | Out-Null
}

switch ($Action) {
    'Start' {
        Start-Database
        Start-Canary
        "started: mariadb on 127.0.0.1:$dbPort, canary log $canaryDir\world.log (login 127.0.0.1:7171, protocol 1511)"
    }
    'Stop' {
        Get-Process canary -ErrorAction SilentlyContinue | Stop-Process -Force
        Get-Process mariadbd -ErrorAction SilentlyContinue | Where-Object { $_.Path -like "$mariadb*" } | Stop-Process -Force
        'stopped canary and the tibia-local mariadbd'
    }
    'Status' {
        $canary = Get-Process canary -ErrorAction SilentlyContinue
        $db = Test-Database
        "database=$db canary=$([bool]$canary)" + $(if ($canary) { " canaryMB=$([math]::Round($canary.WorkingSet64 / 1MB))" } else { '' })
    }
}
