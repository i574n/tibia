local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Mut0, Mut1, Mut2, Mut3, closure1, closure0, closure2, closure3, closure4, closure5, method0, closure6, format_real_1, closure7
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

Mut3 = function(l0) return { __tag = "Mut3", l0 = l0 } end

function closure1(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.isOnline()
        local getv5 = function()
            if v2 then
                local v3 = v1 ~= nil and v1.l0
                local v4 = v3 == false
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            do (v0)(South) end
            v1.l0 = true
            local v6 = "[tibia-probe] parity: login protection ended for every competitor by one turn after login"
            g_logger.info(v6)
            return nil
        else
        end
    end
end

function closure0(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = closure1({ v0, v1 })
        scheduleEvent(v2, 300)
        return nil
    end
end

function closure2(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(v4)
        local v5 = g_clock.millis()
        local v6 = v0 ~= nil and v0.l0
        local v7 = spiral_wrap_signed((v5 - v6), 32)
        local v8 = v7 < 250
        local getv13 = function()
            if v8 then
                local v9 = v2 ~= nil and v2.l0
                local v10 = spiral_wrap_signed((v9 + 1), 32)
                v2.l0 = v10
                return false
            else
                v0.l0 = v5
                local v11 = v1 ~= nil and v1.l0
                local v12 = spiral_wrap_signed((v11 + 1), 32)
                v1.l0 = v12
                return true
            end
        end
        local v13 = getv13()
        if v13 then
            do (v3)(v4) end
            return true
        else
            return false
        end
    end
end

function closure3(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        local v4, v5, v6 = (table.unpack or unpack)(dom)
        local v7 = g_clock.millis()
        local v8 = v0 ~= nil and v0.l0
        local v9 = spiral_wrap_signed((v7 - v8), 32)
        local v10 = v9 < 250
        local getv15 = function()
            if v10 then
                local v11 = v2 ~= nil and v2.l0
                local v12 = spiral_wrap_signed((v11 + 1), 32)
                v2.l0 = v12
                return false
            else
                v0.l0 = v7
                local v13 = v1 ~= nil and v1.l0
                local v14 = spiral_wrap_signed((v13 + 1), 32)
                v1.l0 = v14
                return true
            end
        end
        local v15 = getv15()
        if v15 then
            do (v3)(v4, v5, v6) end
            return true
        else
            return false
        end
    end
end

function closure4(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        local v4, v5 = (table.unpack or unpack)(dom)
        local v6 = g_clock.millis()
        local v7 = v0 ~= nil and v0.l0
        local v8 = spiral_wrap_signed((v6 - v7), 32)
        local v9 = v8 < 250
        local getv14 = function()
            if v9 then
                local v10 = v2 ~= nil and v2.l0
                local v11 = spiral_wrap_signed((v10 + 1), 32)
                v2.l0 = v11
                return false
            else
                v0.l0 = v6
                local v12 = v1 ~= nil and v1.l0
                local v13 = spiral_wrap_signed((v12 + 1), 32)
                v1.l0 = v13
                return true
            end
        end
        local v14 = getv14()
        if v14 then
            do (v3)(v4, v5) end
            return true
        else
            return false
        end
    end
end

function closure5(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        local v4 = g_clock.millis()
        local v5 = v0 ~= nil and v0.l0
        local v6 = spiral_wrap_signed((v4 - v5), 32)
        local v7 = v6 < 250
        local getv12 = function()
            if v7 then
                local v8 = v2 ~= nil and v2.l0
                local v9 = spiral_wrap_signed((v8 + 1), 32)
                v2.l0 = v9
                return false
            else
                v0.l0 = v4
                local v10 = v1 ~= nil and v1.l0
                local v11 = spiral_wrap_signed((v10 + 1), 32)
                v1.l0 = v11
                return true
            end
        end
        local v12 = getv12()
        if v12 then
            do (v3)() end
            return true
        else
            return false
        end
    end
end

function method0(v0, v1)
    local v2 = v1 ~= nil and v1.l0
    local v3 = v2 < v0
    return v3
end

function closure6(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1, v2 = (table.unpack or unpack)(dom)
        local v3 = (v0)(v1, v2)
        local v4 = g_game.getLocalPlayer()
        local v5 = (v4) ~= nil
        local v6 = v5 == false
        if v6 then
            return v3
        else
            local v7 = (v4):getPosition()
            local v8 = (v7) ~= nil
            local v9 = v8 == false
            if v9 then
                return v3
            else
                local v10 = {}
                local v11 = (v7).x
                local v12 = (v7).y
                local v13 = (v7).z
                local v14 = #(v3)
                local v15 = spiral_wrap_signed((v14 + 1), 32)
                local v16 = { __tag = "Mut2", l0 = 1 }
                while method0(v15, v16) do
                    local v18 = v16 ~= nil and v16.l0
                    local v19 = (v3)[v18]
                    local v20 = (v19):getPosition()
                    local v21 = (v20) ~= nil
                    if v21 then
                        local v22 = (v20).x
                        local v23 = spiral_wrap_signed((v22 - v11), 32)
                        local v24 = v23 <= 7
                        local getv27 = function()
                            if v24 then
                                local v25 = spiral_wrap_signed((v11 - v22), 32)
                                local v26 = v25 <= 7
                                return v26
                            else
                                return false
                            end
                        end
                        local v27 = getv27()
                        local v28 = (v20).y
                        local v29 = spiral_wrap_signed((v28 - v12), 32)
                        local v30 = v29 <= 5
                        local getv33 = function()
                            if v30 then
                                local v31 = spiral_wrap_signed((v12 - v28), 32)
                                local v32 = v31 <= 5
                                return v32
                            else
                                return false
                            end
                        end
                        local v33 = getv33()
                        local v34 = (v20).z
                        local v35 = v34 == v13
                        local v36 = (v35) and (v27)
                        local v37 = (v36) and (v33)
                        if v37 then
                            table.insert(v10, v19)
                        else
                        end
                    else
                    end
                    local v38 = spiral_wrap_signed((v18 + 1), 32)
                    v16.l0 = v38
                end
                return v10
            end
        end
    end
end

function format_real_1(v0)
    local v1 = ""
    local v2 = { __tag = "Mut3", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure7(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = v1 ~= nil and v1.l0
        local v4 = v2 ~= nil and v2.l0
        local v5 = 250
        local v6 = format_real_1(v5)
        local v7 = "parity: gap "
        local v8 = v7 .. v6 
        local v9 = " ms, view "
        local v10 = v8 .. v9 
        local v11 = 15
        local v12 = format_real_1(v11)
        local v13 = v10 .. v12 
        local v14 = "x"
        local v15 = v13 .. v14 
        local v16 = 11
        local v17 = format_real_1(v16)
        local v18 = v15 .. v17 
        local v19 = ", actions allowed "
        local v20 = v18 .. v19 
        local v21 = format_real_1(v3)
        local v22 = v20 .. v21 
        local v23 = " dropped "
        local v24 = v22 .. v23 
        local v25 = format_real_1(v4)
        local v26 = v24 .. v25 
        return v26
    end
end

local v0 = { __tag = "Mut0", l0 = -1000000 }
local v1 = { __tag = "Mut0", l0 = 0 }
local v2 = { __tag = "Mut0", l0 = 0 }
local v3 = g_game
local v4 = "turn"
local v5 = (v3)[v4]
local v6 = { __tag = "Mut1", l0 = false }
local v7 = closure0({ v5, v6 })
connect(g_game, { onGameStart = v7 })
local v8 = "attack"
local v9 = (v3)[v8]
local v10 = type(v9) == "function"
if v10 then
    local v11 = closure2({ v0, v1, v2, v9 })
    do (v3)[v8] = v11 end
else
end
local v12 = "follow"
local v13 = (v3)[v12]
local v14 = type(v13) == "function"
if v14 then
    local v15 = closure2({ v0, v1, v2, v13 })
    do (v3)[v12] = v15 end
else
end
local v16 = "walk"
local v17 = (v3)[v16]
local v18 = type(v17) == "function"
if v18 then
    local v19 = closure2({ v0, v1, v2, v17 })
    do (v3)[v16] = v19 end
else
end
local v20 = (v3)[v4]
local v21 = type(v20) == "function"
if v21 then
    local v22 = closure2({ v0, v1, v2, v20 })
    do (v3)[v4] = v22 end
else
end
local v23 = "talk"
local v24 = (v3)[v23]
local v25 = type(v24) == "function"
if v25 then
    local v26 = closure2({ v0, v1, v2, v24 })
    do (v3)[v23] = v26 end
else
end
local v27 = "talkChannel"
local v28 = (v3)[v27]
local v29 = type(v28) == "function"
if v29 then
    local v30 = closure3({ v0, v1, v2, v28 })
    do (v3)[v27] = function(a, b, c) return (v30)({ a, b, c }) end end
else
end
local v31 = "use"
local v32 = (v3)[v31]
local v33 = type(v32) == "function"
if v33 then
    local v34 = closure2({ v0, v1, v2, v32 })
    do (v3)[v31] = v34 end
else
end
local v35 = "useWith"
local v36 = (v3)[v35]
local v37 = type(v36) == "function"
if v37 then
    local v38 = closure4({ v0, v1, v2, v36 })
    do (v3)[v35] = function(a, b) return (v38)({ a, b }) end end
else
end
local v39 = "useInventoryItem"
local v40 = (v3)[v39]
local v41 = type(v40) == "function"
if v41 then
    local v42 = closure2({ v0, v1, v2, v40 })
    do (v3)[v39] = v42 end
else
end
local v43 = "useInventoryItemWith"
local v44 = (v3)[v43]
local v45 = type(v44) == "function"
if v45 then
    local v46 = closure4({ v0, v1, v2, v44 })
    do (v3)[v43] = function(a, b) return (v46)({ a, b }) end end
else
end
local v47 = "move"
local v48 = (v3)[v47]
local v49 = type(v48) == "function"
if v49 then
    local v50 = closure3({ v0, v1, v2, v48 })
    do (v3)[v47] = function(a, b, c) return (v50)({ a, b, c }) end end
else
end
local v51 = "cancelAttack"
local v52 = (v3)[v51]
local v53 = type(v52) == "function"
if v53 then
    local v54 = closure5({ v0, v1, v2, v52 })
    do (v3)[v51] = v54 end
else
end
local v55 = "cancelAttackAndFollow"
local v56 = (v3)[v55]
local v57 = type(v56) == "function"
if v57 then
    local v58 = closure5({ v0, v1, v2, v56 })
    do (v3)[v55] = v58 end
else
end
local v59 = LocalPlayer
local v60 = (v59) ~= nil
if v60 then
    local v61 = "autoWalk"
    local v62 = (v59)[v61]
    local v63 = type(v62) == "function"
    if v63 then
        local v64 = closure4({ v0, v1, v2, v62 })
        do (v59)[v61] = function(a, b) return (v64)({ a, b }) end end
    else
    end
else
end
local v65 = g_map
local v66 = "getSpectators"
local v67 = (v65)[v66]
local v68 = closure6({ v67 })
g_map.getSpectators = function(a, b) return (v68)({ a, b }) end
local v69 = closure7({ v0, v1, v2 })
ArenaParity = { summary = v69 }
return nil
