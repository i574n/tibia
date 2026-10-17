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

local watchMs, sampleMs = 30000, 50
local probeLog = {}

local function note(message)
    local line = '[tibia-probe] ' .. message
    table.insert(probeLog, line)
    g_logger.info(line)
    g_resources.writeFileContents('/tibia-probe.log', table.concat(probeLog, '\n') .. '\n')
end

local function describe(position)
    if not position then return 'nil' end
    return string.format('%d,%d,%d', position.x, position.y, position.z)
end

local finished = false
local function finish(reason)
    if finished then return end
    finished = true
    note('finish: ' .. reason)
    if g_game.isOnline() then g_game.safeLogout() end
    scheduleEvent(function() g_app.exit() end, 2000)
end

local function chebyshev(p, q)
    return math.max(math.abs(p.x - q.x), math.abs(p.y - q.y))
end

local function nearestMonster(player)
    local best, bestDistance = nil, 999
    for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
        if creature:isMonster() and not creature:isDead() and creature:getPosition() then
            local distance = chebyshev(creature:getPosition(), player:getPosition())
            if distance < bestDistance then best, bestDistance = creature, distance end
        end
    end
    return best, bestDistance
end

local startedAt, lastAt, steps = 0, nil, 0

local function watch()
    if finished then return end
    local player = g_game.getLocalPlayer()
    if not player or not g_game.isOnline() then finish('offline') return end
    if not player:getPosition() then scheduleEvent(watch, sampleMs) return end
    local elapsed = g_clock.millis() - startedAt
    local monster, distance = nearestMonster(player)
    if monster then
        local at = monster:getPosition()
        if not lastAt or at.x ~= lastAt.x or at.y ~= lastAt.y then
            if lastAt then steps = steps + 1 end
            note(string.format('path t=%d ms monster at %s distance %d step %d', elapsed, describe(at), distance, steps))
            lastAt = { x = at.x, y = at.y, z = at.z }
        end
        if distance <= 1 then
            note(string.format('arrived at %d ms after %d steps, knight at %s', elapsed, steps, describe(player:getPosition())))
            finish('arrived')
            return
        end
    end
    if elapsed > watchMs then
        note(string.format('not arrived after %d ms, %d steps', elapsed, steps))
        finish('not arrived')
        return
    end
    scheduleEvent(watch, sampleMs)
end

scheduleEvent(function()
    local settings = g_settings.getNode('bot') or {}
    settings['Knight Sample_1511'] = { enabled = false }
    g_settings.setNode('bot', settings)
    g_settings.save()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            local player = g_game.getLocalPlayer()
            scheduleEvent(function()
                note('in game as ' .. player:getName() .. ' at ' .. describe(player:getPosition()) .. ' (path check, standing, no attack)')
                startedAt = g_clock.millis()
                watch()
            end, 1500)
        end,
        onTextMessage = function(mode, text)
            note('server text [' .. tostring(mode) .. ']: ' .. tostring(text))
        end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 60000)
