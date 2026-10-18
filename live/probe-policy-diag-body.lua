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

local adjacency = { ms = 0, hits = 0, lastTick = nil }
local function adjacentMonsters(player)
    local count = 0
    for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
        if creature:isMonster() and not creature:isDead() and creature:getPosition() and distanceBetween(creature:getPosition(), player:getPosition()) <= 1 then count = count + 1 end
    end
    return count
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
    if not adjacency.lastTick then
        local seen = {}
        for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
            if creature:isMonster() and creature:getPosition() then table.insert(seen, describe(creature:getPosition())) end
        end
        note('start positions: knight ' .. describe(player:getPosition()) .. ' monsters ' .. table.concat(seen, ' '))
    end
    if adjacency.lastTick then adjacency.ms = adjacency.ms + adjacentMonsters(player) * (now - adjacency.lastTick) end
    adjacency.lastTick = now
    local current = g_game.getAttackingCreature()
    local target, distance = nil, 999
    for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
        if creature:isMonster() and not creature:isDead() and creature:getPosition() then
            local d = distanceBetween(creature:getPosition(), player:getPosition())
            if not target or choose(creature == current)(d)(creature:getHealthPercent())(target == current)(distance)(target:getHealthPercent()) then
                target, distance = creature, d
            end
        end
    end
    local targetCode = target and (distance <= 1 and 1 or 2) or 0
    local healReady = now - lastHealAt >= healCooldownMs
    local function drinkPotion()
        if g_game.useInventoryItemWith(healthPotion, player) ~= false then
            lastHealAt = now
            stats.heals = stats.heals + 1
            note(string.format('heal (potion) at health %d', health))
        else
            note(string.format('heal dropped by the action gate at health %d', health))
        end
    end
    local function engageTarget(chasing)
        stats.strikes = stats.strikes + 1
        local chase = chasing and ChaseOpponent or DontChase
        if g_game.getChaseMode() ~= chase then g_game.setChaseMode(chase) end
        if g_game.getAttackingCreature() ~= target then
            g_game.attack(target)
            engaged[target:getId()] = target
            note(string.format('%s %s at %s from %s health %d', chasing and 'approach' or 'strike', target:getName(), describe(target:getPosition()), describe(player:getPosition()), health))
        end
    end
    local function hold()
        stats.holds = stats.holds + 1
        if g_game.isAttacking() and targetCode == 1 then
            g_game.cancelAttack()
            note(string.format('hold at health %d', health))
        end
    end
    local attackers, threat = 0, nil
    for _, creature in ipairs(g_map.getSpectators(player:getPosition(), false)) do
        if creature:isMonster() and not creature:isDead() and creature:getPosition() and distanceBetween(creature:getPosition(), player:getPosition()) <= 1 then
            attackers = attackers + 1
            local q = creature:getPosition()
            if not threat or q.x * 100000 + q.y < threat:getPosition().x * 100000 + threat:getPosition().y then threat = creature end
        end
    end
    local function stepAway()
        if g_game.getChaseMode() ~= DontChase then g_game.setChaseMode(DontChase) end
        local p, q = player:getPosition(), threat:getPosition()
        local sx = p.x > q.x and 1 or p.x < q.x and -1 or 0
        local sy = p.y > q.y and 1 or p.y < q.y and -1 or 0
        local candidates = { { sx, sy }, { sx, 0 }, { 0, sy } }
        if sx == 0 then table.insert(candidates, { 1, sy }); table.insert(candidates, { -1, sy }) end
        if sy == 0 then table.insert(candidates, { sx, 1 }); table.insert(candidates, { sx, -1 }) end
        for _, c in ipairs(candidates) do
            if c[1] ~= 0 or c[2] ~= 0 then
                local tile = g_map.getTile({ x = p.x + c[1], y = p.y + c[2], z = p.z })
                local direction = awayDirection[c[1] .. ',' .. c[2]]
                if tile and tile:isWalkable() and not tile:hasFloorChange() and direction then
                    if g_game.walk(direction) ~= false then
                        nextStepAt = now + stepMs * ((c[1] ~= 0 and c[2] ~= 0) and 3 or 1)
                        stats.retreats = stats.retreats + 1
                        return true
                    end
                    stats.gated = stats.gated + 1
                    return false
                end
            end
        end
        stats.cornered = stats.cornered + 1
        if stats.cornered % 50 == 1 then
            local around = {}
            for _, creature in ipairs(g_map.getSpectators(p, false)) do
                if creature:isMonster() and creature:getPosition() and distanceBetween(creature:getPosition(), p) <= 1 then table.insert(around, describe(creature:getPosition())) end
            end
            local rejected = {}
            for _, c in ipairs(candidates) do
                if c[1] ~= 0 or c[2] ~= 0 then
                    local tile = g_map.getTile({ x = p.x + c[1], y = p.y + c[2], z = p.z })
                    table.insert(rejected, string.format('%d,%d:%s', c[1], c[2], tile and (tile:isWalkable() and 'walk' or (tile:isWalkable(true) and 'creature' or 'blocked')) or 'none'))
                end
            end
            note(string.format('cornered at %s threat %s adjacent [%s] candidates [%s]', describe(p), describe(q), table.concat(around, ' '), table.concat(rejected, ' ')))
        end
        return false
    end
    local canStep = threat and now >= nextStepAt and not player:isWalking()
    if kiteAt > 0 then
        local strikeReady = now - lastSwingAt >= swingMs
        local code = networkDecision(healBelow)(player:getMaxHealth())(kiteAt)(health)(attackers)(target and target:getHealthPercent() or 0)(target and distance or 0)(healReady)(strikeReady)
        if code % 2 == 1 and healReady then drinkPotion() end
        local retreated = math.floor(code / 4) % 2 == 1 and canStep and stepAway()
        if not retreated then
            if math.floor(code / 2) % 2 == 1 and target then engageTarget(targetCode == 2) else hold() end
        end
    else
        if heals(healBelow)(strikeAbove)(health)(healReady)(true)(targetCode) then drinkPotion() end
        local retreated = retreatAt > 0 and retreats(retreatAt)(attackers) and canStep and stepAway()
        if not retreated then
            local decision = engagement(healBelow)(strikeAbove)(health)(healReady)(true)(targetCode)
            if decision == 1 or decision == 2 then engageTarget(decision == 2) else hold() end
        end
    end    if stats.ticks % 100 == 0 then
        local attacking = g_game.getAttackingCreature()
        note(summary(player) .. ' attacking ' .. (attacking and (attacking:getName() .. ' ' .. attacking:getHealthPercent() .. '% at ' .. describe(attacking:getPosition())) or 'nothing') .. ' player at ' .. describe(player:getPosition()) .. ' pz ' .. tostring(player.isInProtectionZone and player:isInProtectionZone() or '?'))
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
        note(string.format('adjacency: %d monster-ms adjacent, %d landed hits, %.3f landed hits per adjacent monster-second', adjacency.ms, adjacency.hits, adjacency.hits * 1000 / math.max(1, adjacency.ms)))
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
                    note('policy starts at ' .. describe(player:getPosition()) .. ' thresholds heal<' .. healBelow .. ' strike>=' .. strikeAbove .. ' kite at ' .. kiteAt .. ' retreat at ' .. retreatAt .. ' targeting ' .. (os.getenv('TIBIA_ARENA_TARGETING') or 'current'))
                    startedAt = g_clock.millis()
                    policyTick()
                end, 1000)
            end, 1500)
        end,
        onTextMessage = function(mode, text)
            if tostring(text):find('due to your') then lastSwingAt = g_clock.millis() end
            if tostring(text):find('due to an attack') then
                adjacency.hits = adjacency.hits + 1
                local me = g_game.getLocalPlayer()
                if me and me:getPosition() then note(string.format('hit at %d ms with %d adjacent', g_clock.millis() - startedAt, adjacentMonsters(me))) end
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
