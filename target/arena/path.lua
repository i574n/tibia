local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Mut0, Mut1, Us0_Some, Us0_None, Us1_Some, Us1_None, get_environment_variable_1, env_text_0, disable_client_bot_2, mute_3, closure0, file_exists_5, log_flush_7, write_log_line_6, closure3, typed_c2, closure5, typed_c4, format_real_8, player_present_10, live_monster_12, scan_11, closure8, go_9, closure7, ready_c6, closure9, poll_4, closure1, closure10
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

function Us0_Some(v0, v1, v2) return { tag = "Us0_Some",  _1 = v0,  _2 = v1,  _3 = v2 } end
function Us0_None() return { tag = "Us0_None" } end

function Us1_Some(v0, v1) return { tag = "Us1_Some",  _1 = v0,  _2 = v1 } end
function Us1_None() return { tag = "Us1_None" } end

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

function disable_client_bot_2(v0)
    local v1 = g_settings.getNode("bot")
    local v2 = (v1) ~= nil
    local getv4 = function()
        if v2 then
            return v1
        else
            local v3 = {}
            return v3
        end
    end
    local v4 = getv4()
    do (v4)[v0] = { enabled = false } end
    g_settings.setNode("bot", v4)
    g_settings.save()
    return nil
end

function mute_3()
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
        return mute_3()
    end
end

function file_exists_5(v0)
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

function log_flush_7()
    local v0 = table.concat(TibiaProbeLog, string.char(10))
    local v1 = (v0 .. "\n")
    g_resources.writeFileContents("/tibia-probe.log", v1)
    return nil
end

function write_log_line_6(v0)
    local v1 = TibiaProbeLog == nil
    if v1 then
        TibiaProbeLog = {}
    else
    end
    table.insert(TibiaProbeLog, v0)
    g_logger.info(v0)
    return log_flush_7()
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
        local v2 = ("game login error: " .. v1)
        local v3 = ("[tibia-probe] " .. v2)
        write_log_line_6(v3)
        local v4 = "[tibia-probe] finish: game login error"
        write_log_line_6(v4)
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

