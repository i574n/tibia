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

local target = nil
local sawTarget = false

local function nearestMonster(player)
    local best, bestDistance = nil, 999
    for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
        if creature:isMonster() then
            local p, q = creature:getPosition(), player:getPosition()
            local distance = math.max(math.abs(p.x - q.x), math.abs(p.y - q.y))
            if distance < bestDistance then
                best, bestDistance = creature, distance
            end
        end
    end
    return best
end

local function huntTick(startExperience, ticks)
    local player = g_game.getLocalPlayer()
    if not player then
        finish('no player')
        return
    end
    if target and (target:isDead() or not target:getPosition()) then
        note('target gone after ' .. ticks .. ' ticks; experience ' .. startExperience .. ' -> ' .. player:getExperience() .. ', health ' .. player:getHealth())
        finish('kill')
        return
    end
    if not target then
        target = nearestMonster(player)
        if target then
            sawTarget = true
            note('attacking ' .. target:getName() .. ' at ' .. describe(target:getPosition()) .. ' from ' .. describe(player:getPosition()))
        end
    else
        local p, q = target:getPosition(), player:getPosition()
        local distance = (p and q) and math.max(math.abs(p.x - q.x), math.abs(p.y - q.y)) or 99
        if ticks % 4 == 0 then
            note('tick ' .. ticks .. ': target health ' .. target:getHealthPercent() .. '% at ' .. describe(p) .. ', player ' .. describe(q) .. ' health ' .. player:getHealth() .. ' distance ' .. distance)
        end
        if not g_game.isAttacking() then
            g_game.attack(target)
        end
        if distance > 1 and not g_game.isAttacking() then
            if ticks % 3 == 0 and p and q then
                local stepX = q.x > p.x and 1 or (q.x < p.x and -1 or 0)
                local stepY = q.y > p.y and 1 or (q.y < p.y and -1 or 0)
                player:autoWalk({ x = p.x + stepX, y = p.y + stepY, z = p.z })
            end
        end
    end
    if ticks > 600 then
        finish(sawTarget and 'hunt timeout' or 'no monster seen')
        return
    end
    scheduleEvent(function() huntTick(startExperience, ticks + 1) end, 500)
end

scheduleEvent(function()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            local player = g_game.getLocalPlayer()
            note('in game as ' .. player:getName())
            scheduleEvent(function()
                note('at ' .. describe(player:getPosition()) .. ' experience ' .. player:getExperience() .. ' health ' .. player:getHealth())
                g_game.setChaseMode(ChaseOpponent)
                huntTick(player:getExperience(), 0)
            end, 1500)
        end,
        onTextMessage = function(mode, text)
            if not text:find('protection zone') then note('server text: ' .. tostring(text)) end
        end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 330000)
