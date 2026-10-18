ArenaParity = { actionGapMs = 250, viewHalfWidth = 7, viewHalfHeight = 5, allowed = 0, dropped = 0 }

local lastActionAt = -1000000

local function admit()
    local now = g_clock.millis()
    if now - lastActionAt < ArenaParity.actionGapMs then
        ArenaParity.dropped = ArenaParity.dropped + 1
        return false
    end
    lastActionAt = now
    ArenaParity.allowed = ArenaParity.allowed + 1
    return true
end

local function gate(owner, name)
    local original = owner[name]
    if type(original) ~= 'function' then return end
    owner[name] = function(...)
        if not admit() then return false end
        original(...)
        return true
    end
end

local nativeTurn = g_game.turn
ArenaParity.loginProtectionEndedAt = nil
connect(g_game, {
    onGameStart = function()
        scheduleEvent(function()
            if g_game.isOnline() and not ArenaParity.loginProtectionEndedAt then
                nativeTurn(South)
                ArenaParity.loginProtectionEndedAt = g_clock.millis()
                g_logger.info('[tibia-probe] parity: login protection ended for every competitor by one turn after login')
            end
        end, 300)
    end
})

for _, name in ipairs({ 'attack', 'follow', 'walk', 'turn', 'talk', 'talkChannel', 'use', 'useWith', 'useInventoryItem', 'useInventoryItemWith', 'move', 'cancelAttack', 'cancelAttackAndFollow' }) do
    gate(g_game, name)
end

if LocalPlayer then
    gate(LocalPlayer, 'autoWalk')
end

local spectators = g_map.getSpectators
g_map.getSpectators = function(center, multiFloor, ...)
    local list = spectators(center, multiFloor, ...)
    local player = g_game.getLocalPlayer()
    if not player or not player:getPosition() then return list end
    local origin = player:getPosition()
    local visible = {}
    for _, creature in ipairs(list) do
        local p = creature:getPosition()
        if p and p.z == origin.z and math.abs(p.x - origin.x) <= ArenaParity.viewHalfWidth and math.abs(p.y - origin.y) <= ArenaParity.viewHalfHeight then
            table.insert(visible, creature)
        end
    end
    return visible
end

function ArenaParity.summary()
    return string.format('parity: gap %d ms, view %dx%d, actions allowed %d dropped %d',
        ArenaParity.actionGapMs, ArenaParity.viewHalfWidth * 2 + 1, ArenaParity.viewHalfHeight * 2 + 1, ArenaParity.allowed, ArenaParity.dropped)
end
