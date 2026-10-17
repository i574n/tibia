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

local lastStep = {}
local intervals = { straight = {}, diagonal = {} }
local chase = os.getenv('TIBIA_STEPS_CHASE') == '1'
local awayDirection = { ['0,-1'] = North, ['1,0'] = East, ['0,1'] = South, ['-1,0'] = West, ['1,-1'] = NorthEast, ['1,1'] = SouthEast, ['-1,1'] = SouthWest, ['-1,-1'] = NorthWest }
local startedAt = 0

local function record(creature, newPos, oldPos)
    if not newPos or not oldPos then return end
    local isKnight = creature:isLocalPlayer()
    if not creature:isMonster() and not isKnight then return end
    if newPos.z ~= oldPos.z then return end
    local dx, dy = math.abs(newPos.x - oldPos.x), math.abs(newPos.y - oldPos.y)
    if dx + dy == 0 or dx > 1 or dy > 1 then return end
    local now = g_clock.millis()
    local id = creature:getId()
    local player = g_game.getLocalPlayer()
    local near = player and player:getPosition() and distanceBetween(newPos, player:getPosition()) <= 1
    local kind = (isKnight and 'knight-' or '') .. ((dx == 1 and dy == 1) and 'diagonal' or 'straight') .. ((chase and not isKnight) and (near and '-adjacent' or '-chasing') or '')
    local previous = lastStep[id]
    lastStep[id] = { at = now, kind = kind }
    if previous then
        local measured = previous.kind
        intervals[measured] = intervals[measured] or {}
        table.insert(intervals[measured], now - previous.at)
        note(string.format('%s %d %s step %s -> %s; interval after its %s step %d ms', creature:getName(), id, kind, describe(oldPos), describe(newPos), measured, now - previous.at))
    end
end

local function summarize(label, values)
    if #values == 0 then return label .. ' none' end
    local sorted = {}
    for i, v in ipairs(values) do sorted[i] = v end
    table.sort(sorted)
    return string.format('%s n=%d median %d min %d max %d', label, #sorted, sorted[math.floor((#sorted + 1) / 2)], sorted[1], sorted[#sorted])
end

scheduleEvent(function()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(Creature, { onPositionChange = record })
    connect(g_game, {
        onGameStart = function()
            local player = g_game.getLocalPlayer()
            note('in game as ' .. player:getName() .. ' at ' .. describe(player:getPosition()) .. ' speed ' .. tostring(player:getSpeed()))
            startedAt = g_clock.millis()
            local function walkAway()
                local me = g_game.getLocalPlayer()
                if not me or not g_game.isOnline() then return end
                local monster, distance = nearestMonster(me)
                if monster and distance <= 2 and not me:isWalking() then
                    local p, q = me:getPosition(), monster:getPosition()
                    local dx, dy = p.x - q.x, p.y - q.y
                    local direction = awayDirection[(dx > 0 and 1 or dx < 0 and -1 or 0) .. ',' .. (dy > 0 and 1 or dy < 0 and -1 or 0)]
                    if direction then g_game.walk(direction) end
                end
                scheduleEvent(walkAway, 1300)
            end
            if chase then scheduleEvent(walkAway, 2000) end
            scheduleEvent(function()
                local parts = {}
                for label, values in pairs(intervals) do table.insert(parts, summarize(label, values)) end
                table.sort(parts)
                note('end: ' .. table.concat(parts, '; '))
                finish('steps measured')
            end, 45000)
        end,
        onTextMessage = function(mode, text) note('server text [' .. tostring(mode) .. ']: ' .. tostring(text)) end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 90000)