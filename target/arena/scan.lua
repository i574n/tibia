local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Mut0, Us0_Free, Us0_Ramp, Us0_Occupied, Us0_Blocked, Us0_Unknown, get_environment_variable_0, env_text_1, mute_2, closure0, file_exists_4, log_flush_6, write_log_line_5, closure3, typed_c2, closure5, typed_c4, format_real_7, closure8, method9, footing_of_12, footing_at_11, cells_10, rows_from_8, closure7, closure6, closure9, poll_3, closure1, closure10
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

function Us0_Free() return { tag = "Us0_Free" } end
function Us0_Ramp() return { tag = "Us0_Ramp" } end
function Us0_Occupied() return { tag = "Us0_Occupied" } end
function Us0_Blocked() return { tag = "Us0_Blocked" } end
function Us0_Unknown() return { tag = "Us0_Unknown" } end

function get_environment_variable_0(v0)
    local v1 = os.getenv(v0) or ""
    return v1
end

function env_text_1(v0, v1)
    local v2 = get_environment_variable_0(v0)
    local v3 = v2 == ""
    if v3 then
        return v1
    else
        return v2
    end
end

function mute_2()
    g_settings.set("enableAudio", false)
    local v0 = g_sounds ~= nil
    if v0 then
        g_sounds.setAudioEnabled(false)
        g_sounds.stopAll()
        return nil
    else
    end
end

function closure0(capt)
    return function(dom)
        local v0 = "TIBIA_PROBE_HIDDEN"
        local v1 = get_environment_variable_0(v0)
        local v2 = v1 == "1"
        if v2 then
            g_window.move({ x = -32000, y = -32000 })
            g_window.hide()
        else
        end
        return mute_2()
    end
end

function file_exists_4(v0)
    local v1 = "r"
    local v2 = io.open(v0, v1)
    local v3 = (v2) ~= nil
    if v3 then
        do (v2):close() end
        return true
    else
        return false
    end
end

function log_flush_6()
    local v0 = table.concat(TibiaProbeLog, string.char(10))
    local v1 = "\n"
    local v2 = v0 .. v1 
    g_resources.writeFileContents("/tibia-probe.log", v2)
    return nil
end

function write_log_line_5(v0)
    local v1 = TibiaProbeLog == nil
    if v1 then
        TibiaProbeLog = {}
    else
    end
    table.insert(TibiaProbeLog, v0)
    g_logger.info(v0)
    return log_flush_6()
end

