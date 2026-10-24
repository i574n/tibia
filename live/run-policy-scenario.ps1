param([int] $TimeoutSeconds = 240, [int] $AxeSkill = 30, [string] $Monster = 'troll', [int] $MonsterCount = 3, [string] $ProbeBody = 'competitor', [int] $SpawnRadius = 2, [ValidateSet('none', 'vBot', 'nExBot')] [string] $Bot = 'none', [switch] $NoParity, [string] $TibiaDir = (Join-Path (Split-Path $PSScriptRoot -Parent) 'src'), [int] $Level = 8, [int] $HealBelow = 120, [int] $StrikeAbove = 40, [string] $SummonAt = '1932,1352', [string] $KnightAt = '1932,1349', [string] $SpawnFile = '', [string] $Ally = '', [string] $AllyAt = '')
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'paths.ps1')
$root = $TibiaWorld
$canaryDir = Join-Path $root 'canary'
$worldLog = Join-Path $canaryDir 'world.log'
$mariadb = (Join-Path $MariaDbBin 'mariadb.exe')
$env:SPIRAL_COMPILER_PACKAGE_DIR = (Join-Path $SpiralRoot 'deps\The-Spiral-Language\VS Code Plugin')
$dotnet = "$env:LOCALAPPDATA\spiral-bin\toolchains\dotnet\dotnet.exe"
$compiler = "$env:LOCALAPPDATA\spiral-bin\bin\single-flight\SpiralCompiler\Release\net11.0\SpiralCompiler.dll"

$policyLua = Join-Path $root 'policy.lua'
$frozenPolicy = Join-Path $root 'policy-frozen.lua'
if (Test-Path $frozenPolicy) {
    Copy-Item $frozenPolicy $policyLua -Force
    "== policy: frozen Lua, SHA-256 $((Get-FileHash $policyLua).Hash)"
} else {
    & $dotnet $compiler --backend Lua (Join-Path $TibiaDir 'live.spi') $policyLua | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'live.spi did not compile to Lua' }
}
$probe = Join-Path $root 'probe-policy.lua'
$policySource = [IO.File]::ReadAllText($policyLua)
Update-ArenaProbes
$bodyPath = if ([IO.Path]::IsPathRooted($ProbeBody)) { $ProbeBody } elseif (Test-Path (Join-Path $TibiaArena "$ProbeBody.spi")) { Join-Path $TibiaArenaTarget "$ProbeBody.lua" } else { Join-Path $TibiaLive $ProbeBody }
$body = [IO.File]::ReadAllText($bodyPath)
$parity = if ($NoParity) { '' } else { [IO.File]::ReadAllText((Join-Path $TibiaLive 'parity.lua')) + "`n" }
[IO.File]::WriteAllText($probe, "SpiralPolicy = (function()`n$policySource`nend)()`n$parity$body")
$syntax = lua -e "local f, e = loadfile([[$probe]]); if not f then print(e); os.exit(1) end"
if ($LASTEXITCODE -ne 0) { throw "probe does not parse: $syntax" }
$mix = @(if ($Monster -match ':') { $Monster -split ',' | ForEach-Object { $name, $count = $_ -split ':'; [pscustomobject]@{ Name = $name.Trim(); Count = [int]$count } } } else { [pscustomobject]@{ Name = $Monster; Count = $MonsterCount } })
$summonX, $summonY = $SummonAt -split ','
$knightX, $knightY = $KnightAt -split ','
$env:TIBIA_SUMMON_AT = "$summonX, $summonY"
$env:TIBIA_SUMMON_ORDERS = ($mix | ForEach-Object { '{0},{1},,{2}' -f $_.Name, $_.Count, $SpawnRadius }) -join ';'
$summon = Join-Path $TibiaArenaTarget 'summon.lua'
$kinds = @($mix | ForEach-Object { $_.Name })
$MonsterCount = ($mix | Measure-Object -Property Count -Sum).Sum

