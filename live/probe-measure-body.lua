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

local hits, misses, kills = {}, 0, 0
local taken = {}
local potionBelow = tonumber(os.getenv('TIBIA_MEASURE_POTION_BELOW') or '90')
local lastPotionAt, potions = 0, 0
local swingMs, runMs = 2000, 200000
local target = nil
local startExperience, startedAt, lastSwingAt = 0, 0, 0

local function median(values)
    local sorted = {}
    for i, v in ipairs(values) do sorted[i] = v end
    table.sort(sorted)
    return #sorted > 0 and sorted[math.floor((#sorted + 1) / 2)] or 0
end

local function report(player, label)
    local total = 0
    for _, v in ipairs(hits) do total = total + v end
    local swings = #hits + misses
    note('potions ' .. potions)
    note(string.format('%s: swings %d landed %d (%.1f%%) mean landed %.2f median %d total %d kills %d experience +%d health %d',
        label, swings, #hits, swings > 0 and 100 * #hits / swings or 0, #hits > 0 and total / #hits or 0, median(hits), total, kills,
        player:getExperience() - startExperience, player:getHealth()))
    note('hits ' .. table.concat(hits, ','))
    local takenTotal, takenMax = 0, 0
    for _, v in ipairs(taken) do takenTotal = takenTotal + v; if v > takenMax then takenMax = v end end
    note(string.format('taken: count %d mean %.2f median %d max %d total %d', #taken, #taken > 0 and takenTotal / #taken or 0, median(taken), takenMax, takenTotal))
    note('taken ' .. table.concat(taken, ','))
end

local pendingHit = false

local function measureTick()
    local player = g_game.getLocalPlayer()
    if not player or not g_game.isOnline() then finish('offline') return end
    local now = g_clock.millis()
    if target and target:isDead() then
        kills = kills + 1
        note(string.format('kill %d confirmed dead, experience +%d', kills, player:getExperience() - startExperience))
        target = nil
    end
    if not target then
        local candidate, distance = nearestMonster(player)
        if candidate and distance <= 1 then
            target = candidate
            g_game.attack(target)
            lastSwingAt = now
            pendingHit = false
        end
    elseif now - lastSwingAt >= swingMs then
        local p = target:getPosition()
        if p and distanceBetween(p, player:getPosition()) <= 1 and player:getHealth() > 0 then
            if not pendingHit then misses = misses + 1 end
        end
        pendingHit = false
        lastSwingAt = now
    end
    if player:getHealth() < potionBelow and now - lastPotionAt >= 1000 then
        g_game.useInventoryItemWith(266, player)
        lastPotionAt = now
        potions = potions + 1
    end
    if now - startedAt > runMs then
        report(player, 'end')
        finish('measure complete')
        return
    end
    scheduleEvent(measureTick, 100)
end

scheduleEvent(function()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            local player = g_game.getLocalPlayer()
            note('in game as ' .. player:getName() .. ' health ' .. player:getHealth())
            scheduleEvent(function()
                g_game.setChaseMode(DontChase)
                g_game.setFightMode(FightBalanced)
                note('fight mode ' .. tostring(g_game.getFightMode()) .. ' at ' .. describe(player:getPosition()))
                startExperience = player:getExperience()
                startedAt = g_clock.millis()
                measureTick()
            end, 1000)
        end,
        onTextMessage = function(mode, text)
            local amount = text:match('loses (%d+) hitpoints? due to your')
            local lost = text:match('You lose (%d+) hitpoints? due to an attack')
            if lost then
                table.insert(taken, tonumber(lost))
            elseif amount then
                table.insert(hits, tonumber(amount))
                pendingHit = true
                if text:find('critical') then note('critical: ' .. text) end
            elseif text:find('You died') then
                local player = g_game.getLocalPlayer()
                if player then report(player, 'death') end
                scheduleEvent(function() finish('death') end, 500)
                note('server text [' .. tostring(mode) .. ']: ' .. tostring(text))
            elseif not text:find('You lose') then
                note('server text [' .. tostring(mode) .. ']: ' .. tostring(text))
            end
        end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 260000)