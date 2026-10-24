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
local Mut0, closure0, format_real_1, closure4, closure5, go_2, closure6, go_3, closure3, ready_c2, closure7, closure9, on_text_c8, closure10, poll_0, closure1, closure11
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

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

function closure4(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function closure5(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_2(v0, v1, v2, v3, v4, v5)
    end
end

function go_2(v0, v1, v2, v3, v4, v5)
    local v6 = (v5).value
    local v7 = v6 == 0
    local getv9 = function()
        if v7 then
            local v8 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
            return v8
        else
            return false
        end
    end
    local v9 = getv9()
    if v9 then
        local v10 = g_game.getLocalPlayer():getHealth()
        local v11 = (v3).value
        local v12 = v10 < v11
        if v12 then
            do (v3).value = (v10) end
        else
        end
        local v13 = g_clock.millis()
        local v14 = spiral_wrap_signed((v13 - v1), 32)
        local v15 = (v4).value
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
                do (v4).value = (1) end
                local v21 = g_game.getLocalPlayer():getExperience()
                local v22 = spiral_wrap_signed((v21 - v0), 32)
                local v23 = (v3).value
                local v24 = format_real_1(v14)
                local v25 = "cleared at "
                local v26 = v25 .. v24 
                local v27 = " ms"
                local v28 = v26 .. v27 
                local v29 = "[tibia-probe] "
                local v30 = v29 .. v28 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v30)
                g_logger.info(v30)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v31 = format_real_1(v22)
                local v32 = "cleared: experience +"
                local v33 = v32 .. v31 
                local v34 = " health "
                local v35 = v33 .. v34 
                local v36 = format_real_1(v10)
                local v37 = v35 .. v36 
                local v38 = " lowest health "
                local v39 = v37 .. v38 
                local v40 = format_real_1(v23)
                local v41 = v39 .. v40 
                local v42 = v29 .. v41 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v42)
                g_logger.info(v42)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v43 = (v5).value
                local v44 = v43 == 0
                if v44 then
                    do (v5).value = (1) end
                    local v45 = ArenaParity and ArenaParity.summary() or ""
                    local v46 = v45 ~= ""
                    if v46 then
                        local v47 = v29 .. v45 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v47)
                        g_logger.info(v47)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    else
                    end
                    local v48 = "finish: "
                    local v49 = "cleared"
                    local v50 = v48 .. v49 
                    local v51 = v29 .. v50 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v51)
                    g_logger.info(v51)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v52 = g_game.isOnline()
                    if v52 then
                        g_game.safeLogout()
                    else
                    end
                    local v53 = closure4(nil)
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
            local v56 = closure5({ v0, v1, v2, v3, v4, v5 })
            scheduleEvent(v56, 100)
            return nil
        else
        end
    else
    end
end

