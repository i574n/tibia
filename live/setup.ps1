param([string] $World = '')
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
if ($World) { $TibiaWorld = $World }
$pins = [ordered]@{
    canary   = 'opentibiabr/canary v3.6.1 data-canary'
    otclient = 'opentibiabr/otclient 4.1'
    client   = 'dudantas/tibia-client 15.13.02dfc3'
    nexbot   = 'mCodex/nExBot 19632d4'
}
$downloads = New-Item -ItemType Directory -Force (Join-Path $TibiaWorld 'downloads\setup')
$aside = Join-Path $TibiaWorld "_replaced-$(Get-Date -Format yyyyMMdd-HHmmss)"

function Test-Pin([string] $dir, [string] $pin) {
    (Test-Path (Join-Path $dir '.setup-pin')) -and (Get-Content (Join-Path $dir '.setup-pin') -Raw).Trim() -eq $pin
}
function Clear-Place([string] $dir) {
    if (-not (Test-Path $dir)) { return }
    $target = Join-Path $aside (Split-Path $dir -Leaf)
    New-Item -ItemType Directory -Force $aside | Out-Null
    Move-Item -LiteralPath $dir $target
    "setup / moved $dir to $target"
}
function Get-Release([string] $repo, [string] $tag, [string] $asset) {
    $file = Join-Path $downloads $asset
    if (-not (Test-Path $file)) {
        gh release download $tag -R $repo -p $asset -D $downloads
        if ($LASTEXITCODE) { throw "setup / $repo $tag $asset download failed" }
    }
    $file
}
function Expand-Fresh([string] $zip, [string] $name) {
    $dir = Join-Path $downloads $name
    if (-not (Test-Path $dir)) { Expand-Archive -LiteralPath $zip -DestinationPath $dir }
    $dir
}

$canary = Join-Path $TibiaWorld 'canary'
if (-not (Test-Pin $canary $pins.canary)) {
    $source = Join-Path $downloads 'canary-v3.6.1-src.zip'
    if (-not (Test-Path $source)) { gh api repos/opentibiabr/canary/zipball/v3.6.1 > $source }
    $tree = @(Get-ChildItem (Expand-Fresh $source 'canary-src') -Directory)[0].FullName
    $release = Expand-Fresh (Get-Release opentibiabr/canary v3.6.1 canary-windows-cmake-release.zip) 'canary-release'
    Clear-Place $canary
    Copy-Item -LiteralPath $tree $canary -Recurse
    Copy-Item (Join-Path $release 'canary.exe') $canary
    $config = (Get-Content (Join-Path $canary 'config.lua.dist') -Raw)
    $settings = [ordered]@{
        dataPackDirectory = '"data-canary"'; mapName = '"canary"'; toggleDownloadMap = 'false'
        mysqlPass = '"canary"'; mysqlDatabase = '"canary"'; mysqlPort = '3317'
    }
    foreach ($key in $settings.Keys) {
        $line = [regex]::new("(?m)^$key = .*$")
        if ($line.Matches($config).Count -ne 1) { throw "setup / config.lua.dist has no single '$key = ' line" }
        $config = $line.Replace($config, "$key = $($settings[$key])")
    }
    [IO.File]::WriteAllText((Join-Path $canary 'config.lua'), $config)
    Set-Content (Join-Path $canary '.setup-pin') $pins.canary
    "setup / canary 3.6.1 with the data-canary datapack (the arena map) in $canary"
}

$client = Join-Path $TibiaWorld 'otclient-src'
if (-not (Test-Pin $client $pins.otclient)) {
    $clone = Join-Path $downloads 'otclient-src'
    if (-not (Test-Path $clone)) { git clone --depth 1 -b 4.1 https://github.com/opentibiabr/otclient $clone; if ($LASTEXITCODE) { throw 'setup / otclient clone failed' } }
    $binary = Expand-Fresh (Get-Release opentibiabr/otclient 4.1 otclient-windows-solution-opengl.zip) 'otclient-release'
    $assets = Join-Path (Expand-Fresh (Get-Release dudantas/tibia-client 15.13.02dfc3 tibia-client-15.13.02dfc3.zip) 'tibia-client') 'assets'
    Clear-Place $client
    Copy-Item -LiteralPath $clone $client -Recurse
    Copy-Item (Join-Path $binary 'otclient_gl_x64.exe') $client
    $things = New-Item -ItemType Directory -Force (Join-Path $client 'data\things\1511')
    Copy-Item (Join-Path $assets '*') $things -Recurse
    Set-Content (Join-Path $client '.setup-pin') $pins.otclient
    "setup / otclient 4.1 with the 15.13 client assets in $client"
}

$nexbot = Join-Path $TibiaWorld 'bots\nExBot-19632d4'
if (-not (Test-Pin $nexbot $pins.nexbot)) {
    $clone = Join-Path $downloads 'nExBot'
    if (-not (Test-Path $clone)) { git clone https://github.com/mCodex/nExBot $clone; if ($LASTEXITCODE) { throw 'setup / nExBot clone failed' } }
    git -C $clone checkout -q 19632d4
    if ($LASTEXITCODE) { throw 'setup / nExBot 19632d4 checkout failed' }
    Clear-Place $nexbot
    New-Item -ItemType Directory -Force $nexbot | Out-Null
    Get-ChildItem -LiteralPath $clone -Force | Where-Object Name -ne '.git' | Copy-Item -Destination $nexbot -Recurse
    Set-Content (Join-Path $nexbot '.setup-pin') $pins.nexbot
    "setup / nExBot 19632d4 in $nexbot"
}

$dataDir = Join-Path $TibiaWorld 'mariadb-data'
if (-not (Test-Path $dataDir)) {
    & (Join-Path $MariaDbBin 'mariadb-install-db.exe') "--datadir=$dataDir" '--password=canary' '--port=3317' | Out-Host
    if ($LASTEXITCODE) { throw 'setup / mariadb-install-db failed' }
    $server = Start-Process (Join-Path $MariaDbBin 'mariadbd.exe') -ArgumentList "--datadir=$dataDir", '--port=3317', '--bind-address=127.0.0.1' -WindowStyle Hidden -PassThru
    try {
        $sql = { param($q) & (Join-Path $MariaDbBin 'mariadb.exe') --host=127.0.0.1 --port=3317 -uroot -pcanary -e $q 2>$null; $LASTEXITCODE -eq 0 }
        foreach ($attempt in 1..60) { if (& $sql 'select 1') { break }; Start-Sleep -Milliseconds 500 }
        if (-not (& $sql 'create database canary')) { throw 'setup / create database canary failed' }
        if (-not (& $sql "use canary; source $((Join-Path $canary 'schema.sql').Replace('\', '/'))")) { throw 'setup / schema.sql import failed' }
        "setup / mariadb data with the canary schema in $dataDir"
    } finally { Stop-Process -Id $server.Id -Force }
}
"setup / world ready in $TibiaWorld ($($pins.Values -join ', '))"
