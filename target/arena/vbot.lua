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
    local v1 = "\n"
    local v2 = v0 .. v1 
    g_resources.writeFileContents("/tibia-probe.log", v2)
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
        local v2 = "game login error: "
        local v3 = v2 .. v1 
        local v4 = "[tibia-probe] "
        local v5 = v4 .. v3 
        write_log_line_6(v5)
        local v6 = "finish: "
        local v7 = "game login error"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        write_log_line_6(v9)
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

function format_real_8(v0)
    local v1 = ""
    local v2 = { __tag = "Mut1", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
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
            local v14 = "server text after finish (potion not counted) ["
            local v15 = v14 .. v4 
            local v16 = "] @t+"
            local v17 = v15 .. v16 
            local v18 = format_real_8(v8)
            local v19 = v17 .. v18 
            local v20 = "[tibia-probe] "
            local v21 = v20 .. v19 
            return write_log_line_6(v21)
        else
            local v22 = "server text ["
            local v23 = v22 .. v4 
            local v24 = "]: "
            local v25 = v23 .. v24 
            local v26 = v25 .. v5 
            local v27 = " @t+"
            local v28 = v26 .. v27 
            local v29 = format_real_8(v8)
            local v30 = v28 .. v29 
            local v31 = "[tibia-probe] "
            local v32 = v31 .. v30 
            return write_log_line_6(v32)
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
        local getv54 = function()
            if v20 then
                v4.l0 = 1
                local v21 = g_game.getLocalPlayer():getExperience()
                local v22 = spiral_wrap_signed((v21 - v0), 32)
                local v23 = v3 ~= nil and v3.l0
                local v24 = format_real_8(v14)
                local v25 = "cleared at "
                local v26 = v25 .. v24 
                local v27 = " ms"
                local v28 = v26 .. v27 
                local v29 = "[tibia-probe] "
                local v30 = v29 .. v28 
                write_log_line_6(v30)
                local v31 = format_real_8(v22)
                local v32 = "cleared: experience +"
                local v33 = v32 .. v31 
                local v34 = " health "
                local v35 = v33 .. v34 
                local v36 = format_real_8(v10)
                local v37 = v35 .. v36 
                local v38 = " lowest health "
                local v39 = v37 .. v38 
                local v40 = format_real_8(v23)
                local v41 = v39 .. v40 
                local v42 = v29 .. v41 
                write_log_line_6(v42)
                local v43 = v5 ~= nil and v5.l0
                local v44 = v43 == 0
                if v44 then
                    v5.l0 = 1
                    local v45 = parity_summary_15()
                    local v46 = v45 ~= ""
                    if v46 then
                        local v47 = v29 .. v45 
                        write_log_line_6(v47)
                    else
                    end
                    local v48 = "finish: "
                    local v49 = "cleared"
                    local v50 = v48 .. v49 
                    local v51 = v29 .. v50 
                    write_log_line_6(v51)
                    local v52 = g_game.isOnline()
                    if v52 then
                        g_game.safeLogout()
                    else
                    end
                    local v53 = closure3(nil)
                    scheduleEvent(v53, 2000)
                else
                end
                return true
            else
                return false
            end
        end
        local v54 = getv54()
        local v55 = v54 == false
        if v55 then
            local v56 = closure8({ v0, v1, v2, v3, v4, v5 })
            scheduleEvent(v56, 100)
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
        local v3 = " "
        local v4 = v2 .. v3 
        local v5 = (v0):getHealthPercent()
        local v6 = format_real_8(v5)
        local v7 = v4 .. v6 
        local v8 = "%"
        local v9 = v7 .. v8 
        return v9
    else
        local v10 = "nothing"
        return v10
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
                    local v14 = "[tibia-probe] "
                    local v15 = v14 .. v12 
                    write_log_line_6(v15)
                else
                end
                local v16 = "finish: "
                local v17 = "offline"
                local v18 = v16 .. v17 
                local v19 = "[tibia-probe] "
                local v20 = v19 .. v18 
                write_log_line_6(v20)
                local v21 = g_game.isOnline()
                if v21 then
                    g_game.safeLogout()
                else
                end
                local v22 = closure3(nil)
                scheduleEvent(v22, 2000)
                return nil
            else
            end
        else
            local v23 = g_game.getLocalPlayer():getHealth()
            local v24 = v3 ~= nil and v3.l0
            local v25 = v23 < v24
            if v25 then
                v3.l0 = v23
            else
            end
            local v26 = g_clock.millis()
            local v27 = spiral_wrap_signed((v26 - v1), 32)
            local v28 = v4 ~= nil and v4.l0
            local v29 = v28 == 0
            local getv33 = function()
                if v29 then
                    local v30 = g_game.getLocalPlayer():getExperience()
                    local v31 = spiral_wrap_signed((v30 - v0), 32)
                    local v32 = v31 >= v2
                    return v32
                else
                    return false
                end
            end
            local v33 = getv33()
            local getv67 = function()
                if v33 then
                    v4.l0 = 1
                    local v34 = g_game.getLocalPlayer():getExperience()
                    local v35 = spiral_wrap_signed((v34 - v0), 32)
                    local v36 = v3 ~= nil and v3.l0
                    local v37 = format_real_8(v27)
                    local v38 = "cleared at "
                    local v39 = v38 .. v37 
                    local v40 = " ms"
                    local v41 = v39 .. v40 
                    local v42 = "[tibia-probe] "
                    local v43 = v42 .. v41 
                    write_log_line_6(v43)
                    local v44 = format_real_8(v35)
                    local v45 = "cleared: experience +"
                    local v46 = v45 .. v44 
                    local v47 = " health "
                    local v48 = v46 .. v47 
                    local v49 = format_real_8(v23)
                    local v50 = v48 .. v49 
                    local v51 = " lowest health "
                    local v52 = v50 .. v51 
                    local v53 = format_real_8(v36)
                    local v54 = v52 .. v53 
                    local v55 = v42 .. v54 
                    write_log_line_6(v55)
                    local v56 = v5 ~= nil and v5.l0
                    local v57 = v56 == 0
                    if v57 then
                        v5.l0 = 1
                        local v58 = parity_summary_15()
                        local v59 = v58 ~= ""
                        if v59 then
                            local v60 = v42 .. v58 
                            write_log_line_6(v60)
                        else
                        end
                        local v61 = "finish: "
                        local v62 = "cleared"
                        local v63 = v61 .. v62 
                        local v64 = v42 .. v63 
                        write_log_line_6(v64)
                        local v65 = g_game.isOnline()
                        if v65 then
                            g_game.safeLogout()
                        else
                        end
                        local v66 = closure3(nil)
                        scheduleEvent(v66, 2000)
                    else
                    end
                    return true
                else
                    return false
                end
            end
            local v67 = getv67()
            local v68 = v67 == false
            if v68 then
                local v69 = g_game.getLocalPlayer():getExperience()
                local v70 = spiral_wrap_signed((v69 - v0), 32)
                local v71 = v3 ~= nil and v3.l0
                local v72 = attacking_short_17()
                local v73 = g_game.getLocalPlayer():getPosition()
                local v74 = v73.x
                local v75 = v73.y
                local v76 = v73.z
                local v77 = format_real_8(v74)
                local v78 = ""
                local v79 = v78 .. v77 
                local v80 = ","
                local v81 = v79 .. v80 
                local v82 = format_real_8(v75)
                local v83 = v81 .. v82 
                local v84 = v83 .. v80 
                local v85 = format_real_8(v76)
                local v86 = v84 .. v85 
                local v87 = (math.modf(v27 / 1000))
                local v88 = format_real_8(v87)
                local v89 = "t="
                local v90 = v89 .. v88 
                local v91 = "s experience +"
                local v92 = v90 .. v91 
                local v93 = format_real_8(v70)
                local v94 = v92 .. v93 
                local v95 = " health "
                local v96 = v94 .. v95 
                local v97 = format_real_8(v23)
                local v98 = v96 .. v97 
                local v99 = " lowest "
                local v100 = v98 .. v99 
                local v101 = format_real_8(v71)
                local v102 = v100 .. v101 
                local v103 = " attacking "
                local v104 = v102 .. v103 
                local v105 = v104 .. v72 
                local v106 = " at "
                local v107 = v105 .. v106 
                local v108 = v107 .. v86 
                local v109 = "[tibia-probe] "
                local v110 = v109 .. v108 
                write_log_line_6(v110)
                local v111 = v27 > 150000
                if v111 then
                    local v112 = format_real_8(v70)
                    local v113 = "end: experience +"
                    local v114 = v113 .. v112 
                    local v115 = " lowest health "
                    local v116 = v114 .. v115 
                    local v117 = format_real_8(v71)
                    local v118 = v116 .. v117 
                    local v119 = v109 .. v118 
                    write_log_line_6(v119)
                    local v120 = v5 ~= nil and v5.l0
                    local v121 = v120 == 0
                    if v121 then
                        v5.l0 = 1
                        local v122 = parity_summary_15()
                        local v123 = v122 ~= ""
                        if v123 then
                            local v124 = v109 .. v122 
                            write_log_line_6(v124)
                        else
                        end
                        local v125 = "finish: "
                        local v126 = "run complete"
                        local v127 = v125 .. v126 
                        local v128 = v109 .. v127 
                        write_log_line_6(v128)
                        local v129 = g_game.isOnline()
                        if v129 then
                            g_game.safeLogout()
                        else
                        end
                        local v130 = closure3(nil)
                        scheduleEvent(v130, 2000)
                        return nil
                    else
                    end
                else
                    local v131 = closure9({ v0, v1, v2, v3, v4, v5 })
                    scheduleEvent(v131, 10000)
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
        local v5 = "_1511"
        local v6 = v4 .. v5 
        local v7 = "vBot_4.8"
        enable_client_bot_9(v6, v7)
        modules.game_bot.refresh()
        local v8 = g_clock.millis()
        local v9 = v1 ~= nil and v1.l0
        local v10 = spiral_wrap_signed((v8 - v9), 32)
        local v11 = format_real_8(v10)
        local v12 = "client bot starts @t+"
        local v13 = v12 .. v11 
        local v14 = "[tibia-probe] "
        local v15 = v14 .. v13 
        write_log_line_6(v15)
        local v16 = g_game.getLocalPlayer():getExperience()
        local v17 = g_clock.millis()
        local v18 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v19 = 90
        local v20 = env_i32_10(v18, v19)
        local v21 = { __tag = "Mut0", l0 = 999 }
        local v22 = { __tag = "Mut0", l0 = 0 }
        go_13(v16, v17, v20, v21, v22, v0)
        return go_16(v16, v17, v20, v21, v22, v0)
    end
end

function ready_c6(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getName()
        local v3 = g_game.getLocalPlayer():getHealth()
        local v4 = "in game as "
        local v5 = v4 .. v2 
        local v6 = " health "
        local v7 = v5 .. v6 
        local v8 = format_real_8(v3)
        local v9 = v7 .. v8 
        local v10 = " "
        local v11 = v9 .. v10 
        local v12 = "(vBot_4.8 TargetBot arena config)"
        local v13 = v11 .. v12 
        local v14 = "[tibia-probe] "
        local v15 = v14 .. v13 
        write_log_line_6(v15)
        local v16 = g_clock.millis()
        v0.l0 = v16
        local v17 = closure7({ v1, v0 })
        scheduleEvent(v17, 2500)
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
                local v5 = "[tibia-probe] "
                local v6 = v5 .. v3 
                write_log_line_6(v6)
            else
            end
            local v7 = "finish: "
            local v8 = "timeout"
            local v9 = v7 .. v8 
            local v10 = "[tibia-probe] "
            local v11 = v10 .. v9 
            write_log_line_6(v11)
            local v12 = g_game.isOnline()
            if v12 then
                g_game.safeLogout()
            else
            end
            local v13 = closure3(nil)
            scheduleEvent(v13, 2000)
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
local v5 = "_1511"
local v6 = v4 .. v5 
disable_client_bot_2(v6)
local v7 = env_text_0(v2, v3)
local v8 = "TIBIA_PROBE_HIDDEN"
local v9 = get_environment_variable_1(v8)
local v10 = v9 == "1"
if v10 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_3()
local v11 = closure0(nil)
scheduleEvent(v11, 200)
scheduleEvent(v11, 1000)
local v12 = closure1({ v7, v0, v1, v1, v0 })
scheduleEvent(v12, 3000)
local v13 = closure11({ v0 })
scheduleEvent(v13, 200000)
return 0