function closure6(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_3(v0, v1, v2, v3, v4, v5)
    end
end

function go_3(v0, v1, v2, v3, v4, v5)
    local v6 = (v5).value
    local v7 = v6 == 0
    if v7 then
        local v8 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
        local v9 = v8 == false
        if v9 then
            local v10 = (v5).value
            local v11 = v10 == 0
            if v11 then
                do (v5).value = (1) end
                local v12 = ArenaParity and ArenaParity.summary() or ""
                local v13 = v12 ~= ""
                if v13 then
                    local v14 = "[tibia-probe] "
                    local v15 = v14 .. v12 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v15)
                    g_logger.info(v15)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v16 = "finish: "
                local v17 = "offline"
                local v18 = v16 .. v17 
                local v19 = "[tibia-probe] "
                local v20 = v19 .. v18 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v20)
                g_logger.info(v20)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v21 = g_game.isOnline()
                if v21 then
                    g_game.safeLogout()
                else
                end
                local v22 = closure4(nil)
                scheduleEvent(v22, 2000)
                return nil
            else
            end
        else
            local v23 = g_game.getLocalPlayer():getHealth()
            local v24 = (v3).value
            local v25 = v23 < v24
            if v25 then
                do (v3).value = (v23) end
            else
            end
            local v26 = g_clock.millis()
            local v27 = spiral_wrap_signed((v26 - v1), 32)
            local v28 = (v4).value
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
                    do (v4).value = (1) end
                    local v34 = g_game.getLocalPlayer():getExperience()
                    local v35 = spiral_wrap_signed((v34 - v0), 32)
                    local v36 = (v3).value
                    local v37 = format_real_1(v27)
                    local v38 = "cleared at "
                    local v39 = v38 .. v37 
                    local v40 = " ms"
                    local v41 = v39 .. v40 
                    local v42 = "[tibia-probe] "
                    local v43 = v42 .. v41 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v43)
                    g_logger.info(v43)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v44 = format_real_1(v35)
                    local v45 = "cleared: experience +"
                    local v46 = v45 .. v44 
                    local v47 = " health "
                    local v48 = v46 .. v47 
                    local v49 = format_real_1(v23)
                    local v50 = v48 .. v49 
                    local v51 = " lowest health "
                    local v52 = v50 .. v51 
                    local v53 = format_real_1(v36)
                    local v54 = v52 .. v53 
                    local v55 = v42 .. v54 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v55)
                    g_logger.info(v55)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v56 = (v5).value
                    local v57 = v56 == 0
                    if v57 then
                        do (v5).value = (1) end
                        local v58 = ArenaParity and ArenaParity.summary() or ""
                        local v59 = v58 ~= ""
                        if v59 then
                            local v60 = v42 .. v58 
                            TibiaProbeLog = TibiaProbeLog or {}
                            table.insert(TibiaProbeLog, v60)
                            g_logger.info(v60)
                            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        else
                        end
                        local v61 = "finish: "
                        local v62 = "cleared"
                        local v63 = v61 .. v62 
                        local v64 = v42 .. v63 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v64)
                        g_logger.info(v64)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v65 = g_game.isOnline()
                        if v65 then
                            g_game.safeLogout()
                        else
                        end
                        local v66 = closure4(nil)
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
                local v69 = (math.modf(v27 / 1000))
                local v70 = g_game.getLocalPlayer():getExperience()
                local v71 = spiral_wrap_signed((v70 - v0), 32)
                local v72 = (v3).value
                local v73 = (function() local a = g_game.getAttackingCreature(); if not a then return "nothing" end; return a:getName() .. " " .. a:getHealthPercent() .. "%" end)()
                local v74 = g_game.getLocalPlayer():getPosition()
                local v75 = v74.x
                local v76 = v74.y
                local v77 = v74.z
                local v78 = format_real_1(v75)
                local v79 = ""
                local v80 = v79 .. v78 
                local v81 = ","
                local v82 = v80 .. v81 
                local v83 = format_real_1(v76)
                local v84 = v82 .. v83 
                local v85 = v84 .. v81 
                local v86 = format_real_1(v77)
                local v87 = v85 .. v86 
                local v88 = format_real_1(v69)
                local v89 = "t="
                local v90 = v89 .. v88 
                local v91 = "s experience +"
                local v92 = v90 .. v91 
                local v93 = format_real_1(v71)
                local v94 = v92 .. v93 
                local v95 = " health "
                local v96 = v94 .. v95 
                local v97 = format_real_1(v23)
                local v98 = v96 .. v97 
                local v99 = " lowest "
                local v100 = v98 .. v99 
                local v101 = format_real_1(v72)
                local v102 = v100 .. v101 
                local v103 = " attacking "
                local v104 = v102 .. v103 
                local v105 = v104 .. v73 
                local v106 = " at "
                local v107 = v105 .. v106 
                local v108 = v107 .. v87 
                local v109 = "[tibia-probe] "
                local v110 = v109 .. v108 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v110)
                g_logger.info(v110)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v111 = v27 > 150000
                if v111 then
                    local v112 = format_real_1(v71)
                    local v113 = "end: experience +"
                    local v114 = v113 .. v112 
                    local v115 = " lowest health "
                    local v116 = v114 .. v115 
                    local v117 = format_real_1(v72)
                    local v118 = v116 .. v117 
                    local v119 = v109 .. v118 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v119)
                    g_logger.info(v119)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v120 = (v5).value
                    local v121 = v120 == 0
                    if v121 then
                        do (v5).value = (1) end
                        local v122 = ArenaParity and ArenaParity.summary() or ""
                        local v123 = v122 ~= ""
                        if v123 then
                            local v124 = v109 .. v122 
                            TibiaProbeLog = TibiaProbeLog or {}
                            table.insert(TibiaProbeLog, v124)
                            g_logger.info(v124)
                            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        else
                        end
                        local v125 = "finish: "
                        local v126 = "run complete"
                        local v127 = v125 .. v126 
                        local v128 = v109 .. v127 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v128)
                        g_logger.info(v128)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v129 = g_game.isOnline()
                        if v129 then
                            g_game.safeLogout()
                        else
                        end
                        local v130 = closure4(nil)
                        scheduleEvent(v130, 2000)
                        return nil
                    else
                    end
                else
                    local v131 = closure6({ v0, v1, v2, v3, v4, v5 })
                    scheduleEvent(v131, 10000)
                    return nil
                end
            else
            end
        end
    else
    end
end

function closure3(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        g_game.setFightMode(FightBalanced)
        local v5 = "TIBIA_ARENA_CHARACTER"
        local v6 = "Knight Sample"
        local v7 = os.getenv(v5) or (v6)
        local v8 = "_1511"
        local v9 = v7 .. v8 
        local v10 = "vBot_4.8"
        do (function(key, config) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = true, config = config }; g_settings.setNode("bot", s); g_settings.save() end)(v9, v10) end
        modules.game_bot.refresh()
        local v11 = g_clock.millis()
        local v12 = (v4).value
        local v13 = spiral_wrap_signed((v11 - v12), 32)
        local v14 = format_real_1(v13)
        local v15 = "client bot starts @t+"
        local v16 = v15 .. v14 
        local v17 = "[tibia-probe] "
        local v18 = v17 .. v16 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v18)
        g_logger.info(v18)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v19 = g_game.getLocalPlayer():getExperience()
        local v20 = g_clock.millis()
        go_2(v19, v20, v3, v1, v2, v0)
        return go_3(v19, v20, v3, v1, v2, v0)
    end
