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

local healBelow = tonumber(os.getenv('TIBIA_ARENA_HEAL_BELOW') or '120')
local strikeAbove = tonumber(os.getenv('TIBIA_ARENA_STRIKE_ABOVE') or '40')
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

local finished = false

local function finish(reason)
    if finished then return end
    finished = true
    if ArenaParity then note(ArenaParity.summary()) end
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

local runMs = 150000
local startExperience, startedAt, lowest = 0, 0, 999
local clearedAt = nil
local fullExperience = tonumber(os.getenv('TIBIA_ARENA_FULL_EXPERIENCE') or '90')

local function watchEveryTick()
    local player = g_game.getLocalPlayer()
    if finished or not player or not g_game.isOnline() then return end
    local health = player:getHealth()
    if health < lowest then lowest = health end
    if not clearedAt and player:getExperience() - startExperience >= fullExperience then
        clearedAt = g_clock.millis() - startedAt
        note(string.format('cleared at %d ms', clearedAt))
        note(string.format('cleared: experience +%d health %d lowest health %d', player:getExperience() - startExperience, health, lowest))
        finish('cleared')
        return
    end
    scheduleEvent(watchEveryTick, 100)
end

local function observe()
    if finished then return end
    local player = g_game.getLocalPlayer()
    if not player or not g_game.isOnline() then finish('offline') return end
    local health = player:getHealth()
    if health < lowest then lowest = health end
    local elapsed = g_clock.millis() - startedAt
    if not clearedAt and player:getExperience() - startExperience >= fullExperience then
        clearedAt = elapsed
        note(string.format('cleared at %d ms', elapsed))
        note(string.format('cleared: experience +%d health %d lowest health %d', player:getExperience() - startExperience, health, lowest))
        finish('cleared')
        return
    end
    local attacking = g_game.getAttackingCreature()
    note(string.format('t=%ds experience +%d health %d lowest %d attacking %s at %s', math.floor(elapsed / 1000), player:getExperience() - startExperience, health, lowest,
        attacking and (attacking:getName() .. ' ' .. attacking:getHealthPercent() .. '%') or 'nothing', describe(player:getPosition())))
    if elapsed > runMs then
        note(string.format('end: experience +%d lowest health %d', player:getExperience() - startExperience, lowest))
        finish('run complete')
        return
    end
    scheduleEvent(observe, 10000)
end

scheduleEvent(function()
    local settings = g_settings.getNode('bot') or {}
    settings['Knight Sample_1511'] = { enabled = true, config = 'vBot_4.8' }
    g_settings.setNode('bot', settings)
    g_settings.save()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            local player = g_game.getLocalPlayer()
            note('in game as ' .. player:getName() .. ' health ' .. player:getHealth() .. ' (vBot_4.8 TargetBot arena config)')
            scheduleEvent(function()
                g_game.setFightMode(FightBalanced)
                startExperience = player:getExperience()
                startedAt = g_clock.millis()
                watchEveryTick()
                observe()
            end, 1000)
        end,
        onTextMessage = function(mode, text)
            if finished and tostring(text):find('health potion') then
                note('server text after finish (potion not counted) [' .. tostring(mode) .. ']')
                return
            end
            note('server text [' .. tostring(mode) .. ']: ' .. tostring(text))
        end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 200000)