function closure5(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = tostring(v0)
        local v3 = tostring(v1)
        local v4 = ("server text [" .. v2)
        local v5 = (v4 .. "]: ")
        local v6 = (v5 .. v3)
        local v7 = ("[tibia-probe] " .. v6)
        return write_log_line_6(v7)
    end
end

function typed_c4(capt)
    return function(v0)
        return closure5({ v0 })
    end
end

function format_real_8(v0)
    local v1 = ""
    local v2 = { __tag = "Mut1", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = (v4 .. v3)
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function player_present_10()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function live_monster_12(v0)
    local v1 = (v0):isMonster()
    local getv4 = function()
        if v1 then
            local v2 = (v0):isDead()
            local v3 = v2 == false
            return v3
        else
            return false
        end
    end
    local v4 = getv4()
    if v4 then
        local v5 = (v0):getPosition() ~= nil
        return v5
    else
        return false
    end
end

function scan_11(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 > v4
    if v7 then
        return v6
    else
        local v8 = spiral_wrap_signed((v5 + 1), 32)
        local v9 = (v3)[v5]
        local v10 = live_monster_12(v9)
        local getv33 = function()
            if v10 then
                local v11 = (v9):getPosition()
                local v12 = v11.x
                local v13 = v11.y
                local v14 = v11.z
                local v15 = v12 > v0
                local getv18 = function()
                    if v15 then
                        local v16 = spiral_wrap_signed((v12 - v0), 32)
                        return v16
                    else
                        local v17 = spiral_wrap_signed((v0 - v12), 32)
                        return v17
                    end
                end
                local v18 = getv18()
                local v19 = v13 > v1
                local getv22 = function()
                    if v19 then
                        local v20 = spiral_wrap_signed((v13 - v1), 32)
                        return v20
                    else
                        local v21 = spiral_wrap_signed((v1 - v13), 32)
                        return v21
                    end
                end
                local v22 = getv22()
                local v23 = v18 > v22
                local getv24 = function()
                    if v23 then
                        return v18
                    else
                        return v22
                    end
                end
                local v24 = getv24()
                local getv30 = function()
                    if v6 ~= nil and v6.tag == "Us1_None" then
                        local v28 = v24 < 999
                        return v28
                    elseif v6 ~= nil and v6.tag == "Us1_Some" then
                        local v25 = v6._1
                        local v26 = v6._2
                        local v27 = v24 < v26
                        return v27
                    end
                end
                local v30 = getv30()
                if v30 then
                    return Us1_Some(v5, v24)
                else
                    return v6
                end
            else
                return v6
            end
        end
        local v33 = getv33()
        return scan_11(v0, v1, v2, v3, v4, v8, v33)
    end
end

function closure8(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_9(v0, v1, v2, v3)
    end
end

function go_9(v0, v1, v2, v3)
    local v4 = player_present_10()
    local v5 = v4 == false
    if v5 then
        local v6 = v0 ~= nil and v0.l0
        local v7 = v6 == 0
        if v7 then
            v0.l0 = 1
            local v8 = "[tibia-probe] finish: offline"
            write_log_line_6(v8)
            local v9 = g_game.isOnline()
            if v9 then
                g_game.safeLogout()
            else
            end
            local v10 = closure3(nil)
            scheduleEvent(v10, 2000)
            return nil
        else
        end
    else
        local v11 = g_clock.millis()
        local v12 = spiral_wrap_signed((v11 - v1), 32)
        local v13 = g_game.getLocalPlayer():getPosition()
        local v14 = v13.x
        local v15 = v13.y
        local v16 = v13.z
        local v17 = g_map.getSpectators({ x = v14, y = v15, z = v16 }, false)
        local v18 = #(v17)
        local v19 = 1
        local v20 = Us1_None()
        local v21 = scan_11(v14, v15, v16, v17, v18, v19, v20)
        local getv66 = function()
            if v21 ~= nil and v21.tag == "Us1_None" then
                return { [1]=false, [2]=v2, [3]=v3 }
            elseif v21 ~= nil and v21.tag == "Us1_Some" then
                local v22 = v21._1
                local v23 = v21._2
                local v24 = v23 <= 1
                local v25 = (v17)[v22]
                local v26 = (v25):getPosition()
                local v27 = v26.x
                local v28 = v26.y
                local v29 = v26.z
                local getv40 = function()
                    if v2 ~= nil and v2.tag == "Us0_None" then
                        return { [1]=true, [2]=v3 }
                    elseif v2 ~= nil and v2.tag == "Us0_Some" then
                        local v30 = v2._1
                        local v31 = v2._2
                        local v32 = v2._3
                        local v33 = v27 ~= v30
                        local getv35 = function()
                            if v33 then
                                return true
                            else
                                local v34 = v28 ~= v31
                                return v34
                            end
                        end
                        local v35 = getv35()
                        local getv37 = function()
                            if v35 then
                                local v36 = spiral_wrap_signed((v3 + 1), 32)
                                return v36
                            else
                                return v3
                            end
                        end
                        local v37 = getv37()
                        return { [1]=v35, [2]=v37 }
                    end
                end
                local v40, v41 = (table.unpack or unpack)(getv40())
                if v40 then
                    local v42 = format_real_8(v27)
                    local v43 = ("" .. v42)
                    local v44 = (v43 .. ",")
                    local v45 = format_real_8(v28)
                    local v46 = (v44 .. v45)
                    local v47 = (v46 .. ",")
                    local v48 = format_real_8(v29)
                    local v49 = (v47 .. v48)
                    local v50 = format_real_8(v12)
                    local v51 = ("path t=" .. v50)
                    local v52 = (v51 .. " ms monster at ")
                    local v53 = (v52 .. v49)
                    local v54 = (v53 .. " distance ")
                    local v55 = format_real_8(v23)
                    local v56 = (v54 .. v55)
                    local v57 = (v56 .. " step ")
                    local v58 = format_real_8(v41)
                    local v59 = (v57 .. v58)
                    local v60 = ("[tibia-probe] " .. v59)
                    write_log_line_6(v60)
                else
                end
                local getv62 = function()
                    if v40 then
                        return Us0_Some(v27, v28, v29)
                    else
                        return v2
                    end
                end
                local v62 = getv62()
                return { [1]=v24, [2]=v62, [3]=v41 }
            end
        end
        local v66, v67, v68 = (table.unpack or unpack)(getv66())
        local getv104 = function()
            if v66 then
                local v69 = format_real_8(v14)
                local v70 = ("" .. v69)
                local v71 = (v70 .. ",")
                local v72 = format_real_8(v15)
                local v73 = (v71 .. v72)
                local v74 = (v73 .. ",")
                local v75 = format_real_8(v16)
                local v76 = (v74 .. v75)
                local v77 = format_real_8(v12)
                local v78 = ("arrived at " .. v77)
                local v79 = (v78 .. " ms after ")
                local v80 = format_real_8(v68)
                local v81 = (v79 .. v80)
                local v82 = (v81 .. " steps, knight at ")
                local v83 = (v82 .. v76)
                local v84 = ("[tibia-probe] " .. v83)
                write_log_line_6(v84)
                local v85 = v0 ~= nil and v0.l0
                local v86 = v85 == 0
                if v86 then
                    v0.l0 = 1
                    local v87 = "[tibia-probe] finish: arrived"
                    write_log_line_6(v87)
                    local v88 = g_game.isOnline()
                    if v88 then
                        g_game.safeLogout()
                    else
                    end
                    local v89 = closure3(nil)
                    scheduleEvent(v89, 2000)
                else
                end
                return true
            else
                local v90 = v12 > 30000
                if v90 then
                    local v91 = format_real_8(v12)
                    local v92 = ("not arrived after " .. v91)
                    local v93 = (v92 .. " ms, ")
                    local v94 = format_real_8(v68)
                    local v95 = (v93 .. v94)
                    local v96 = (v95 .. " steps")
                    local v97 = ("[tibia-probe] " .. v96)
                    write_log_line_6(v97)
                    local v98 = v0 ~= nil and v0.l0
                    local v99 = v98 == 0
                    if v99 then
                        v0.l0 = 1
                        local v100 = "[tibia-probe] finish: not arrived"
                        write_log_line_6(v100)
                        local v101 = g_game.isOnline()
                        if v101 then
                            g_game.safeLogout()
                        else
                        end
                        local v102 = closure3(nil)
                        scheduleEvent(v102, 2000)
                    else
                    end
                    return true
                else
                    return false
                end
            end
        end
        local v104 = getv104()
        local v105 = v104 == false
        if v105 then
            local v106 = closure8({ v0, v1, v67, v68 })
            scheduleEvent(v106, 50)
            return nil
        else
        end
    end
end

function closure7(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = g_game.getLocalPlayer():getName()
        local v2 = g_game.getLocalPlayer():getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local v6 = format_real_8(v3)
        local v7 = ("" .. v6)
        local v8 = (v7 .. ",")
        local v9 = format_real_8(v4)
        local v10 = (v8 .. v9)
        local v11 = (v10 .. ",")
        local v12 = format_real_8(v5)
        local v13 = (v11 .. v12)
        local v14 = ("in game as " .. v1)
        local v15 = (v14 .. " at ")
        local v16 = (v15 .. v13)
        local v17 = (v16 .. " (path check, standing, no attack)")
        local v18 = ("[tibia-probe] " .. v17)
        write_log_line_6(v18)
        local v19 = g_clock.millis()
        local v20 = Us0_None()
        local v21 = 0
        return go_9(v0, v19, v20, v21)
    end
end

function ready_c6(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = closure7({ v0 })
        scheduleEvent(v1, 1500)
        return nil
    end
end

function closure9(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_4(v0, v1, v2)
    end
end

function poll_4(v0, v1, v2)
    local v3 = v0 == ""
    local getv5 = function()
        if v3 then
            return true
        else
            return file_exists_5(v0)
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
        local v10 = ready_c6({ v2 })
        connect(g_game, { onGameStart = v10, onLoginError = v7, onTextMessage = v9 })
        local v11 = "@god"
        local v12 = "@god\ngod"
        g_game.loginWorld(v11, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v12)
        return nil
    else
        local v13 = closure9({ v0, v1, v2 })
        scheduleEvent(v13, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = "TIBIA_LOGIN_GATE"
        local v3 = ""
        local v4 = env_text_0(v2, v3)
        return poll_4(v4, v0, v1)
    end
end

function closure10(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = v0 ~= nil and v0.l0
        local v2 = v1 == 0
        if v2 then
            v0.l0 = 1
            local v3 = "[tibia-probe] finish: timeout"
            write_log_line_6(v3)
            local v4 = g_game.isOnline()
            if v4 then
                g_game.safeLogout()
            else
            end
            local v5 = closure3(nil)
            scheduleEvent(v5, 2000)
            return nil
        else
        end
    end
end

local v0 = { __tag = "Mut0", l0 = 0 }
local v1 = "TIBIA_ARENA_CHARACTER"
local v2 = "Knight Sample"
local v3 = env_text_0(v1, v2)
local v4 = (v3 .. "_1511")
disable_client_bot_2(v4)
local v5 = env_text_0(v1, v2)
local v6 = "TIBIA_PROBE_HIDDEN"
local v7 = get_environment_variable_1(v6)
local v8 = v7 == "1"
if v8 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_3()
local v9 = closure0(nil)
scheduleEvent(v9, 200)
scheduleEvent(v9, 1000)
local v10 = closure1({ v5, v0 })
scheduleEvent(v10, 3000)
local v11 = closure10({ v0 })
scheduleEvent(v11, 60000)
return 0
