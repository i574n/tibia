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
local Mut0, Uh0_Cons, Mut1, Us0_Some, Us0_None, Mut2, get_environment_variable_1, env_text_0, split_matches_from_4, split_next_from_3, split_count_2, method5, split_start_of_6, method7, method8, method9, mute_10, closure0, file_exists_12, log_flush_14, write_log_line_13, closure3, typed_c2, closure5, typed_c4, format_real_15, closure8, schedule_16, creatures_from_17, closure9, closure7, closure6, closure10, poll_11, closure1, closure11
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1 } end

Mut1 = function(l0, l1) return { __tag = "Mut1", l0 = l0, l1 = l1 } end

function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

function get_environment_variable_1(v0)
    local v1 = os.getenv(v0) or ""
    return v1
end

function env_text_0(v0, v1)
    local v2 = get_environment_variable_1(v0)
    local v3 = v2 == ""
    if v3 then
        return v1
    else
        return v2
    end
end

function split_matches_from_4(v0, v1, v2, v3)
    local v4 = string.len(v1)
    local v5 = v3 >= v4
    if v5 then
        return true
    else
        local v6 = spiral_wrap_signed((v2 + v3), 32)
        local v7 = string.sub(v0, (v6)+1, (v6)+1)
        local v8 = string.sub(v1, (v3)+1, (v3)+1)
        local v9 = v7 == v8
        if v9 then
            local v10 = spiral_wrap_signed((v3 + 1), 32)
            return split_matches_from_4(v0, v1, v2, v10)
        else
            return false
        end
    end
end

function split_next_from_3(v0, v1, v2)
    local v3 = string.len(v1)
    local v4 = spiral_wrap_signed((v2 + v3), 32)
    local v5 = string.len(v0)
    local v6 = v4 > v5
    if v6 then
        return v5
    else
        local v7 = 0
        local v8 = split_matches_from_4(v0, v1, v2, v7)
        if v8 then
            return v2
        else
            local v9 = spiral_wrap_signed((v2 + 1), 32)
            return split_next_from_3(v0, v1, v9)
        end
    end
end

function split_count_2(v0, v1, v2, v3)
    local v4 = split_next_from_3(v0, v1, v2)
    local v5 = string.len(v0)
    local v6 = v4 >= v5
    if v6 then
        return v3
    else
        local v7 = string.len(v1)
        local v8 = spiral_wrap_signed((v4 + v7), 32)
        local v9 = spiral_wrap_signed((v3 + 1), 32)
        return split_count_2(v0, v1, v8, v9)
    end
end

function method5(v0, v1)
    local v2 = v1 ~= nil and v1.l0
    local v3 = v2 < v0
    return v3
end

function split_start_of_6(v0, v1, v2, v3)
    local v4 = v2 == 0
    if v4 then
        return v3
    else
        local v5 = spiral_wrap_signed((v2 - 1), 32)
        local v6 = split_next_from_3(v0, v1, v3)
        local v7 = string.len(v1)
        local v8 = spiral_wrap_signed((v6 + v7), 32)
        return split_start_of_6(v0, v1, v5, v8)
    end
end

function method7(v0)
    local v1 = v0 ~= nil and v0.l0
    local v2 = v1 > 0
    return v2
end

