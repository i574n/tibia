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

local function listCreatures()
    local player = g_game.getLocalPlayer()
    local spectators = g_map.getSpectators(player:getPosition(), false)
    for _, creature in ipairs(spectators) do
        note('sees ' .. creature:getName() .. ' monster=' .. tostring(creature:isMonster()) .. ' at ' .. describe(creature:getPosition()))
    end
end

local function timedTour()
    local tour = { North, South, North, South, NorthEast, SouthWest, NorthEast, SouthWest }
    local labels = { 'N', 'S', 'N', 'S', 'NE', 'SW', 'NE', 'SW' }
    local index = 0
    local function stepNext()
        index = index + 1
        if index > #tour then
            finish('timed tour complete')
            return
        end
        local player = g_game.getLocalPlayer()
        local started = g_clock.millis()
        local from = player:getPosition()
        g_game.walk(tour[index])
        local function waitDone()
            if player:isWalking() then
                scheduleEvent(waitDone, 10)
                return
            end
            note(string.format('step %s speed %d from %s to %s took %d ms', labels[index], player:getSpeed(), describe(from), describe(player:getPosition()), g_clock.millis() - started))
            scheduleEvent(stepNext, 400)
        end
        scheduleEvent(waitDone, 10)
    end
    scheduleEvent(stepNext, 1500)
end
scheduleEvent(function()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            note('in game as ' .. g_game.getLocalPlayer():getName())
            timedTour()
        end,
        onTextMessage = function(mode, text)
            note('server text: ' .. tostring(text))
        end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'GOD', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 60000)