function closure3(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function typed_c2(capt)
    return function(v0)
        local v1 = tostring(v0)
        local v2 = "game login error: "
        local v3 = v2 .. v1 
        local v4 = "[tibia-probe] "
        local v5 = v4 .. v3 
        write_log_line_5(v5)
        local v6 = "finish: "
        local v7 = "game login error"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        write_log_line_5(v9)
        local v10 = g_game.isOnline()
        if v10 then
            g_game.safeLogout()
        else
        end
        local v11 = closure3(nil)
        scheduleEvent(v11, 2000)
        return nil
    end
end

function closure5(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = tostring(v0)
        local v3 = tostring(v1)
        return nil
    end
end

function typed_c4(capt)
    return function(v0)
        return closure5({ v0 })
    end
end

function format_real_7(v0)
    local v1 = ""
    local v2 = { __tag = "Mut0", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure8(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        local v4 = v2 >= v0
        if v4 then
            return v3
        else
            local v5 = spiral_wrap_signed((v2 + 1), 32)
            local v6 = method9(v0, v1, v5)
            local v7 = v3 .. v1 
            return v6(v7)
        end
    end
end

function method9(v0, v1, v2)
    return closure8({ v0, v1, v2 })
end

function footing_of_12(v0, v1, v2, v3)
    local v4 = v0 == false
    if v4 then
        return Us0_Unknown()
    else
        local getv7 = function()
            if v1 then
                local v6 = v2 == false
                return v6
            else
                return false
            end
        end
        local v7 = getv7()
        if v7 then
            return Us0_Free()
        else
            if v1 then
                return Us0_Ramp()
            else
                if v3 then
                    return Us0_Occupied()
                else
                    return Us0_Blocked()
                end
            end
        end
    end
end

function footing_at_11(v0, v1, v2)
    local v3 = g_map.getTile({ x = v0, y = v1, z = v2 })
    local v4 = (v3) ~= nil
    if v4 then
        local v5 = true
        local v6 = (v3):isWalkable()
        local v7 = (v3):hasFloorChange()
        local v8 = (v3):isWalkable(true)
        return footing_of_12(v5, v6, v7, v8)
    else
        return Us0_Unknown()
    end
end

function cells_10(v0, v1, v2, v3, v4, v5, v6, v7)
    local v8 = v6 > v4
    if v8 then
        return v7
    else
        local v9 = spiral_wrap_signed((v6 + 1), 32)
        local v10 = v6 == 0
        local getv12 = function()
            if v10 then
                local v11 = v5 == 0
                return v11
            else
                return false
            end
        end
        local v12 = getv12()
        local getv24 = function()
            if v12 then
                local v13 = "K"
                return v13
            else
                local v14 = spiral_wrap_signed((v1 + v6), 32)
                local v15 = spiral_wrap_signed((v2 + v5), 32)
                local v16 = footing_at_11(v14, v15, v3)
                if v16 ~= nil and v16.tag == "Us0_Blocked" then
                    local v20 = "#"
                    return v20
                elseif v16 ~= nil and v16.tag == "Us0_Unknown" then
                    if v0 then
                        local v17 = "?"
                        return v17
                    else
                        local v18 = "#"
                        return v18
                    end
                else
                    local v21 = "."
                    return v21
                end
            end
        end
        local v24 = getv24()
        local v25 = v7 .. v24 
        return cells_10(v0, v1, v2, v3, v4, v5, v9, v25)
    end
end

function rows_from_8(v0, v1, v2, v3, v4, v5)
    local v6 = v5 <= v4
    if v6 then
        local v7 = v5 >= 0
        local getv10 = function()
            if v7 then
                local v8 = "+"
                return v8
            else
                local v9 = ""
                return v9
            end
        end
        local v10 = getv10()
        local v11 = format_real_7(v5)
        local v12 = v10 .. v11 
        local v13 = tostring(" ")       
        local v14 = string.len(v12)
        local v15 = spiral_wrap_signed((3 - v14), 32)
        local v16 = 0
        local v17 = method9(v15, v13, v16)
        local v18 = ""
        local v19 = v17(v18)
        local v20 = v19 .. v12 
        local v21 = " "
        local v22 = v20 .. v21 
        local v23 = spiral_wrap_signed(-(v4), 32)
        local v24 = cells_10(v0, v1, v2, v3, v4, v5, v23, v18)
        local v25 = v22 .. v24 
        local v26 = "[tibia-probe] "
        local v27 = v26 .. v25 
        write_log_line_5(v27)
        local v28 = spiral_wrap_signed((v5 + 1), 32)
        return rows_from_8(v0, v1, v2, v3, v4, v28)
    else
    end
end

function closure7(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local v6 = format_real_7(v3)
        local v7 = ""
        local v8 = v7 .. v6 
        local v9 = ","
        local v10 = v8 .. v9 
        local v11 = format_real_7(v4)
        local v12 = v10 .. v11 
        local v13 = v12 .. v9 
        local v14 = format_real_7(v5)
        local v15 = v13 .. v14 
        local v16 = "scan around "
        local v17 = v16 .. v15 
        local getv20 = function()
            if v1 then
                local v18 = " (# wall or blocked, . walkable, ? not loaded by the client, K knight)"
                return v18
            else
                local v19 = " (# wall or blocked, . walkable, K knight)"
                return v19
            end
        end
        local v20 = getv20()
        local v21 = v17 .. v20 
        local v22 = "[tibia-probe] "
        local v23 = v22 .. v21 
        write_log_line_5(v23)
        local v24 = spiral_wrap_signed(-(v0), 32)
        rows_from_8(v1, v3, v4, v5, v0, v24)
        local v25 = "finish: "
        local v26 = "scanned"
        local v27 = v25 .. v26 
        local v28 = v22 .. v27 
        write_log_line_5(v28)
        local v29 = g_game.isOnline()
        if v29 then
            g_game.safeLogout()
        else
        end
        local v30 = closure3(nil)
        scheduleEvent(v30, 2000)
        return nil
    end
end

function closure6(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = closure7({ v0, v1 })
        scheduleEvent(v2, 2500)
        return nil
    end
end

function closure9(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_3(v0, v1, v2, v3)
    end
end

function poll_3(v0, v1, v2, v3)
    local v4 = v0 == ""
    local getv6 = function()
        if v4 then
            return true
        else
            return file_exists_4(v0)
        end
    end
    local v6 = getv6()
    if v6 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v7 = typed_c2(nil)
        local v8 = function(message) (v7)(message) end
        local v9 = typed_c4(nil)
        local v10 = function(mode, text) (v9)(mode)(text) end
        local v11 = closure6({ v2, v3 })
        connect(g_game, { onGameStart = v11, onLoginError = v8, onTextMessage = v10 })
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
        local v5 = env_text_1(v3, v4)
        return poll_3(v5, v0, v1, v2)
    end
end

function closure10(capt)
    return function(dom)
        local v0 = "finish: "
        local v1 = "timeout"
        local v2 = v0 .. v1 
        local v3 = "[tibia-probe] "
        local v4 = v3 .. v2 
        write_log_line_5(v4)
        local v5 = g_game.isOnline()
        if v5 then
            g_game.safeLogout()
        else
        end
        local v6 = closure3(nil)
        scheduleEvent(v6, 2000)
        return nil
    end
end

local v0 = 12
local v1 = "TIBIA_SCAN_MARKS_UNLOADED"
local v2 = get_environment_variable_0(v1)
local v3 = v2 == "1"
local v4 = "TIBIA_ARENA_CHARACTER"
local v5 = "Knight Sample"
local v6 = env_text_1(v4, v5)
local v7 = "TIBIA_PROBE_HIDDEN"
local v8 = get_environment_variable_0(v7)
local v9 = v8 == "1"
if v9 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_2()
local v10 = closure0(nil)
scheduleEvent(v10, 200)
scheduleEvent(v10, 1000)
local v11 = closure1({ v6, v0, v3 })
scheduleEvent(v11, 3000)
local v12 = closure10(nil)
scheduleEvent(v12, 40000)
return 0
