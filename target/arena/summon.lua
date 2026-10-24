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
local Uh0_Nil, Uh0_Cons, Mut0, Us0_Some, Us0_None, Mut1, method0, method1, method2, closure0, format_real_4, closure4, schedule_5, each_6, closure6, closure5, closure3, ready_c2, closure7, closure9, on_text_c8, closure10, poll_3, closure1, closure11
function Uh0_Nil() return { tag = "Uh0_Nil" } end
function Uh0_Cons(v0, v1) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1 } end

Mut0 = function(l0, l1) return { __tag = "Mut0", l0 = l0, l1 = l1 } end

function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

function method0(v0)
    local v1 = v0 ~= nil and v0.l0
    local v2 = v1 > 0
    return v2
end

function method1(v0, v1)
    local __v = { v0 }
    if __v[1] ~= nil and __v[1].tag == "Uh0_Cons" then
        local v2 = __v[1]._1
        local v3 = __v[1]._2
        local v4 = spiral_wrap_signed((v1 + 1), 32)
        return method1(v3, v4)
    elseif __v[1] ~= nil and __v[1].tag == "Uh0_Nil" then
        return v1
    end
end

function method2(v0, v1, v2)
    local __v = { v1 }
    if __v[1] ~= nil and __v[1].tag == "Uh0_Cons" then
        local v3 = __v[1]._1
        local v4 = __v[1]._2
        v0[(v2)+1] = v3
        local v5 = spiral_wrap_signed((v2 + 1), 32)
        return method2(v0, v4, v5)
    elseif __v[1] ~= nil and __v[1].tag == "Uh0_Nil" then
        return v2
    end
end

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