function method8(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = spiral_wrap_signed((v1 + 1), 32)
        return method8(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method9(v0, v1, v2)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v3 = v1._1
        local v4 = v1._2
        v0[(v2)+1] = v3
        local v5 = spiral_wrap_signed((v2 + 1), 32)
        return method9(v0, v4, v5)
    elseif v1 ~= nil and v1.tag == "Uh0_Nil" then
        return v2
    end
end

function mute_10()
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
        local v1 = get_environment_variable_1(v0)
        local v2 = v1 == "1"
        if v2 then
            g_window.move({ x = -32000, y = -32000 })
            g_window.hide()
        else
        end
        return mute_10()
    end
end

function file_exists_12(v0)
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

function log_flush_14()
    local v0 = table.concat(TibiaProbeLog, string.char(10))
    local v1 = "\n"
    local v2 = v0 .. v1 
    g_resources.writeFileContents("/tibia-probe.log", v2)
    return nil
end

function write_log_line_13(v0)
    local v1 = TibiaProbeLog == nil
    if v1 then
        TibiaProbeLog = {}
    else
    end
    table.insert(TibiaProbeLog, v0)
    g_logger.info(v0)
    return log_flush_14()
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
        write_log_line_13(v5)
        local v6 = "finish: "
        local v7 = "game login error"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        write_log_line_13(v9)
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
        local v4 = "server text: "
        local v5 = v4 .. v3 
        local v6 = "[tibia-probe] "
        local v7 = v6 .. v5 
        return write_log_line_13(v7)
    end
end

function typed_c4(capt)
    return function(v0)
        return closure5({ v0 })
    end
end

function format_real_15(v0)
    local v1 = ""
    local v2 = { __tag = "Mut2", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure8(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = "/m "
        local v2 = v1 .. v0 
        g_game.talk(v2)
        return nil
    end
end

function schedule_16(v0, v1, v2)
    local v3 = v2 <= v1
    if v3 then
        local v4 = spiral_wrap_signed((v2 - 1), 32)
        local v5 = (v0)[(v4)+1]
        local v6 = spiral_wrap_signed(spiral_mul_mod32(500, v4), 32)
        local v7 = spiral_wrap_signed((1200 + v6), 32)
        local v8 = closure8({ v5 })
        scheduleEvent(v8, v7)
        local v9 = spiral_wrap_signed((v2 + 1), 32)
        return schedule_16(v0, v1, v9)
    else
    end
end

function creatures_from_17(v0, v1, v2)
    local v3 = v2 <= v1
    if v3 then
        local v4 = (v0)[v2]
        local v5 = (v4):getName()
        local v6 = (v4):isMonster()
        local getv9 = function()
            if v6 then
                local v7 = "true"
                return v7
            else
                local v8 = "false"
                return v8
            end
        end
        local v9 = getv9()
        local v10 = "sees "
        local v11 = v10 .. v5 
        local v12 = " monster="
        local v13 = v11 .. v12 
        local v14 = v13 .. v9 
        local v15 = " at "
        local v16 = v14 .. v15 
        local v17 = (v4):getPosition()
        local v18 = v17.x
        local v19 = v17.y
        local v20 = v17.z
        local v21 = format_real_15(v18)
        local v22 = ""
        local v23 = v22 .. v21 
        local v24 = ","
        local v25 = v23 .. v24 
        local v26 = format_real_15(v19)
        local v27 = v25 .. v26 
        local v28 = v27 .. v24 
        local v29 = format_real_15(v20)
        local v30 = v28 .. v29 
        local v31 = v16 .. v30 
        local v32 = "[tibia-probe] "
        local v33 = v32 .. v31 
        write_log_line_13(v33)
        local v34 = spiral_wrap_signed((v2 + 1), 32)
        return creatures_from_17(v0, v1, v34)
    else
    end
end

function closure9(capt)
    return function(dom)
        local v0 = g_game.getLocalPlayer():getPosition()
        local v1 = v0.x
        local v2 = v0.y
        local v3 = v0.z
        local v4 = g_map.getSpectators({ x = v1, y = v2, z = v3 }, false)
        local v5 = #(v4)
        local v6 = 1
        creatures_from_17(v4, v5, v6)
        local v7 = "finish: "
        local v8 = "summoned"
        local v9 = v7 .. v8 
        local v10 = "[tibia-probe] "
        local v11 = v10 .. v9 
        write_log_line_13(v11)
        local v12 = g_game.isOnline()
        if v12 then
            g_game.safeLogout()
        else
        end
        local v13 = closure3(nil)
        scheduleEvent(v13, 2000)
        return nil
    end
end

function closure7(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local v6 = format_real_15(v3)
        local v7 = ""
        local v8 = v7 .. v6 
        local v9 = ","
        local v10 = v8 .. v9 
        local v11 = format_real_15(v4)
        local v12 = v10 .. v11 
        local v13 = v12 .. v9 
        local v14 = format_real_15(v5)
        local v15 = v13 .. v14 
        local v16 = "at "
        local v17 = v16 .. v15 
        local v18 = "[tibia-probe] "
        local v19 = v18 .. v17 
        write_log_line_13(v19)
        local v20 = "/pos "
        local v21 = v20 .. v0 
        local v22 = ", 7"
        local v23 = v21 .. v22 
        g_game.talk(v23)
        local v24 = #(v1)
        local v25 = 1
        schedule_16(v1, v24, v25)
        local v26 = closure9(nil)
        scheduleEvent(v26, 4000)
        return nil
    end
end

function closure6(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getName()
        local v3 = "in game as "
        local v4 = v3 .. v2 
        local v5 = "[tibia-probe] "
        local v6 = v5 .. v4 
        write_log_line_13(v6)
        local v7 = closure7({ v1, v0 })
        scheduleEvent(v7, 1500)
        return nil
    end
end

function closure10(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_11(v0, v1, v2)
    end
end

function poll_11(v0, v1, v2)
    local v3 = v0 == ""
    local getv5 = function()
        if v3 then
            return true
        else
            return file_exists_12(v0)
        end
    end
    local v5 = getv5()
    if v5 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v6 = typed_c2(nil)
        local v7 = function(message) (v6)(message) end
        local v8 = typed_c4(nil)
        local v9 = function(mode, text) (v8)(mode)(text) end
        local v10 = closure6({ v1, v2 })
        connect(g_game, { onGameStart = v10, onLoginError = v7, onTextMessage = v9 })
        local v11 = "@god"
        local v12 = "GOD"
        local v13 = "@god\ngod"
        g_game.loginWorld(v11, "god", "OTServBR-Global", "127.0.0.1", 7172, v12, "", v13)
        return nil
    else
        local v14 = closure10({ v0, v1, v2 })
        scheduleEvent(v14, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = "TIBIA_LOGIN_GATE"
        local v3 = ""
        local v4 = env_text_0(v2, v3)
        return poll_11(v4, v0, v1)
    end
end

function closure11(capt)
    return function(dom)
        local v0 = "finish: "
        local v1 = "timeout"
        local v2 = v0 .. v1 
        local v3 = "[tibia-probe] "
        local v4 = v3 .. v2 
        write_log_line_13(v4)
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

local v0 = "TIBIA_SUMMON_AT"
local v1 = "1932, 1352"
local v2 = env_text_0(v0, v1)
local v3 = "TIBIA_SUMMON_ORDERS"
local v4 = "green frog,3,,2"
local v5 = env_text_0(v3, v4)
local v6 = ";"
local v7 = 0
local v8 = 1
local v9 = split_count_2(v5, v6, v7, v8)
local v10 = (function(n) local t = {} for i = 1, n do t[i] = "" end return t end)(v9)
local v11 = { __tag = "Mut0", l0 = 0 }
while method5(v9, v11) do
    local v13 = v11 ~= nil and v11.l0
    local v14 = 0
    local v15 = split_start_of_6(v5, v6, v13, v14)
    local v16 = split_next_from_3(v5, v6, v15)
    local v17 = spiral_wrap_signed((v16 - 1), 32)
    local v18 = string.sub(v5, (v15)+1, (v17)+1)
    v10[(v13)+1] = v18
    local v19 = spiral_wrap_signed((v13 + 1), 32)
    v11.l0 = v19
end
local v20 = #(v10)
local v21 = Uh0_Nil()
local v22 = { __tag = "Mut1", l0 = v20, l1 = v21 }
while method7(v22) do
    local v24 = v22 ~= nil and v22.l0
    local v25 = spiral_wrap_signed((v24 - 1), 32)
    local v26 = v22 ~= nil and v22.l1
    local v27 = (v10)[(v25)+1]
    local v28 = v27 == ""
    local getv31 = function()
        if v28 then
            return Us0_None()
        else
            return Us0_Some(v27)
        end
    end
    local v31 = getv31()
    local getv35 = function()
        if v31 ~= nil and v31.tag == "Us0_None" then
            return v26
        elseif v31 ~= nil and v31.tag == "Us0_Some" then
            local v32 = v31._1
            return Uh0_Cons(v32, v26)
        end
    end
    local v35 = getv35()
    v22.l0 = v25
    v22.l1 = v35
end
local v36 = v22 ~= nil and v22.l1
local v37 = 0
local v38 = method8(v36, v37)
local v39 = (function(n) local t = {} for i = 1, n do t[i] = "" end return t end)(v38)
local v40 = 0
local v41 = method9(v39, v36, v40)
local v42 = "TIBIA_PROBE_HIDDEN"
local v43 = get_environment_variable_1(v42)
local v44 = v43 == "1"
if v44 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_10()
local v45 = closure0(nil)
scheduleEvent(v45, 200)
scheduleEvent(v45, 1000)
local v46 = closure1({ v39, v2 })
scheduleEvent(v46, 3000)
local v47 = closure11(nil)
scheduleEvent(v47, 60000)
return 0
