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

local heals, engagement, prefers, networkDecision, retreats, prefersReach = SpiralPolicy[1], SpiralPolicy[2], SpiralPolicy[3], SpiralPolicy[4], SpiralPolicy[5], SpiralPolicy[6]
local retreatAt = tonumber(os.getenv('TIBIA_ARENA_RETREAT_AT') or '0')
local choose = os.getenv('TIBIA_ARENA_TARGETING') == 'reach' and prefersReach or prefers
local kiteAt = tonumber(os.getenv('TIBIA_ARENA_KITE_AT') or '0')
local swingMs, stepMs = 2000, 650
local lastSwingAt, nextStepAt = -2000, 0
local awayDirection = { ['0,-1'] = North, ['1,0'] = East, ['0,1'] = South, ['-1,0'] = West, ['1,-1'] = NorthEast, ['1,1'] = SouthEast, ['-1,1'] = SouthWest, ['-1,-1'] = NorthWest }
local healBelow = tonumber(os.getenv('TIBIA_ARENA_HEAL_BELOW') or '120')
local strikeAbove = tonumber(os.getenv('TIBIA_ARENA_STRIKE_ABOVE') or '40')
local healthPotion, healCooldownMs = 266, 1000
local tickMs, runMs = 100, 150000
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

local stats = { heals = 0, strikes = 0, holds = 0, kills = 0, ticks = 0, retreats = 0, cornered = 0, gated = 0, lowestHealth = 999 }
local lastHealAt = -healCooldownMs
local engaged = {}
local startExperience = 0
local startedAt = 0

local function countKills()
    for id, creature in pairs(engaged) do
        if creature:isDead() then
            stats.kills = stats.kills + 1
            engaged[id] = nil
        end
    end
end

local function summary(player)
    return string.format('ticks %d heals %d strikes %d holds %d retreats %d cornered %d gated %d kills %d health %d lowest %d experience +%d',
        stats.ticks, stats.heals, stats.strikes, stats.holds, stats.retreats, stats.cornered, stats.gated, stats.kills, player:getHealth(), stats.lowestHealth,
        player:getExperience() - startExperience)
end

local randomDirections = { North, East, South, West, NorthEast, SouthEast, SouthWest, NorthWest }
math.randomseed(os.time())

local function policyTick()
    local player = g_game.getLocalPlayer()
    if not player or not g_game.isOnline() then
        finish('offline')
        return
    end
    local now = g_clock.millis()
    stats.ticks = stats.ticks + 1
    local health = player:getHealth()
    if health < stats.lowestHealth then stats.lowestHealth = health end
    if health <= 0 then
        note('dead: ' .. summary(player))
        finish('death')
        return
    end
    countKills()
    local pick = math.random(0, 3)
    if pick == 0 then
        if g_game.useInventoryItemWith(healthPotion, player) ~= false then
            stats.heals = stats.heals + 1
            note(string.format('heal (potion) at health %d t=%d', health, now - startedAt))
        else
            note(string.format('heal dropped by the action gate at health %d', health))
        end
    elseif pick == 1 then
        local target = nearestMonster(player)
        if target then
            stats.strikes = stats.strikes + 1
            if g_game.getChaseMode() ~= ChaseOpponent then g_game.setChaseMode(ChaseOpponent) end
            if g_game.getAttackingCreature() ~= target then
                g_game.attack(target)
                engaged[target:getId()] = target
                note(string.format('strike %s at %s from %s health %d', target:getName(), describe(target:getPosition()), describe(player:getPosition()), health))
            end
        end
    elseif pick == 2 then
        if now >= nextStepAt and not player:isWalking() then
            local k = math.random(1, 8)
            if g_game.walk(randomDirections[k]) ~= false then
                nextStepAt = now + stepMs * (k > 4 and 3 or 1)
                stats.retreats = stats.retreats + 1
            else
                stats.gated = stats.gated + 1
            end
        end
    else
        stats.holds = stats.holds + 1
    end
    if stats.ticks % 100 == 0 then
        note(summary(player) .. ' player at ' .. describe(player:getPosition()))
    end
    if now - startedAt > runMs then
        note('end: ' .. summary(player))
        finish('run complete')
        return
    end
    local fullExperience = tonumber(os.getenv('TIBIA_ARENA_FULL_EXPERIENCE') or '90')
    if player:getExperience() - startExperience >= fullExperience then
        note(string.format('cleared at %d ms', g_clock.millis() - startedAt))
        note('cleared: ' .. summary(player))
        finish('cleared')
        return
    end
    scheduleEvent(policyTick, tickMs)
end
scheduleEvent(function()
    local botSettings = g_settings.getNode('bot') or {}
    botSettings['Knight Sample_1511'] = { enabled = false }
    g_settings.setNode('bot', botSettings)
    g_settings.save()
    g_game.setClientVersion(1511)
    g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
    g_game.chooseRsa('127.0.0.1')
    connect(g_game, {
        onGameStart = function()
            local player = g_game.getLocalPlayer()
            note('in game as ' .. player:getName() .. ' health ' .. player:getHealth() .. ' mana ' .. player:getMana())
            scheduleEvent(function()
                startExperience = player:getExperience()
                g_game.setChaseMode(DontChase)
                g_game.setFightMode(FightBalanced)
                scheduleEvent(function()
                    note('random control starts at ' .. describe(player:getPosition()) .. ' (drink, engage, random step or stand, equal odds every ' .. tickMs .. ' ms)')
                    startedAt = g_clock.millis()
                    policyTick()
                end, 1000)
            end, 1500)
        end,
        onTextMessage = function(mode, text)
            if tostring(text):find('due to your') then lastSwingAt = g_clock.millis() end
            note('server text [' .. tostring(mode) .. '] t=' .. tostring(g_clock.millis() - startedAt) .. ': ' .. tostring(text))
        end,
        onLoginError = function(message)
            note('game login error: ' .. tostring(message))
            finish('game login error')
        end
    })
    g_game.loginWorld('@god', 'god', 'OTServBR-Global', '127.0.0.1', 7172, 'Knight Sample', '', '@god\ngod')
end, 3000)

scheduleEvent(function() finish('timeout') end, 200000)
