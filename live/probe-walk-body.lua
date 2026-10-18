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


local attempts = {
    { 'g_game.walk(South)', function() return g_game.walk(South) end },
    { 'g_game.walk(North)', function() return g_game.walk(North) end },
    { 'g_game.walk(East, false)', function() return g_game.walk(East, false) end },
    { 'g_game.walk(West, true)', function() return g_game.walk(West, true) end },
    { 'g_game.forceWalk(South)', function() return g_game.forceWalk and g_game.forceWalk(South) or 'missing' end },
    { 'g_game.forceWalk(North)', function() return g_game.forceWalk and g_game.forceWalk(North) or 'missing' end },
    { 'autoWalk 2 east', function() local p = g_game.getLocalPlayer():getPosition(); return g_game.getLocalPlayer():autoWalk({ x = p.x + 2, y = p.y, z = p.z }) end },
}

local function tryNext(index)
    local player = g_game.getLocalPlayer()
    if index > #attempts then finish('walk probe done') return end
    local before = describe(player:getPosition())
    local ok, result = pcall(attempts[index][2])
    scheduleEvent(function()
        note(string.format('%s -> returned %s (ok %s), %s -> %s, walking %s', attempts[index][1], tostring(result), tostring(ok), before, describe(g_game.getLocalPlayer():getPosition()), tostring(g_game.getLocalPlayer():isWalking())))
        tryNext(index + 1)
    end, 1500)
end

scheduleEvent(function()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            note('in game as ' .. g_game.getLocalPlayer():getName())
            scheduleEvent(function()
                local player = g_game.getLocalPlayer()
                note('start at ' .. describe(player:getPosition()) .. ' speed ' .. tostring(player:getSpeed()) .. ' canPerformGameAction ' .. tostring(g_game.canPerformGameAction and g_game.canPerformGameAction()))
                tryNext(1)
            end, 2500)
        end,
        onTextMessage = function(mode, text) note('server text [' .. tostring(mode) .. ']: ' .. tostring(text)) end,
        onLoginError = function(message) note('game login error: ' .. tostring(message)); finish('game login error') end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 60000)