Get-Process canary -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 3
& $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary -e 'select 1' 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    Start-Process (Join-Path $MariaDbBin 'mariadbd.exe') -ArgumentList "--datadir=$(Join-Path $root 'mariadb-data')", '--port=3317', '--bind-address=127.0.0.1', '--innodb-buffer-pool-size=128M' -WindowStyle Hidden | Out-Null
    foreach ($attempt in 1..60) {
        Start-Sleep -Milliseconds 500
        & $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary -e 'select 1' 2>$null | Out-Null
        if ($LASTEXITCODE -eq 0) { break }
    }
}
$experience = [long](50 * ([long]$Level * $Level * $Level - 6 * $Level * $Level + 17 * $Level - 12) / 3)
$healthMax = 185 + 15 * ($Level - 8)
$manaMax = 90 + 5 * ($Level - 8)
$env:TIBIA_ARENA_HEAL_BELOW = "$HealBelow"
$env:TIBIA_ARENA_STRIKE_ABOVE = "$StrikeAbove"
& $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary canary -e "update players set level = $Level, experience = $experience, healthmax = $healthMax, health = $healthMax, manamax = $manaMax, mana = $manaMax, skill_axe = $AxeSkill, skill_shielding = 11, skill_shielding_tries = 0, posx = $knightX, posy = $knightY, posz = 7 where name = 'Knight Sample'"
& $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary canary -e "delete pi from player_items pi join players p on p.id = pi.player_id where p.name = 'Knight Sample'; insert into player_items (player_id, pid, sid, itemtype, count, attributes) select p.id, v.pid, v.sid, v.itemtype, v.count, '' from players p join (select 1 as pid, 101 as sid, 3354 as itemtype, 1 as count union all select 3, 102, 2853, 1 union all select 4, 103, 3359, 1 union all select 5, 104, 3425, 1 union all select 6, 105, 7773, 1 union all select 7, 106, 3372, 1 union all select 8, 107, 3552, 1 union all select 11, 108, 23396, 1 union all select 102, 109, 266, 100) v where p.name = 'Knight Sample'"
if ($Ally) {
    $allyX, $allyY = $AllyAt -split ','
    & $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary canary -e "update players set vocation = 4, level = $Level, experience = $experience, healthmax = $healthMax, health = $healthMax, manamax = $manaMax, mana = $manaMax, skill_axe = $AxeSkill, skill_shielding = 11, skill_shielding_tries = 0, posx = $allyX, posy = $allyY, posz = 7 where name = '$Ally'"
    & $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary canary -e "delete pi from player_items pi join players p on p.id = pi.player_id where p.name = '$Ally'; insert into player_items (player_id, pid, sid, itemtype, count, attributes) select p.id, i.pid, i.sid, i.itemtype, i.count, i.attributes from players p, player_items i, players k where k.id = i.player_id and k.name = 'Knight Sample' and p.name = '$Ally'"
}
$env:LUA_PATH = $null
$env:LUA_CPATH = $null
[IO.File]::WriteAllText($worldLog, '')
$serverSpawns = Join-Path $canaryDir 'data-canary\world\canary-monster.xml'
$keptSpawns = "$serverSpawns.kept"
if (Test-Path $keptSpawns) { Move-Item $keptSpawns $serverSpawns -Force }
if ($SpawnFile) {
    Copy-Item $serverSpawns $keptSpawns
    Copy-Item $SpawnFile $serverSpawns -Force
}
$serverConfig = Join-Path $canaryDir 'config.lua'
$keptConfig = "$serverConfig.kept"
if (Test-Path $keptConfig) { Move-Item $keptConfig $serverConfig -Force }
if ($Ally) {
    $configText = [IO.File]::ReadAllText($serverConfig)
    if (-not $configText.Contains('maxPlayersOnlinePerAccount = 1') -or -not $configText.Contains('maxPlayersOutsidePZPerAccount = 1')) { throw 'config.lua lacks the per-account limits the duo raises' }
    Copy-Item $serverConfig $keptConfig
    [IO.File]::WriteAllText($serverConfig, $configText.Replace('maxPlayersOnlinePerAccount = 1', 'maxPlayersOnlinePerAccount = 2').Replace('maxPlayersOutsidePZPerAccount = 1', 'maxPlayersOutsidePZPerAccount = 2'))
}
Start-Process (Join-Path $canaryDir 'canary.exe') -WorkingDirectory $canaryDir -RedirectStandardOutput $worldLog -RedirectStandardError (Join-Path $canaryDir 'world.err') -WindowStyle Hidden | Out-Null
try {
    $deadline = (Get-Date).AddSeconds(120)
    while (-not (Select-String -Path $worldLog -Pattern 'server online!' -Quiet -ErrorAction SilentlyContinue)) {
        if ((Get-Date) -gt $deadline) { throw 'canary did not come online in 120 s' }
        Start-Sleep -Seconds 1
    }
    $clientHome = Join-Path $env:APPDATA 'otcr\otclient\otclient'
    $keptBot = switch ($Bot) { 'vBot' { 'vBot_4.8' } 'nExBot' { 'nExBot' } default { '' } }
    $botNode = if ($keptBot) { "bot:`n  Knight Sample_1511:`n    enabled: true`n    config: $keptBot" } else { "bot:`n  Knight Sample_1511:`n    enabled: false" }
    $configOtml = Join-Path $clientHome 'config.otml'
    if (Test-Path $configOtml) {
        $settingsText = [regex]::Replace([IO.File]::ReadAllText($configOtml), '(?m)^bot:\r?\n(?:[ \t]+.*(?:\r?\n|$))*', '')
        [IO.File]::WriteAllText($configOtml, $settingsText.TrimEnd() + "`n" + $botNode + "`n")
    }
    foreach ($installed in @(Get-ChildItem (Join-Path $clientHome 'bot') -Directory -ErrorAction SilentlyContinue)) {
        if ($installed.Name -ne $keptBot) { Remove-Item $installed.FullName -Recurse -Force }
    }
    "== client bot setting: $(if ($keptBot) { $keptBot } else { 'disabled, no bot folders' })"
    if ($Bot -eq 'vBot') {
        $botDir = Join-Path $env:APPDATA 'otcr\otclient\otclient\bot\vBot_4.8'
        if (Test-Path $botDir) { Remove-Item $botDir -Recurse -Force }
        Copy-Item (Join-Path $root 'otclient-src\mods\game_bot\default_configs\vBot_4.8') $botDir -Recurse
        New-Item -ItemType Directory -Force (Join-Path $botDir 'targetbot_configs'), (Join-Path $botDir 'storage') | Out-Null
        $targeting = [IO.File]::ReadAllText((Join-Path $TibiaLive 'vbot-arena.json')).Replace('"name":"troll"', "`"name`":`"$($kinds[0])`"").Replace('"regex":"^troll$"', "`"regex`":`"^($($kinds -join '|'))`$`"")
        [IO.File]::WriteAllText((Join-Path $botDir 'targetbot_configs\arena.json'), $targeting)
        $profileSettings = { param($enabled) [ordered]@{ enabled = $enabled; spellTable = @(); itemTable = @(if ($enabled) { [ordered]@{ index = 1; item = 266; sign = '<'; origin = 'HP'; value = $HealBelow; enabled = $true } }); name = 'Profile #1'; Visible = $false; Cooldown = $true; Interval = $true; Conditions = $true; Delay = $true; MessageDelay = $false } }
        $healBot = [ordered]@{ currentHealBotProfile = 1; healbot = @((& $profileSettings $true), (& $profileSettings $false), (& $profileSettings $false), (& $profileSettings $false), (& $profileSettings $false)) } | ConvertTo-Json -Depth 6
        foreach ($profileIndex in 0, 1) { $profileDir = Join-Path $botDir "vBot_configs\profile_$profileIndex"; New-Item -ItemType Directory -Force $profileDir | Out-Null; [IO.File]::WriteAllText((Join-Path $profileDir 'HealBot.json'), $healBot) }
        Set-Content (Join-Path $botDir 'storage\profile_1.json') '{"_configs":{"targetbot_configs":{"enabled":true,"selected":"arena"}}}' -NoNewline
        "== vBot seeded: TargetBot arena ($Monster, chase), HealBot potion below $HealBelow hp"
    }
    if ($Bot -eq 'nExBot') {
        $botDir = Join-Path $env:APPDATA 'otcr\otclient\otclient\bot\nExBot'
        if (Test-Path $botDir) { Remove-Item $botDir -Recurse -Force }
        Copy-Item (Join-Path $root 'bots\nExBot-19632d4') $botDir -Recurse
        $loader = Join-Path $botDir '_Loader.lua'
        $luaDofile = if ($env:TIBIA_NEXBOT_LUA_DOFILE -ne '0') { [IO.File]::ReadAllText((Join-Path $TibiaLive 'bot-lua-dofile.lua')) + "`n" } else { '' }
        if ($luaDofile) { Set-Content (Join-Path $botDir 'bot_env_probe.lua') 'return getfenv and getfenv(1) or _G' -NoNewline }
        [IO.File]::WriteAllText($loader, [IO.File]::ReadAllText((Join-Path $TibiaLive 'bot-network-sandbox.lua')) + "`n" + $luaDofile + [IO.File]::ReadAllText($loader))
        $shimmed = 0
        foreach ($script in Get-ChildItem $botDir -Recurse -Filter '*.lua') {
            $source = [IO.File]::ReadAllText($script.FullName)
            if ($source.Contains('pcall(dofile, ')) {
                [IO.File]::WriteAllText($script.FullName, $source.Replace('pcall(dofile, ', 'pcall(function(path) return dofile(path) end, '))
                $shimmed++
            }
        }
        "== nExBot: pcall(dofile, ...) wrapped in a Lua function in $shimmed files (the client's native dofile crashes when pcall calls it directly)"
        if ($env:TIBIA_NEXBOT_TRACE -eq '1') {
            $traceFunction = 'function nexbotTrace(message) pcall(function() local path = "/nexbot-trace.log"; local previous = g_resources.fileExists(path) and g_resources.readFileContents(path) or ""; g_resources.writeFileContents(path, previous .. tostring(os.clock()) .. " " .. message .. "\n") end) end' + "`n" + 'nexbotTrace("loader start")' + "`n"
            $traced = [IO.File]::ReadAllText($loader).Replace('  local scriptStart = os.clock()', '  nexbotTrace("load " .. tostring(basePath) .. tostring(name))' + "`n" + '  local scriptStart = os.clock()').Replace('  local elapsed = math.floor((os.clock() - scriptStart) * 1000)', '  nexbotTrace("done " .. tostring(name) .. " " .. tostring(status))' + "`n" + '  local elapsed = math.floor((os.clock() - scriptStart) * 1000)')
            [IO.File]::WriteAllText($loader, $traceFunction + $traced + "`n" + 'nexbotTrace("loader end")' + "`n")
            if ($env:TIBIA_NEXBOT_SKIP_FLOOR -eq '1') {
                foreach ($nestedFile in @(Get-ChildItem $botDir -Recurse -Filter '*.lua' | Where-Object { (Get-Content $_.FullName -Raw).Contains('floor_items.lua")') })) {
                    $nestedPath = $nestedFile.FullName
                    $nestedSource = [IO.File]::ReadAllText($nestedPath)
                    $nestedSource = [regex]::Replace($nestedSource, 'local ok, fi = pcall\([^\n]*floor_items\.lua"\)', 'local ok, fi = false, nil')
                    $nestedSource = [regex]::Replace($nestedSource, '(?m)^(\s*)ok, fi = pcall\([^\n]*floor_items\.lua"\)', '$1ok, fi = false, nil')
                    [IO.File]::WriteAllText($nestedPath, $nestedSource)
                }
                "== nExBot diagnostic: nested floor_items dofile skipped"
            }
            $pathUtils = Join-Path $botDir 'utils\path_utils.lua'
            $pathLines = [System.Collections.Generic.List[string]]::new([string[]](Get-Content $pathUtils))
            foreach ($lineNumber in @(500, 482, 452, 316, 184, 163, 125, 120, 111, 76, 66, 36, 30)) { $pathLines.Insert($lineNumber - 1, "nexbotTrace('path_utils line $lineNumber')") }
            [IO.File]::WriteAllLines($pathUtils, $pathLines)
            $traceFile = Join-Path $clientHome 'nexbot-trace.log'
            if (Test-Path $traceFile) { Remove-Item $traceFile -Force }
            "== nExBot load tracing on ($traceFile)"
        }
        New-Item -ItemType Directory -Force (Join-Path $botDir 'targetbot_configs'), (Join-Path $botDir 'storage') | Out-Null
        $targeting = [IO.File]::ReadAllText((Join-Path $TibiaLive 'vbot-arena.json')).Replace('"name":"troll"', "`"name`":`"$($kinds[0])`"").Replace('"regex":"^troll$"', "`"regex`":`"^($($kinds -join '|'))`$`"")
        [IO.File]::WriteAllText((Join-Path $botDir 'targetbot_configs\arena.json'), $targeting)
        $healPercent = [int]([Math]::Floor($HealBelow * 100 / $healthMax) - 1)
        $effectiveBelow = [Math]::Ceiling(($healPercent + 1) * $healthMax / 100)
        $profileSettings = { param($enabled) [ordered]@{ enabled = $enabled; spellTable = @(); itemTable = @(if ($enabled) { [ordered]@{ index = 1; item = 266; sign = '<'; origin = 'HP%'; value = $healPercent; enabled = $true } }); name = 'Profile #1'; Visible = $false; Cooldown = $true; Interval = $true; Conditions = $true; Delay = $true; MessageDelay = $false } }
        $healBot = [ordered]@{ currentHealBotProfile = 1; healbot = @((& $profileSettings $true), (& $profileSettings $false), (& $profileSettings $false), (& $profileSettings $false), (& $profileSettings $false)) } | ConvertTo-Json -Depth 6
        foreach ($profileIndex in 0, 1) { $profileDir = Join-Path $botDir "nExBot_configs\profile_$profileIndex"; New-Item -ItemType Directory -Force $profileDir | Out-Null; [IO.File]::WriteAllText((Join-Path $profileDir 'HealBot.json'), $healBot) }
        Set-Content (Join-Path $botDir 'storage\profile_1.json') '{"_configs":{"targetbot_configs":{"enabled":true,"selected":"arena"}}}' -NoNewline
        $characterDir = Join-Path $botDir 'nExBot_configs\characters\knight sample'
        New-Item -ItemType Directory -Force $characterDir | Out-Null
        Set-Content (Join-Path $characterDir 'UnifiedStorage.json') '{"version":1,"characterName":"Knight Sample","targetbot":{"enabled":true,"selectedConfig":"arena"},"healbot":{"enabled":true}}' -NoNewline
        "== nExBot seeded: TargetBot arena ($Monster, chase), HealBot potion at hp% <= $healPercent (health below $effectiveBelow of $healthMax), network calls stubbed"
    }
    "== world online, knight level $Level ($healthMax hp), axe skill $AxeSkill, $MonsterCount x $Monster, heal below $HealBelow"
    if ($MonsterCount -gt 0) { & (Join-Path $TibiaLive 'run-probe.ps1') -Script $summon -TimeoutSeconds 60 | Select-Object -Last 2 }
    "== timeline: summon probe done at wall $([DateTimeOffset]::Now.ToUnixTimeSeconds()) ($([DateTimeOffset]::Now.ToUnixTimeMilliseconds()) ms)"
    '== policy'
    $allyRun = $null
    if ($Ally) {
        $allyOut = Join-Path $root 'ally-probe.out'
        $allyProfile = Join-Path $root 'ally-profile'
        $gateFile = Join-Path $allyProfile 'login-gate'
        New-Item -ItemType Directory -Force $allyProfile | Out-Null
        if (Test-Path -LiteralPath $gateFile) { Remove-Item -LiteralPath $gateFile -Force }
        $env:TIBIA_ARENA_CHARACTER = $Ally
        $env:TIBIA_LOGIN_GATE = 'login-gate'
        $allyRun = Start-Process pwsh -ArgumentList '-NoProfile', '-File', (Join-Path $TibiaLive 'run-probe.ps1'), '-Script', $probe, '-TimeoutSeconds', $TimeoutSeconds, '-UserDir', $allyProfile -RedirectStandardOutput $allyOut -WindowStyle Hidden -PassThru
        $env:TIBIA_ARENA_CHARACTER = $null
        $env:TIBIA_LOGIN_GATE = $null
        $gate = Start-ThreadJob -ArgumentList $worldLog, $gateFile, $Ally -ScriptBlock {
            param($log, $file, $ally)
            $deadline = (Get-Date).AddSeconds(180)
            while (-not (Select-String -LiteralPath $log -SimpleMatch 'Knight Sample has logged in.' -Quiet -ErrorAction SilentlyContinue)) {
                if ((Get-Date) -gt $deadline) { return '== login gate: the knight login line did not appear within 180 s' }
                Start-Sleep -Milliseconds 50
            }
            $opened = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
            [IO.File]::WriteAllText($file, '')
            while (-not (Select-String -LiteralPath $log -SimpleMatch "$ally has logged in." -Quiet -ErrorAction SilentlyContinue)) {
                if ((Get-Date) -gt $deadline) { return "== login gate: opened at $opened ms, the ally login line did not appear" }
                Start-Sleep -Milliseconds 50
            }
            $entered = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
            "== login gate: opened at $opened ms, ally login line $($entered - $opened) ms after the knight's"
        }
    }
    & (Join-Path $TibiaLive 'run-probe.ps1') -Script $probe -TimeoutSeconds $TimeoutSeconds
    if ($allyRun) {
        $allyRun.WaitForExit()
        Receive-Job $gate -Wait -AutoRemoveJob
        "== ally log $allyOut"
    }
    Start-Sleep -Seconds 5
} finally {
    Copy-Item (Join-Path $root 'otclient-src\otclientrc.lua.orig') (Join-Path $root 'otclient-src\otclientrc.lua') -Force -ErrorAction SilentlyContinue
    Get-Process canary -ErrorAction SilentlyContinue | Stop-Process -Force
    if (Test-Path $keptSpawns) { Move-Item $keptSpawns $serverSpawns -Force }
    if (Test-Path $keptConfig) { Move-Item $keptConfig $serverConfig -Force }
}
& $mariadb --host=127.0.0.1 --port=3317 -uroot -pcanary canary -e "select level, experience, health, skill_axe from players where name = 'Knight Sample'"
'== world stopped'