end

function ready_c2(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        local v5 = g_game.getLocalPlayer():getName()
        local v6 = g_game.getLocalPlayer():getHealth()
        local v7 = "in game as "
        local v8 = v7 .. v5 
        local v9 = " health "
        local v10 = v8 .. v9 
        local v11 = format_real_1(v6)
        local v12 = v10 .. v11 
        local v13 = " "
        local v14 = v12 .. v13 
        local v15 = "(vBot_4.8 TargetBot arena config)"
        local v16 = v14 .. v15 
        local v17 = "[tibia-probe] "
        local v18 = v17 .. v16 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v18)
        g_logger.info(v18)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v19 = g_clock.millis()
        do (v4).value = (v19) end
        local v20 = closure3({ v0, v1, v2, v3, v4 })
        scheduleEvent(v20, 2500)
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
        local v10 = closure4(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure9(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        local v4 = g_clock.millis()
        local v5 = (v1).value
        local v6 = spiral_wrap_signed((v4 - v5), 32)
        local v7 = (v0).value
        local v8 = v7 == 1
        local getv11 = function()
            if v8 then
                local v9 = "health potion"
                local v10 = string.find(v3, v9, 1, true) ~= nil 
                return v10
            else
                return false
            end
        end
        local v11 = getv11()
        if v11 then
            local v12 = "server text after finish (potion not counted) ["
            local v13 = v12 .. v2 
            local v14 = "] @t+"
            local v15 = v13 .. v14 
            local v16 = format_real_1(v6)
            local v17 = v15 .. v16 
            local v18 = "[tibia-probe] "
            local v19 = v18 .. v17 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v19)
            g_logger.info(v19)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            return nil
        else
            local v20 = "server text ["
            local v21 = v20 .. v2 
            local v22 = "]: "
            local v23 = v21 .. v22 
            local v24 = v23 .. v3 
            local v25 = " @t+"
            local v26 = v24 .. v25 
            local v27 = format_real_1(v6)
            local v28 = v26 .. v27 
            local v29 = "[tibia-probe] "
            local v30 = v29 .. v28 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v30)
            g_logger.info(v30)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            return nil
        end
    end
end

function on_text_c8(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(v2)
        return closure9({ v0, v1, v2 })
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    end
end

function poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v0 == ""
    local getv13 = function()
        if v9 then
            return true
        else
            local v10 = "/"
            local v11 = v10 .. v0 
            local v12 = g_resources.fileExists(v11)
            return v12
        end
    end
    local v13 = getv13()
    if v13 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v14 = ready_c2({ v4, v5, v6, v7, v8 })
        local v15 = closure7(nil)
        local v16 = on_text_c8({ v2, v3 })
        connect(g_game, { onGameStart = v14, onLoginError = function(message) (v15)(tostring(message)) end, onTextMessage = function(mode, text) (v16)(tostring(mode))(tostring(text)) end })
        local v17 = "@god"
        local v18 = "@god\ngod"
        g_game.loginWorld(v17, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v18)
        return nil
    else
        local v19 = closure10({ v0, v1, v2, v3, v4, v5, v6, v7, v8 })
        scheduleEvent(v19, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7 = (table.unpack or unpack)(capt)
    return function(dom)
        local v8 = "TIBIA_LOGIN_GATE"
        local v9 = ""
        local v10 = os.getenv(v8) or (v9)
        return poll_0(v10, v0, v1, v2, v3, v4, v5, v6, v7)
    end
end

function closure11(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = (v0).value
        local v2 = v1 == 0
        if v2 then
            do (v0).value = (1) end
            local v3 = ArenaParity and ArenaParity.summary() or ""
            local v4 = v3 ~= ""
            if v4 then
                local v5 = "[tibia-probe] "
                local v6 = v5 .. v3 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v6)
                g_logger.info(v6)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v7 = "finish: "
            local v8 = "timeout"
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
            local v13 = closure4(nil)
            scheduleEvent(v13, 2000)
            return nil
        else
        end
    end
end

local v0 = { value = 0 }
local v1 = { value = 999 }
local v2 = { value = 0 }
local v3 = "TIBIA_ARENA_FULL_EXPERIENCE"
local v4 = tonumber(os.getenv(v3) or "") or (90)
local v5 = { value = 0 }
local v6 = "TIBIA_ARENA_CHARACTER"
local v7 = "Knight Sample"
local v8 = os.getenv(v6) or (v7)
local v9 = "_1511"
local v10 = v8 .. v9 
do (function(key) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = false }; g_settings.setNode("bot", s); g_settings.save() end)(v10) end
local v11 = os.getenv(v6) or (v7)
local v12 = "TIBIA_PROBE_HIDDEN"
local v13 = "1"
local v14 = os.getenv(v12) == (v13)
if v14 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v15 = closure0(nil)
scheduleEvent(v15, 200)
scheduleEvent(v15, 1000)
local v16 = closure1({ v11, v0, v5, v0, v1, v2, v4, v5 })
scheduleEvent(v16, 3000)
local v17 = closure11({ v0 })
scheduleEvent(v17, 200000)
return 0
