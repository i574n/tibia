local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Mut0, Mut1, Us0_Some, Us0_None, get_environment_variable_1, env_text_0, disable_client_bot_2, mute_3, closure0, file_exists_5, log_flush_7, write_log_line_6, closure3, typed_c2, format_real_8, closure5, typed_c4, enable_client_bot_9, method11, method12, env_i32_10, player_present_14, parity_summary_15, closure8, go_13, attacking_short_17, closure9, go_16, closure7, ready_c6, closure10, poll_4, closure1, closure11
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

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

function closure5(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        local v4 = tostring(v2)
        local v5 = tostring(v3)
        local v6 = g_clock.millis()
        local v7 = v1 ~= nil and v1.l0
        local v8 = spiral_wrap_signed((v6 - v7), 32)
        local v9 = v0 ~= nil and v0.l0
        local v10 = v9 == 1
        local getv13 = function()
            if v10 then
                local v11 = "health potion"
                local v12 = string.find(v5, v11, 1, true) ~= nil 
                return v12
            else
                return false
            end
        end
        local v13 = getv13()
        if v13 then
            local v14 = ("server text after finish (potion not counted) [" .. v4)
            local v15 = (v14 .. "] @t+")
            local v16 = format_real_8(v8)
            local v17 = (v15 .. v16)
            local v18 = ("[tibia-probe] " .. v17)
            return write_log_line_6(v18)
        else
            local v19 = ("server text [" .. v4)
            local v20 = (v19 .. "]: ")
            local v21 = (v20 .. v5)
            local v22 = (v21 .. " @t+")
            local v23 = format_real_8(v8)
            local v24 = (v22 .. v23)
            local v25 = ("[tibia-probe] " .. v24)
            return write_log_line_6(v25)
        end
    end
end

function typed_c4(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(v2)
        return closure5({ v0, v1, v2 })
    end
end

function enable_client_bot_9(v0, v1)
    local v2 = g_settings.getNode("bot")
    local v3 = (v2) ~= nil
    local getv5 = function()
        if v3 then
            return v2
        else
            local v4 = {}
            return v4
        end
    end
    local v5 = getv5()
    do (v5)[v0] = { enabled = true, config = v1 } end
    g_settings.setNode("bot", v5)
    g_settings.save()
    return nil
end

function method11(v0, v1, v2)
    local v3 = v2 >= v1
    if v3 then
        return v1
    else
        local v4 = string.sub(v0, (v2)+1, (v2)+1)
        local v5 = v4 == " "
        local getv11 = function()
            if v5 then
                return true
            else
                local v6 = v4 == "\t"
                if v6 then
                    return true
                else
                    local v7 = v4 == "\r"
                    if v7 then
                        return true
                    else
                        local v8 = v4 == "\n"
                        return v8
                    end
                end
            end
        end
        local v11 = getv11()
        if v11 then
            local v12 = spiral_wrap_signed((v2 + 1), 32)
            return method11(v0, v1, v12)
        else
            return v2
        end
    end
end

function method12(v0, v1)
    local v2 = v1 <= 0
    if v2 then
        return -1
    else
        local v3 = spiral_wrap_signed((v1 - 1), 32)
        local v4 = string.sub(v0, (v3)+1, (v3)+1)
        local v5 = v4 == " "
        local getv11 = function()
            if v5 then
                return true
            else
                local v6 = v4 == "\t"
                if v6 then
                    return true
                else
                    local v7 = v4 == "\r"
                    if v7 then
                        return true
                    else
                        local v8 = v4 == "\n"
                        return v8
                    end
                end
            end
        end
        local v11 = getv11()
        if v11 then
            return method12(v0, v3)
        else
            return v3
        end
    end
end

function env_i32_10(v0, v1)
    local v2 = get_environment_variable_1(v0)
    local v3 = string.len(v2)
    local v4 = 0
    local v5 = method11(v2, v3, v4)
    local v6 = spiral_wrap_signed((v3 - 1), 32)
    local v7 = string.sub(v2, (v5)+1, (v6)+1)
    local v8 = string.len(v7)
    local v9 = method12(v7, v8)
    local v10 = string.sub(v7, (0)+1, (v9)+1)
    local v11 = (string.match(v10, "^%s*[+-]?%d+%s*$") ~= nil)
    local v12 = (tonumber(v10) or 0)
    local v13 = (math.modf(v12))
    local getv15 = function()
        if v11 then
            local v14 = v12 >= -2147483648.0
            return v14
        else
            return false
        end
    end
    local v15 = getv15()
    local getv17 = function()
        if v15 then
            local v16 = v12 <= 2147483647.0
            return v16
        else
            return false
        end
    end
    local v17 = getv17()
    local getv20 = function()
        if v17 then
            return Us0_Some(v13)
        else
            return Us0_None()
        end
    end
    local v20 = getv20()
    if v20 ~= nil and v20.tag == "Us0_None" then
        return v1
    elseif v20 ~= nil and v20.tag == "Us0_Some" then
        local v21 = v20._1
        return v21
    end
end

function player_present_14()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function parity_summary_15()
    local v0 = ArenaParity ~= nil
    if v0 then
        local v1 = ArenaParity.summary()
        return v1
    else
        local v2 = ""
        return v2
    end
end

function closure8(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_13(v0, v1, v2, v3, v4, v5)
    end
end

function go_13(v0, v1, v2, v3, v4, v5)
    local v6 = v5 ~= nil and v5.l0
    local v7 = v6 == 0
    local getv9 = function()
        if v7 then
            return player_present_14()
        else
            return false
        end
    end
    local v9 = getv9()
    if v9 then
        local v10 = g_game.getLocalPlayer():getHealth()
        local v11 = v3 ~= nil and v3.l0
        local v12 = v10 < v11
        if v12 then
            v3.l0 = v10
        else
        end
        local v13 = g_clock.millis()
        local v14 = spiral_wrap_signed((v13 - v1), 32)
        local v15 = v4 ~= nil and v4.l0
        local v16 = v15 == 0
        local getv20 = function()
            if v16 then
                local v17 = g_game.getLocalPlayer():getExperience()
                local v18 = spiral_wrap_signed((v17 - v0), 32)
                local v19 = v18 >= v2
                return v19
            else
                return false
            end
        end
        local v20 = getv20()
        local getv45 = function()
            if v20 then
                v4.l0 = 1
                local v21 = g_game.getLocalPlayer():getExperience()
                local v22 = spiral_wrap_signed((v21 - v0), 32)
                local v23 = v3 ~= nil and v3.l0
                local v24 = format_real_8(v14)
                local v25 = ("cleared at " .. v24)
                local v26 = (v25 .. " ms")
                local v27 = ("[tibia-probe] " .. v26)
                write_log_line_6(v27)
                local v28 = format_real_8(v22)
                local v29 = ("cleared: experience +" .. v28)
                local v30 = (v29 .. " health ")
                local v31 = format_real_8(v10)
                local v32 = (v30 .. v31)
                local v33 = (v32 .. " lowest health ")
                local v34 = format_real_8(v23)
                local v35 = (v33 .. v34)
                local v36 = ("[tibia-probe] " .. v35)
                write_log_line_6(v36)
                local v37 = v5 ~= nil and v5.l0
                local v38 = v37 == 0
                if v38 then
                    v5.l0 = 1
                    local v39 = parity_summary_15()
                    local v40 = v39 ~= ""
                    if v40 then
                        local v41 = ("[tibia-probe] " .. v39)
                        write_log_line_6(v41)
                    else
                    end
                    local v42 = "[tibia-probe] finish: cleared"
                    write_log_line_6(v42)
                    local v43 = g_game.isOnline()
                    if v43 then
                        g_game.safeLogout()
                    else
                    end
                    local v44 = closure3(nil)
                    scheduleEvent(v44, 2000)
                else
                end
                return true
            else
                return false
            end
        end
        local v45 = getv45()
        local v46 = v45 == false
        if v46 then
            local v47 = closure8({ v0, v1, v2, v3, v4, v5 })
            scheduleEvent(v47, 100)
            return nil
        else
        end
    else
    end
end

function attacking_short_17()
    local v0 = g_game.getAttackingCreature()
    local v1 = (v0) ~= nil
    if v1 then
        local v2 = (v0):getName()
        local v3 = (v2 .. " ")
        local v4 = (v0):getHealthPercent()
        local v5 = format_real_8(v4)
        local v6 = (v3 .. v5)
        local v7 = (v6 .. "%")
        return v7
    else
        local v8 = "nothing"
        return v8
    end
end

function closure9(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_16(v0, v1, v2, v3, v4, v5)
    end
end

function go_16(v0, v1, v2, v3, v4, v5)
    local v6 = v5 ~= nil and v5.l0
    local v7 = v6 == 0
    if v7 then
        local v8 = player_present_14()
        local v9 = v8 == false
        if v9 then
            local v10 = v5 ~= nil and v5.l0
            local v11 = v10 == 0
            if v11 then
                v5.l0 = 1
                local v12 = parity_summary_15()
                local v13 = v12 ~= ""
                if v13 then
                    local v14 = ("[tibia-probe] " .. v12)
                    write_log_line_6(v14)
                else
                end
                local v15 = "[tibia-probe] finish: offline"
                write_log_line_6(v15)
                local v16 = g_game.isOnline()
                if v16 then
                    g_game.safeLogout()
                else
                end
                local v17 = closure3(nil)
                scheduleEvent(v17, 2000)
                return nil
            else
            end
        else
            local v18 = g_game.getLocalPlayer():getHealth()
            local v19 = v3 ~= nil and v3.l0
            local v20 = v18 < v19
            if v20 then
                v3.l0 = v18
            else
            end
            local v21 = g_clock.millis()
            local v22 = spiral_wrap_signed((v21 - v1), 32)
            local v23 = v4 ~= nil and v4.l0
            local v24 = v23 == 0
            local getv28 = function()
                if v24 then
                    local v25 = g_game.getLocalPlayer():getExperience()
                    local v26 = spiral_wrap_signed((v25 - v0), 32)
                    local v27 = v26 >= v2
                    return v27
                else
                    return false
                end
            end
            local v28 = getv28()
            local getv53 = function()
                if v28 then
                    v4.l0 = 1
                    local v29 = g_game.getLocalPlayer():getExperience()
                    local v30 = spiral_wrap_signed((v29 - v0), 32)
                    local v31 = v3 ~= nil and v3.l0
                    local v32 = format_real_8(v22)
                    local v33 = ("cleared at " .. v32)
                    local v34 = (v33 .. " ms")
                    local v35 = ("[tibia-probe] " .. v34)
                    write_log_line_6(v35)
                    local v36 = format_real_8(v30)
                    local v37 = ("cleared: experience +" .. v36)
                    local v38 = (v37 .. " health ")
                    local v39 = format_real_8(v18)
                    local v40 = (v38 .. v39)
                    local v41 = (v40 .. " lowest health ")
                    local v42 = format_real_8(v31)
                    local v43 = (v41 .. v42)
                    local v44 = ("[tibia-probe] " .. v43)
                    write_log_line_6(v44)
                    local v45 = v5 ~= nil and v5.l0
                    local v46 = v45 == 0
                    if v46 then
                        v5.l0 = 1
                        local v47 = parity_summary_15()
                        local v48 = v47 ~= ""
                        if v48 then
                            local v49 = ("[tibia-probe] " .. v47)
                            write_log_line_6(v49)
                        else
                        end
                        local v50 = "[tibia-probe] finish: cleared"
                        write_log_line_6(v50)
                        local v51 = g_game.isOnline()
                        if v51 then
                            g_game.safeLogout()
                        else
                        end
                        local v52 = closure3(nil)
                        scheduleEvent(v52, 2000)
                    else
                    end
                    return true
                else
                    return false
                end
            end
            local v53 = getv53()
            local v54 = v53 == false
            if v54 then
                local v55 = g_game.getLocalPlayer():getExperience()
                local v56 = spiral_wrap_signed((v55 - v0), 32)
                local v57 = v3 ~= nil and v3.l0
                local v58 = attacking_short_17()
                local v59 = g_game.getLocalPlayer():getPosition()
                local v60 = v59.x
                local v61 = v59.y
                local v62 = v59.z
                local v63 = format_real_8(v60)
                local v64 = ("" .. v63)
                local v65 = (v64 .. ",")
                local v66 = format_real_8(v61)
                local v67 = (v65 .. v66)
                local v68 = (v67 .. ",")
                local v69 = format_real_8(v62)
                local v70 = (v68 .. v69)
                local v71 = (math.modf(v22 / 1000))
                local v72 = format_real_8(v71)
                local v73 = ("t=" .. v72)
                local v74 = (v73 .. "s experience +")
                local v75 = format_real_8(v56)
                local v76 = (v74 .. v75)
                local v77 = (v76 .. " health ")
                local v78 = format_real_8(v18)
                local v79 = (v77 .. v78)
                local v80 = (v79 .. " lowest ")
                local v81 = format_real_8(v57)
                local v82 = (v80 .. v81)
                local v83 = (v82 .. " attacking ")
                local v84 = (v83 .. v58)
                local v85 = (v84 .. " at ")
                local v86 = (v85 .. v70)
                local v87 = ("[tibia-probe] " .. v86)
                write_log_line_6(v87)
                local v88 = v22 > 150000
                if v88 then
                    local v89 = format_real_8(v56)
                    local v90 = ("end: experience +" .. v89)
                    local v91 = (v90 .. " lowest health ")
                    local v92 = format_real_8(v57)
                    local v93 = (v91 .. v92)
                    local v94 = ("[tibia-probe] " .. v93)
                    write_log_line_6(v94)
                    local v95 = v5 ~= nil and v5.l0
                    local v96 = v95 == 0
                    if v96 then
                        v5.l0 = 1
                        local v97 = parity_summary_15()
                        local v98 = v97 ~= ""
                        if v98 then
                            local v99 = ("[tibia-probe] " .. v97)
                            write_log_line_6(v99)
                        else
                        end
                        local v100 = "[tibia-probe] finish: run complete"
                        write_log_line_6(v100)
                        local v101 = g_game.isOnline()
                        if v101 then
                            g_game.safeLogout()
                        else
                        end
                        local v102 = closure3(nil)
                        scheduleEvent(v102, 2000)
                        return nil
                    else
                    end
                else
                    local v103 = closure9({ v0, v1, v2, v3, v4, v5 })
                    scheduleEvent(v103, 10000)
                    return nil
                end
            else
            end
        end
    else
    end
end

function closure7(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        g_game.setFightMode(FightBalanced)
        local v2 = "TIBIA_ARENA_CHARACTER"
        local v3 = "Knight Sample"
        local v4 = env_text_0(v2, v3)
        local v5 = (v4 .. "_1511")
        local v6 = "vBot_4.8"
        enable_client_bot_9(v5, v6)
        modules.game_bot.refresh()
        local v7 = g_clock.millis()
        local v8 = v1 ~= nil and v1.l0
        local v9 = spiral_wrap_signed((v7 - v8), 32)
        local v10 = format_real_8(v9)
        local v11 = ("client bot starts @t+" .. v10)
        local v12 = ("[tibia-probe] " .. v11)
        write_log_line_6(v12)
        local v13 = g_game.getLocalPlayer():getExperience()
        local v14 = g_clock.millis()
        local v15 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v16 = 90
        local v17 = env_i32_10(v15, v16)
        local v18 = { __tag = "Mut0", l0 = 999 }
        local v19 = { __tag = "Mut0", l0 = 0 }
        go_13(v13, v14, v17, v18, v19, v0)
        return go_16(v13, v14, v17, v18, v19, v0)
    end
end

function ready_c6(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getName()
        local v3 = g_game.getLocalPlayer():getHealth()
        local v4 = ("in game as " .. v2)
        local v5 = (v4 .. " health ")
        local v6 = format_real_8(v3)
        local v7 = (v5 .. v6)
        local v8 = (v7 .. " ")
        local v9 = (v8 .. "(vBot_4.8 TargetBot arena config)")
        local v10 = ("[tibia-probe] " .. v9)
        write_log_line_6(v10)
        local v11 = g_clock.millis()
        v0.l0 = v11
        local v12 = closure7({ v1, v0 })
        scheduleEvent(v12, 2500)
        return nil
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_4(v0, v1, v2, v3, v4, v5)
    end
end

function poll_4(v0, v1, v2, v3, v4, v5)
    local v6 = v0 == ""
    local getv8 = function()
        if v6 then
            return true
        else
            return file_exists_5(v0)
        end
    end
    local v8 = getv8()
    if v8 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v9 = typed_c2(nil)
        local v10 = function(message) (v9)(message) end
        local v11 = typed_c4({ v2, v3 })
        local v12 = function(mode, text) (v11)(mode)(text) end
        local v13 = ready_c6({ v4, v5 })
        connect(g_game, { onGameStart = v13, onLoginError = v10, onTextMessage = v12 })
        local v14 = "@god"
        local v15 = "@god\ngod"
        g_game.loginWorld(v14, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v15)
        return nil
    else
        local v16 = closure10({ v0, v1, v2, v3, v4, v5 })
        scheduleEvent(v16, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        local v5 = "TIBIA_LOGIN_GATE"
        local v6 = ""
        local v7 = env_text_0(v5, v6)
        return poll_4(v7, v0, v1, v2, v3, v4)
    end
end

function closure11(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = v0 ~= nil and v0.l0
        local v2 = v1 == 0
        if v2 then
            v0.l0 = 1
            local v3 = parity_summary_15()
            local v4 = v3 ~= ""
            if v4 then
                local v5 = ("[tibia-probe] " .. v3)
                write_log_line_6(v5)
            else
            end
            local v6 = "[tibia-probe] finish: timeout"
            write_log_line_6(v6)
            local v7 = g_game.isOnline()
            if v7 then
                g_game.safeLogout()
            else
            end
            local v8 = closure3(nil)
            scheduleEvent(v8, 2000)
            return nil
        else
        end
    end
end

local v0 = { __tag = "Mut0", l0 = 0 }
local v1 = { __tag = "Mut0", l0 = 0 }
local v2 = "TIBIA_ARENA_CHARACTER"
local v3 = "Knight Sample"
local v4 = env_text_0(v2, v3)
local v5 = (v4 .. "_1511")
disable_client_bot_2(v5)
local v6 = env_text_0(v2, v3)
local v7 = "TIBIA_PROBE_HIDDEN"
local v8 = get_environment_variable_1(v7)
local v9 = v8 == "1"
if v9 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_3()
local v10 = closure0(nil)
scheduleEvent(v10, 200)
scheduleEvent(v10, 1000)
local v11 = closure1({ v6, v0, v1, v1, v0 })
scheduleEvent(v11, 3000)
local v12 = closure11({ v0 })
scheduleEvent(v12, 200000)
return 0