function format_real_4(v0)
    local v1 = ""
    local v2 = { __tag = "Mut1", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure4(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = "/m "
        local v2 = v1 .. v0 
        g_game.talk(v2)
        return nil
    end
end

function schedule_5(v0, v1, v2)
    local v3 = v2 <= v1
    if v3 then
        local v4 = spiral_wrap_signed((v2 - 1), 32)
        local v5 = (v0)[(v4)+1]
        local v6 = spiral_wrap_signed(spiral_mul_mod32(500, v4), 32)
        local v7 = spiral_wrap_signed((1200 + v6), 32)
        local v8 = closure4({ v5 })
        scheduleEvent(v8, v7)
        local v9 = spiral_wrap_signed((v2 + 1), 32)
        return schedule_5(v0, v1, v9)
    else
    end
end

function each_6(v0, v1, v2)
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
        local v10 = (v4):getPosition()
        local v11 = v10.x
        local v12 = v10.y
        local v13 = v10.z
        local v14 = format_real_4(v11)
        local v15 = ""
        local v16 = v15 .. v14 
        local v17 = ","
        local v18 = v16 .. v17 
        local v19 = format_real_4(v12)
        local v20 = v18 .. v19 
        local v21 = v20 .. v17 
        local v22 = format_real_4(v13)
        local v23 = v21 .. v22 
        local v24 = "sees "
        local v25 = v24 .. v5 
        local v26 = " monster="
        local v27 = v25 .. v26 
        local v28 = v27 .. v9 
        local v29 = " at "
        local v30 = v28 .. v29 
        local v31 = v30 .. v23 
        local v32 = "[tibia-probe] "
        local v33 = v32 .. v31 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v33)
        g_logger.info(v33)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v34 = spiral_wrap_signed((v2 + 1), 32)
        return each_6(v0, v1, v34)
    else
    end
end

function closure6(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function closure5(capt)
    return function(dom)
        local v0 = g_game.getLocalPlayer():getPosition()
        local v1 = v0.x
        local v2 = v0.y
        local v3 = v0.z
        local v4 = g_map.getSpectators({ x = v1, y = v2, z = v3 }, false)
        local v5 = #(v4)
        local v6 = 1
        each_6(v4, v5, v6)
        local v7 = "finish: "
        local v8 = "summoned"
        local v9 = v7 .. v8 
        local v10 = "[tibia-probe] "
        local v11 = v10 .. v9 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v11)
        g_logger.info(v11)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v12 = g_game.isOnline()
        if v12 then
            g_game.safeLogout()
        else
        end
        local v13 = closure6(nil)
        scheduleEvent(v13, 2000)
        return nil
    end
end

function closure3(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local v6 = format_real_4(v3)
        local v7 = ""
        local v8 = v7 .. v6 
        local v9 = ","
        local v10 = v8 .. v9 
        local v11 = format_real_4(v4)
        local v12 = v10 .. v11 
        local v13 = v12 .. v9 
        local v14 = format_real_4(v5)
        local v15 = v13 .. v14 
        local v16 = "at "
        local v17 = v16 .. v15 
        local v18 = "[tibia-probe] "
        local v19 = v18 .. v17 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v19)
        g_logger.info(v19)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v20 = "/pos "
        local v21 = v20 .. v0 
        local v22 = ", 7"
        local v23 = v21 .. v22 
        g_game.talk(v23)
        local v24 = #(v1)
        local v25 = 1
        schedule_5(v1, v24, v25)
        local v26 = closure5(nil)
        scheduleEvent(v26, 4000)
        return nil
    end
end

function ready_c2(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getName()
        local v3 = "in game as "
        local v4 = v3 .. v2 
        local v5 = "[tibia-probe] "
        local v6 = v5 .. v4 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v6)
        g_logger.info(v6)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v7 = closure3({ v0, v1 })
        scheduleEvent(v7, 1500)
        return nil
    end
end

function closure7(capt)
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
        local v10 = closure6(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure9(capt)
    return function(v0)
        local v1 = "server text: "
        local v2 = v1 .. v0 
        local v3 = "[tibia-probe] "
        local v4 = v3 .. v2 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v4)
        g_logger.info(v4)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        return nil
    end
end

function on_text_c8(capt)
    return function(v0)
        return closure9(nil)
    end
end

function closure10(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_3(v0, v1, v2)
    end
end

function poll_3(v0, v1, v2)
    local v3 = v0 == ""
    local getv7 = function()
        if v3 then
            return true
        else
            local v4 = "/"
            local v5 = v4 .. v0 
            local v6 = g_resources.fileExists(v5)
            return v6
        end
    end
    local v7 = getv7()
    if v7 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v8 = ready_c2({ v1, v2 })
        local v9 = closure7(nil)
        local v10 = on_text_c8(nil)
        connect(g_game, { onGameStart = v8, onLoginError = function(message) (v9)(tostring(message)) end, onTextMessage = function(mode, text) (v10)(tostring(mode))(tostring(text)) end })
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
        local v4 = os.getenv(v2) or (v3)
        return poll_3(v4, v0, v1)
    end
end

function closure11(capt)
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
        local v6 = closure6(nil)
        scheduleEvent(v6, 2000)
        return nil
    end
end

local v0 = "TIBIA_SUMMON_AT"
local v1 = "1932, 1352"
local v2 = os.getenv(v0) or (v1)
local v3 = "TIBIA_SUMMON_ORDERS"
local v4 = "green frog,3,,2"
local v5 = os.getenv(v3) or (v4)
local v6 = ";"
local v7 = (function(s, sep) if sep == "" then return {s} end local parts, from = {}, 1 while true do local at = string.find(s, sep, from, true) if not at then parts[#parts + 1] = string.sub(s, from) return parts end parts[#parts + 1] = string.sub(s, from, at - 1) from = at + #sep end end)(v5, v6)
local v8 = #(v7)
local v9 = Uh0_Nil()
local v10 = { __tag = "Mut0", l0 = v8, l1 = v9 }
while method0(v10) do
    local v12 = v10 ~= nil and v10.l0
    local v13 = spiral_wrap_signed((v12 - 1), 32)
    local v14 = v10 ~= nil and v10.l1
    local v15 = (v7)[(v13)+1]
    local v16 = v15 == ""
    local getv19 = function()
        if v16 then
            return Us0_None()
        else
            return Us0_Some(v15)
        end
    end
    local v19 = getv19()
    local getv23 = function()
        local __v = { v19 }
        if __v[1] ~= nil and __v[1].tag == "Us0_None" then
            return v14
        elseif __v[1] ~= nil and __v[1].tag == "Us0_Some" then
            local v20 = __v[1]._1
            return Uh0_Cons(v20, v14)
        end
    end
    local v23 = getv23()
    v10.l0 = v13
    v10.l1 = v23
end
local v24 = v10 ~= nil and v10.l1
local v25 = 0
local v26 = method1(v24, v25)
local v27 = (function(n) local t = {} for i = 1, n do t[i] = "" end return t end)(v26)
local v28 = 0
local v29 = method2(v27, v24, v28)
local v30 = "TIBIA_PROBE_HIDDEN"
local v31 = "1"
local v32 = os.getenv(v30) == (v31)
if v32 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v33 = closure0(nil)
scheduleEvent(v33, 200)
scheduleEvent(v33, 1000)
local v34 = closure1({ v2, v27 })
scheduleEvent(v34, 3000)
local v35 = closure11(nil)
scheduleEvent(v35, 60000)
return 0
