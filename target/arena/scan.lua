local function spiral_wrap_unsigned(value, bits)
    return value % (2 ^ bits)
end
local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local function spiral_mul_mod32(a, b)
    a = a % 4294967296
    b = b % 4294967296
    local a_low = a % 65536
    local a_high = (a - a_low) / 65536
    return (a_low * b + ((a_high * b) % 65536) * 65536) % 4294967296
end
local Mut0, Us0_Free, Us0_Ramp, Us0_Occupied, Us0_Blocked, Us0_Unknown, closure0, format_real_1, cells_3, closure4, method4, rows_2, closure5, scan_then_finish_c3, closure2, closure6, closure8, closure7, closure9, poll_0, closure1, closure10
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

function Us0_Free() return { tag = "Us0_Free" } end
function Us0_Ramp() return { tag = "Us0_Ramp" } end
function Us0_Occupied() return { tag = "Us0_Occupied" } end
function Us0_Blocked() return { tag = "Us0_Blocked" } end
function Us0_Unknown() return { tag = "Us0_Unknown" } end

function closure0(capt)
    return function(dom)
        local v0 = "TIBIA_PROBE_HIDDEN"
        local v1 = "1"
        local v2 = os.getenv(v0) == (v1)
        if v2 then
            g_window.move({ x = -32000, y = -32000 })
            g_window.hide()
        else
        end
        g_settings.set("enableAudio", false)
        if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
        return nil
    end
end

