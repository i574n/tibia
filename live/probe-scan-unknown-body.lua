print 'Startup done :]'

local function keepHidden()
    if os.getenv('TIBIA_PROBE_HIDDEN') == '1' then
        g_window.move({ x = -32000, y = -32000 })
        g_window.hide()
    end
    g_settings.set('enableAudio', false)
    if g_sounds then
        g_sounds.setAudioEnabled(false)
        g_sounds.stopAll()
    end
end
keepHidden()
scheduleEvent(keepHidden, 200)
scheduleEvent(keepHidden, 1000)

local healBelow, strikeAbove = 120, 40
local healthPotion, healCooldownMs = 266, 1000
local tickMs, runMs = 250, 150000
local fightSpot = { x = 1932, y = 1349, z = 7 }

local probeLog = {}

local function note(message)
    local line = '[tibia-probe] ' .. message
    table.insert(probeLog, line)
    g_logger.info(line)
    g_resources.writeFileContents('/tibia-probe.log', table.concat(probeLog, '\n') .. '\n')
end

local function describe(position)
    if not position then
        return 'nil'
    end
    return string.format('%d,%d,%d', position.x, position.y, position.z)
end

local function finish(reason)
    note('finish: ' .. reason)
    if g_game.isOnline() then
        g_game.safeLogout()
    end
    scheduleEvent(function() g_app.exit() end, 2000)
end

local function distanceBetween(p, q)
    return math.max(math.abs(p.x - q.x), math.abs(p.y - q.y))
end

local function nearestMonster(player)
    local best, bestDistance = nil, 999
    for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
        if creature:isMonster() and not creature:isDead() and creature:getPosition() then
            local distance = distanceBetween(creature:getPosition(), player:getPosition())
            if distance < bestDistance then
                best, bestDistance = creature, distance
            end
        end
    end
    return best, bestDistance
end


local function scan(radius)
    local player = g_game.getLocalPlayer()
    local c = player:getPosition()
    note('scan around ' .. describe(c) .. ' (# wall or blocked, . walkable, ? not loaded by the client, K knight)')
    for dy = -radius, radius do
        local row = {}
        for dx = -radius, radius do
            if dx == 0 and dy == 0 then
                table.insert(row, 'K')
            else
                local tile = g_map.getTile({ x = c.x + dx, y = c.y + dy, z = c.z })
                table.insert(row, (not tile) and '?' or (tile:isWalkable(true) and '.' or '#'))
            end
        end
        note(string.format('%+3d %s', dy, table.concat(row)))
    end
end

scheduleEvent(function()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            scheduleEvent(function()
                scan(12)
                finish('scanned')
            end, 2500)
        end,
        onLoginError = function(message) note('game login error: ' .. tostring(message)); finish('game login error') end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 40000)