local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Mut0, Mut1, get_environment_variable_1, env_text_0, disable_client_bot_2, mute_3, closure0, file_exists_5, log_flush_7, write_log_line_6, closure3, typed_c2, closure5, typed_c4, format_real_8, player_present_10, live_monster_12, scan_11, closure8, go_9, closure7, ready_c6, closure9, poll_4, closure1, closure10
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

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

function closure5(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = tostring(v0)
        local v3 = tostring(v1)
        local v4 = "server text ["
        local v5 = v4 .. v2 
        local v6 = "]: "
        local v7 = v5 .. v6 
        local v8 = v7 .. v3 
        local v9 = "[tibia-probe] "
        local v10 = v9 .. v8 
        return write_log_line_6(v10)
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
    local v5 = v4 .. v3 
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

function scan_11(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v5 > v4
    local getv37 = function()
        if v9 then
            return { [1]=v6, [2]=v7, [3]=v8 }
        else
            local v10 = spiral_wrap_signed((v5 + 1), 32)
            local v11 = (v3)[v5]
            local v12 = live_monster_12(v11)
            local getv31 = function()
                if v12 then
                    local v13 = (v11):getPosition()
                    local v14 = v13.x
                    local v15 = v13.y
                    local v16 = v13.z
                    local v17 = v14 > v0
                    local getv20 = function()
                        if v17 then
                            local v18 = spiral_wrap_signed((v14 - v0), 32)
                            return v18
                        else
                            local v19 = spiral_wrap_signed((v0 - v14), 32)
                            return v19
                        end
                    end
                    local v20 = getv20()
                    local v21 = v15 > v1
                    local getv24 = function()
                        if v21 then
                            local v22 = spiral_wrap_signed((v15 - v1), 32)
                            return v22
                        else
                            local v23 = spiral_wrap_signed((v1 - v15), 32)
                            return v23
                        end
                    end
                    local v24 = getv24()
                    local v25 = v20 > v24
                    local getv26 = function()
                        if v25 then
                            return v20
                        else
                            return v24
                        end
                    end
                    local v26 = getv26()
                    local v27 = v26 < v8
                    local getv28 = function()
                        if v27 then
                            return { [1]=true, [2]=v5, [3]=v26 }
                        else
                            return { [1]=v6, [2]=v7, [3]=v8 }
                        end
                    end
                    local v28, v29, v30 = (table.unpack or unpack)(getv28())
                    return { [1]=v28, [2]=v29, [3]=v30 }
                else
                    return { [1]=v6, [2]=v7, [3]=v8 }
                end
            end
            local v31, v32, v33 = (table.unpack or unpack)(getv31())
            local v34, v35, v36 = (table.unpack or unpack)(scan_11(v0, v1, v2, v3, v4, v10, v31, v32, v33))
            return { [1]=v34, [2]=v35, [3]=v36 }
        end
    end
    local v37, v38, v39 = (table.unpack or unpack)(getv37())
    return { [1]=v37, [2]=v38, [3]=v39 }
end

function closure8(capt)
    local v0, v1, v2, v3, v4, v5, v6 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_9(v0, v1, v2, v3, v4, v5, v6)
    end
end

function go_9(v0, v1, v2, v3, v4, v5, v6)
    local v7 = player_present_10()
    local v8 = v7 == false
    if v8 then
        local v9 = v0 ~= nil and v0.l0
        local v10 = v9 == 0
        if v10 then
            v0.l0 = 1
            local v11 = "finish: "
            local v12 = "offline"
            local v13 = v11 .. v12 
            local v14 = "[tibia-probe] "
            local v15 = v14 .. v13 
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
        local v18 = g_clock.millis()
        local v19 = spiral_wrap_signed((v18 - v1), 32)
        local v20 = g_game.getLocalPlayer():getPosition()
        local v21 = v20.x
        local v22 = v20.y
        local v23 = v20.z
        local v24 = g_map.getSpectators({ x = v21, y = v22, z = v23 }, false)
        local v25 = #(v24)
        local v26 = 1
        local v27 = false
        local v28 = 0
        local v29 = 999
        local v30, v31, v32 = (table.unpack or unpack)(scan_11(v21, v22, v23, v24, v25, v26, v27, v28, v29))
        local getv75 = function()
            if v30 then
                local v33 = (v24)[v31]
                local v34 = (v33):getPosition()
                local v35 = v34.x
                local v36 = v34.y
                local v37 = v34.z
                local v38 = v2 == false
                local getv40 = function()
                    if v38 then
                        return true
                    else
                        local v39 = v35 ~= v3
                        return v39
                    end
                end
                local v40 = getv40()
                local getv42 = function()
                    if v40 then
                        return true
                    else
                        local v41 = v36 ~= v4
                        return v41
                    end
                end
                local v42 = getv42()
                local v43 = (v42) and (v2)
                local getv45 = function()
                    if v43 then
                        local v44 = spiral_wrap_signed((v6 + 1), 32)
                        return v44
                    else
                        return v6
                    end
                end
                local v45 = getv45()
                if v42 then
                    local v46 = format_real_8(v35)
                    local v47 = ""
                    local v48 = v47 .. v46 
                    local v49 = ","
                    local v50 = v48 .. v49 
                    local v51 = format_real_8(v36)
                    local v52 = v50 .. v51 
                    local v53 = v52 .. v49 
                    local v54 = format_real_8(v37)
                    local v55 = v53 .. v54 
                    local v56 = format_real_8(v19)
                    local v57 = "path t="
                    local v58 = v57 .. v56 
                    local v59 = " ms monster at "
                    local v60 = v58 .. v59 
                    local v61 = v60 .. v55 
                    local v62 = " distance "
                    local v63 = v61 .. v62 
                    local v64 = format_real_8(v32)
                    local v65 = v63 .. v64 
                    local v66 = " step "
                    local v67 = v65 .. v66 
                    local v68 = format_real_8(v45)
                    local v69 = v67 .. v68 
                    local v70 = "[tibia-probe] "
                    local v71 = v70 .. v69 
                    write_log_line_6(v71)
                else
                end
                local getv72 = function()
                    if v42 then
                        return { [1]=v35, [2]=v36, [3]=v37 }
                    else
                        return { [1]=v3, [2]=v4, [3]=v5 }
                    end
                end
                local v72, v73, v74 = (table.unpack or unpack)(getv72())
                return { [1]=true, [2]=v72, [3]=v73, [4]=v74, [5]=v45 }
            else
                return { [1]=v2, [2]=v3, [3]=v4, [4]=v5, [5]=v6 }
            end
        end
        local v75, v76, v77, v78, v79 = (table.unpack or unpack)(getv75())
        local getv81 = function()
            if v30 then
                local v80 = v32 <= 1
                return v80
            else
                return false
            end
        end
        local v81 = getv81()
        local getv133 = function()
            if v81 then
                local v82 = format_real_8(v21)
                local v83 = ""
                local v84 = v83 .. v82 
                local v85 = ","
                local v86 = v84 .. v85 
                local v87 = format_real_8(v22)
                local v88 = v86 .. v87 
                local v89 = v88 .. v85 
                local v90 = format_real_8(v23)
                local v91 = v89 .. v90 
                local v92 = format_real_8(v19)
                local v93 = "arrived at "
                local v94 = v93 .. v92 
                local v95 = " ms after "
                local v96 = v94 .. v95 
                local v97 = format_real_8(v79)
                local v98 = v96 .. v97 
                local v99 = " steps, knight at "
                local v100 = v98 .. v99 
                local v101 = v100 .. v91 
                local v102 = "[tibia-probe] "
                local v103 = v102 .. v101 
                write_log_line_6(v103)
                local v104 = v0 ~= nil and v0.l0
                local v105 = v104 == 0
                if v105 then
                    v0.l0 = 1
                    local v106 = "finish: "
                    local v107 = "arrived"
                    local v108 = v106 .. v107 
                    local v109 = v102 .. v108 
                    write_log_line_6(v109)
                    local v110 = g_game.isOnline()
                    if v110 then
                        g_game.safeLogout()
                    else
                    end
                    local v111 = closure3(nil)
                    scheduleEvent(v111, 2000)
                else
                end
                return true
            else
                local v112 = v19 > 30000
                if v112 then
                    local v113 = format_real_8(v19)
                    local v114 = "not arrived after "
                    local v115 = v114 .. v113 
                    local v116 = " ms, "
                    local v117 = v115 .. v116 
                    local v118 = format_real_8(v79)
                    local v119 = v117 .. v118 
                    local v120 = " steps"
                    local v121 = v119 .. v120 
                    local v122 = "[tibia-probe] "
                    local v123 = v122 .. v121 
                    write_log_line_6(v123)
                    local v124 = v0 ~= nil and v0.l0
                    local v125 = v124 == 0
                    if v125 then
                        v0.l0 = 1
                        local v126 = "finish: "
                        local v127 = "not arrived"
                        local v128 = v126 .. v127 
                        local v129 = v122 .. v128 
                        write_log_line_6(v129)
                        local v130 = g_game.isOnline()
                        if v130 then
                            g_game.safeLogout()
                        else
                        end
                        local v131 = closure3(nil)
                        scheduleEvent(v131, 2000)
                    else
                    end
                    return true
                else
                    return false
                end
            end
        end
        local v133 = getv133()
        local v134 = v133 == false
        if v134 then
            local v135 = closure8({ v0, v1, v75, v76, v77, v78, v79 })
            scheduleEvent(v135, 50)
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
        local v7 = ""
        local v8 = v7 .. v6 
        local v9 = ","
        local v10 = v8 .. v9 
        local v11 = format_real_8(v4)
        local v12 = v10 .. v11 
        local v13 = v12 .. v9 
        local v14 = format_real_8(v5)
        local v15 = v13 .. v14 
        local v16 = "in game as "
        local v17 = v16 .. v1 
        local v18 = " at "
        local v19 = v17 .. v18 
        local v20 = v19 .. v15 
        local v21 = " (path check, standing, no attack)"
        local v22 = v20 .. v21 
        local v23 = "[tibia-probe] "
        local v24 = v23 .. v22 
        write_log_line_6(v24)
        local v25 = g_clock.millis()
        local v26 = false
        local v27 = 0
        local v28 = 0
        local v29 = 0
        local v30 = 0
        return go_9(v0, v25, v26, v27, v28, v29, v30)
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
            local v3 = "finish: "
            local v4 = "timeout"
            local v5 = v3 .. v4 
            local v6 = "[tibia-probe] "
            local v7 = v6 .. v5 
            write_log_line_6(v7)
            local v8 = g_game.isOnline()
            if v8 then
                g_game.safeLogout()
            else
            end
            local v9 = closure3(nil)
            scheduleEvent(v9, 2000)
            return nil
        else
        end
    end
end

local v0 = { __tag = "Mut0", l0 = 0 }
local v1 = "TIBIA_ARENA_CHARACTER"
local v2 = "Knight Sample"
local v3 = env_text_0(v1, v2)
local v4 = "_1511"
local v5 = v3 .. v4 
disable_client_bot_2(v5)
local v6 = env_text_0(v1, v2)
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
local v11 = closure1({ v6, v0 })
scheduleEvent(v11, 3000)
local v12 = closure10({ v0 })
scheduleEvent(v12, 60000)
return 0