function format_real_1(v0)
    local v1 = ""
    local v2 = { __tag = "Mut0", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function cells_3(v0, v1, v2, v3, v4, v5, v6, v7)
    local v8 = v6 > v4
    if v8 then
        return v7
    else
        local v9 = v6 == 0
        local getv11 = function()
            if v9 then
                local v10 = v5 == 0
                return v10
            else
                return false
            end
        end
        local v11 = getv11()
        local getv36 = function()
            if v11 then
                local v12 = "K"
                return v12
            else
                local v13 = spiral_wrap_signed((v1 + v6), 32)
                local v14 = spiral_wrap_signed((v2 + v5), 32)
                local v15 = (function() local tile = g_map.getTile({ x = v13, y = v14, z = v3 }); if not tile then return 4 elseif tile:isWalkable() and not tile:hasFloorChange() then return 0 elseif tile:isWalkable() then return 1 elseif tile:isWalkable(true) then return 2 else return 3 end end)()
                local v16 = v15 == 0
                local getv28 = function()
                    if v16 then
                        return Us0_Free()
                    else
                        local v18 = v15 == 1
                        if v18 then
                            return Us0_Ramp()
                        else
                            local v20 = v15 == 2
                            if v20 then
                                return Us0_Occupied()
                            else
                                local v22 = v15 == 3
                                if v22 then
                                    return Us0_Blocked()
                                else
                                    return Us0_Unknown()
                                end
                            end
                        end
                    end
                end
                local v28 = getv28()
                local __v = { v28 }
                if __v[1] ~= nil and __v[1].tag == "Us0_Blocked" then
                    local v32 = "#"
                    return v32
                elseif __v[1] ~= nil and __v[1].tag == "Us0_Unknown" then
                    if v0 then
                        local v29 = "?"
                        return v29
                    else
                        local v30 = "#"
                        return v30
                    end
                else
                    local v33 = "."
                    return v33
                end
            end
        end
        local v36 = getv36()
        local v37 = spiral_wrap_signed((v6 + 1), 32)
        local v38 = v7 .. v36 
        return cells_3(v0, v1, v2, v3, v4, v5, v37, v38)
    end
end

function closure4(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        local v4 = v2 >= v0
        if v4 then
            return v3
        else
            local v5 = spiral_wrap_signed((v2 + 1), 32)
            local v6 = method4(v0, v1, v5)
            local v7 = v3 .. v1 
            return v6(v7)
        end
    end
end

function method4(v0, v1, v2)
    return closure4({ v0, v1, v2 })
end

function rows_2(v0, v1, v2, v3, v4, v5)
    local v6 = v5 <= v1
    if v6 then
        local v7 = spiral_wrap_signed(-(v1), 32)
        local v8 = ""
        local v9 = cells_3(v0, v2, v3, v4, v1, v5, v7, v8)
        local v10 = v5 >= 0
        local getv12 = function()
            if v10 then
                local v11 = "+"
                return v11
            else
                return v8
            end
        end
        local v12 = getv12()
        local v13 = format_real_1(v5)
        local v14 = v12 .. v13 
        local v15 = tostring(" ")       
        local v16 = string.len(v14)
        local v17 = spiral_wrap_signed((3 - v16), 32)
        local v18 = 0
        local v19 = method4(v17, v15, v18)
        local v20 = v19(v8)
        local v21 = v20 .. v14 
        local v22 = " "
        local v23 = v21 .. v22 
        local v24 = v23 .. v9 
        local v25 = "[tibia-probe] "
        local v26 = v25 .. v24 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v26)
        g_logger.info(v26)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v27 = spiral_wrap_signed((v5 + 1), 32)
        return rows_2(v0, v1, v2, v3, v4, v27)
    else
    end
end

function closure5(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function scan_then_finish_c3(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local getv8 = function()
            if v1 then
                local v6 = " (# wall or blocked, . walkable, ? not loaded by the client, K knight)"
                return v6
            else
                local v7 = " (# wall or blocked, . walkable, K knight)"
                return v7
            end
        end
        local v8 = getv8()
        local v9 = format_real_1(v3)
        local v10 = ""
        local v11 = v10 .. v9 
        local v12 = ","
        local v13 = v11 .. v12 
        local v14 = format_real_1(v4)
        local v15 = v13 .. v14 
        local v16 = v15 .. v12 
        local v17 = format_real_1(v5)
        local v18 = v16 .. v17 
        local v19 = "scan around "
        local v20 = v19 .. v18 
        local v21 = v20 .. v8 
        local v22 = "[tibia-probe] "
        local v23 = v22 .. v21 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v23)
        g_logger.info(v23)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v24 = spiral_wrap_signed(-(v0), 32)
        rows_2(v1, v0, v3, v4, v5, v24)
        local v25 = "finish: "
        local v26 = "scanned"
        local v27 = v25 .. v26 
        local v28 = v22 .. v27 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v28)
        g_logger.info(v28)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v29 = g_game.isOnline()
        if v29 then
            g_game.safeLogout()
        else
        end
        local v30 = closure5(nil)
        scheduleEvent(v30, 2000)
        return nil
    end
end

function closure2(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = scan_then_finish_c3({ v0, v1 })
        scheduleEvent(v2, 2500)
        return nil
    end
end

function closure6(capt)
    return function(v0)
        local v1 = "game login error: "
        local v2 = v1 .. v0 
        local v3 = "[tibia-probe] "
        local v4 = v3 .. v2 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v4)
        g_logger.info(v4)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v5 = "finish: "
        local v6 = "game login error"
        local v7 = v5 .. v6 
        local v8 = v3 .. v7 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v8)
        g_logger.info(v8)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v9 = g_game.isOnline()
        if v9 then
            g_game.safeLogout()
        else
        end
        local v10 = closure5(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure8(capt)
    return function(v0)
        return nil
    end
end

function closure7(capt)
    return function(v0)
        return closure8(nil)
    end
end

function closure9(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2, v3)
    end
end

function poll_0(v0, v1, v2, v3)
    local v4 = v0 == ""
    local getv8 = function()
        if v4 then
            return true
        else
            local v5 = "/"
            local v6 = v5 .. v0 
            local v7 = g_resources.fileExists(v6)
            return v7
        end
    end
    local v8 = getv8()
    if v8 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v9 = closure2({ v2, v3 })
        local v10 = closure6(nil)
        local v11 = closure7(nil)
        connect(g_game, { onGameStart = v9, onLoginError = function(message) (v10)(tostring(message)) end, onTextMessage = function(mode, text) (v11)(tostring(mode))(tostring(text)) end })
        local v12 = "@god"
        local v13 = "@god\ngod"
        g_game.loginWorld(v12, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v13)
        return nil
    else
        local v14 = closure9({ v0, v1, v2, v3 })
        scheduleEvent(v14, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = "TIBIA_LOGIN_GATE"
        local v4 = ""
        local v5 = os.getenv(v3) or (v4)
        return poll_0(v5, v0, v1, v2)
    end
end

function closure10(capt)
    return function(dom)
        local v0 = "finish: "
        local v1 = "timeout"
        local v2 = v0 .. v1 
        local v3 = "[tibia-probe] "
        local v4 = v3 .. v2 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v4)
        g_logger.info(v4)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v5 = g_game.isOnline()
        if v5 then
            g_game.safeLogout()
        else
        end
        local v6 = closure5(nil)
        scheduleEvent(v6, 2000)
        return nil
    end
end

local v0 = 12
local v1 = "TIBIA_SCAN_MARKS_UNLOADED"
local v2 = "1"
local v3 = os.getenv(v1) == (v2)
local v4 = "TIBIA_ARENA_CHARACTER"
local v5 = "Knight Sample"
local v6 = os.getenv(v4) or (v5)
local v7 = "TIBIA_PROBE_HIDDEN"
local v8 = os.getenv(v7) == (v2)
if v8 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v9 = closure0(nil)
scheduleEvent(v9, 200)
scheduleEvent(v9, 1000)
local v10 = closure1({ v6, v0, v3 })
scheduleEvent(v10, 3000)
local v11 = closure10(nil)
scheduleEvent(v11, 40000)
return 0
