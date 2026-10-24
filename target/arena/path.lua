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
local Mut0, closure0, format_real_1, closure4, scan_3, closure5, go_2, closure3, ready_c2, closure6, closure8, on_text_c7, closure9, poll_0, closure1, closure10
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

function scan_3(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v5 > v4
    local getv41 = function()
        if v9 then
            return { [1]=v6, [2]=v7, [3]=v8 }
        else
            local v10 = (v3)[v5]
            local v11 = (v10):isMonster() and not (v10):isDead() and (v10):getPosition() ~= nil
            local getv38 = function()
                if v11 then
                    local v12 = (v10):getPosition()
                    local v13 = v12.x
                    local v14 = v12.y
                    local v15 = v12.z
                    local v16 = v13 > v0
                    local getv19 = function()
                        if v16 then
                            local v17 = spiral_wrap_signed((v13 - v0), 32)
                            return v17
                        else
                            local v18 = spiral_wrap_signed((v0 - v13), 32)
                            return v18
                        end
                    end
                    local v19 = getv19()
                    local v20 = v14 > v1
                    local getv23 = function()
                        if v20 then
                            local v21 = spiral_wrap_signed((v14 - v1), 32)
                            return v21
                        else
                            local v22 = spiral_wrap_signed((v1 - v14), 32)
                            return v22
                        end
                    end
                    local v23 = getv23()
                    local v24 = v19 > v23
                    local getv25 = function()
                        if v24 then
                            return v19
                        else
                            return v23
                        end
                    end
                    local v25 = getv25()
                    local v26 = spiral_wrap_signed((v5 + 1), 32)
                    local v27 = v25 < v8
                    local getv28 = function()
                        if v27 then
                            return { [1]=true, [2]=v5, [3]=v25 }
                        else
                            return { [1]=v6, [2]=v7, [3]=v8 }
                        end
                    end
                    local v28, v29, v30 = (table.unpack or unpack)(getv28())
                    local v31, v32, v33 = (table.unpack or unpack)(scan_3(v0, v1, v2, v3, v4, v26, v28, v29, v30))
                    return { [1]=v31, [2]=v32, [3]=v33 }
                else
                    local v34 = spiral_wrap_signed((v5 + 1), 32)
                    local v35, v36, v37 = (table.unpack or unpack)(scan_3(v0, v1, v2, v3, v4, v34, v6, v7, v8))
                    return { [1]=v35, [2]=v36, [3]=v37 }
                end
            end
            local v38, v39, v40 = (table.unpack or unpack)(getv38())
            return { [1]=v38, [2]=v39, [3]=v40 }
        end
    end
    local v41, v42, v43 = (table.unpack or unpack)(getv41())
    return { [1]=v41, [2]=v42, [3]=v43 }
end

function closure5(capt)
    local v0, v1, v2, v3, v4, v5, v6 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_2(v0, v1, v6, v3, v4, v5, v2)
    end
end

function go_2(v0, v1, v2, v3, v4, v5, v6)
    local v7 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
    local v8 = v7 == false
    if v8 then
        local v9 = (v0).value
        local v10 = v9 == 0
        if v10 then
            do (v0).value = (1) end
            local v11 = "finish: "
            local v12 = "offline"
            local v13 = v11 .. v12 
            local v14 = "[tibia-probe] "
            local v15 = v14 .. v13 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v15)
            g_logger.info(v15)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v16 = g_game.isOnline()
            if v16 then
                g_game.safeLogout()
            else
            end
            local v17 = closure4(nil)
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
        local v30, v31, v32 = (table.unpack or unpack)(scan_3(v21, v22, v23, v24, v25, v26, v27, v28, v29))
        local getv76 = function()
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
                    local v46 = format_real_1(v35)
                    local v47 = ""
                    local v48 = v47 .. v46 
                    local v49 = ","
                    local v50 = v48 .. v49 
                    local v51 = format_real_1(v36)
                    local v52 = v50 .. v51 
                    local v53 = v52 .. v49 
                    local v54 = format_real_1(v37)
                    local v55 = v53 .. v54 
                    local v56 = format_real_1(v19)
                    local v57 = "path t="
                    local v58 = v57 .. v56 
                    local v59 = " ms monster at "
                    local v60 = v58 .. v59 
                    local v61 = v60 .. v55 
                    local v62 = " distance "
                    local v63 = v61 .. v62 
                    local v64 = format_real_1(v32)
                    local v65 = v63 .. v64 
                    local v66 = " step "
                    local v67 = v65 .. v66 
                    local v68 = format_real_1(v45)
                    local v69 = v67 .. v68 
                    local v70 = "[tibia-probe] "
                    local v71 = v70 .. v69 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v71)
                    g_logger.info(v71)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v72 = v32 <= 1
                local getv73 = function()
                    if v42 then
                        return { [1]=v35, [2]=v36, [3]=v37 }
                    else
                        return { [1]=v3, [2]=v4, [3]=v5 }
                    end
                end
                local v73, v74, v75 = (table.unpack or unpack)(getv73())
                return { [1]=v72, [2]=true, [3]=v73, [4]=v74, [5]=v75, [6]=v45 }
            else
                return { [1]=false, [2]=v2, [3]=v3, [4]=v4, [5]=v5, [6]=v6 }
            end
        end
        local v76, v77, v78, v79, v80, v81 = (table.unpack or unpack)(getv76())
        if v76 then
            local v82 = format_real_1(v21)
            local v83 = ""
            local v84 = v83 .. v82 
            local v85 = ","
            local v86 = v84 .. v85 
            local v87 = format_real_1(v22)
            local v88 = v86 .. v87 
            local v89 = v88 .. v85 
            local v90 = format_real_1(v23)
            local v91 = v89 .. v90 
            local v92 = format_real_1(v19)
            local v93 = "arrived at "
            local v94 = v93 .. v92 
            local v95 = " ms after "
            local v96 = v94 .. v95 
            local v97 = format_real_1(v81)
            local v98 = v96 .. v97 
            local v99 = " steps, knight at "
            local v100 = v98 .. v99 
            local v101 = v100 .. v91 
            local v102 = "[tibia-probe] "
            local v103 = v102 .. v101 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v103)
            g_logger.info(v103)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v104 = (v0).value
            local v105 = v104 == 0
            if v105 then
                do (v0).value = (1) end
                local v106 = "finish: "
                local v107 = "arrived"
                local v108 = v106 .. v107 
                local v109 = v102 .. v108 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v109)
                g_logger.info(v109)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v110 = g_game.isOnline()
                if v110 then
                    g_game.safeLogout()
                else
                end
                local v111 = closure4(nil)
                scheduleEvent(v111, 2000)
                return nil
            else
            end
        else
            local v112 = v19 > 30000
            if v112 then
                local v113 = format_real_1(v19)
                local v114 = "not arrived after "
                local v115 = v114 .. v113 
                local v116 = " ms, "
                local v117 = v115 .. v116 
                local v118 = format_real_1(v81)
                local v119 = v117 .. v118 
                local v120 = " steps"
                local v121 = v119 .. v120 
                local v122 = "[tibia-probe] "
                local v123 = v122 .. v121 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v123)
                g_logger.info(v123)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v124 = (v0).value
                local v125 = v124 == 0
                if v125 then
                    do (v0).value = (1) end
                    local v126 = "finish: "
                    local v127 = "not arrived"
                    local v128 = v126 .. v127 
                    local v129 = v122 .. v128 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v129)
                    g_logger.info(v129)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v130 = g_game.isOnline()
                    if v130 then
                        g_game.safeLogout()
                    else
                    end
                    local v131 = closure4(nil)
                    scheduleEvent(v131, 2000)
                    return nil
                else
                end
            else
                local v132 = closure5({ v0, v1, v81, v78, v79, v80, v77 })
                scheduleEvent(v132, 50)
                return nil
            end
        end
    end
end

function closure3(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = g_game.getLocalPlayer():getName()
        local v2 = g_game.getLocalPlayer():getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local v6 = format_real_1(v3)
        local v7 = ""
        local v8 = v7 .. v6 
        local v9 = ","
        local v10 = v8 .. v9 
        local v11 = format_real_1(v4)
        local v12 = v10 .. v11 
        local v13 = v12 .. v9 
        local v14 = format_real_1(v5)
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
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v24)
        g_logger.info(v24)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v25 = g_clock.millis()
        local v26 = false
        local v27 = 0
        local v28 = 0
        local v29 = 0
        local v30 = 0
        return go_2(v0, v25, v26, v27, v28, v29, v30)
    end
end

function ready_c2(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = closure3({ v0 })
        scheduleEvent(v1, 1500)
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
        local v10 = closure4(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure8(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = "server text ["
        local v3 = v2 .. v0 
        local v4 = "]: "
        local v5 = v3 .. v4 
        local v6 = v5 .. v1 
        local v7 = "[tibia-probe] "
        local v8 = v7 .. v6 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v8)
        g_logger.info(v8)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        return nil
    end
end

function on_text_c7(capt)
    return function(v0)
        return closure8({ v0 })
    end
end

function closure9(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2)
    end
end

function poll_0(v0, v1, v2)
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
        local v8 = ready_c2({ v2 })
        local v9 = closure6(nil)
        local v10 = on_text_c7(nil)
        connect(g_game, { onGameStart = v8, onLoginError = function(message) (v9)(tostring(message)) end, onTextMessage = function(mode, text) (v10)(tostring(mode))(tostring(text)) end })
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
        local v4 = os.getenv(v2) or (v3)
        return poll_0(v4, v0, v1)
    end
end

function closure10(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = (v0).value
        local v2 = v1 == 0
        if v2 then
            do (v0).value = (1) end
            local v3 = "finish: "
            local v4 = "timeout"
            local v5 = v3 .. v4 
            local v6 = "[tibia-probe] "
            local v7 = v6 .. v5 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v7)
            g_logger.info(v7)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v8 = g_game.isOnline()
            if v8 then
                g_game.safeLogout()
            else
            end
            local v9 = closure4(nil)
            scheduleEvent(v9, 2000)
            return nil
        else
        end
    end
end

local v0 = { value = 0 }
local v1 = "TIBIA_ARENA_CHARACTER"
local v2 = "Knight Sample"
local v3 = os.getenv(v1) or (v2)
local v4 = "_1511"
local v5 = v3 .. v4 
do (function(key) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = false }; g_settings.setNode("bot", s); g_settings.save() end)(v5) end
local v6 = os.getenv(v1) or (v2)
local v7 = "TIBIA_PROBE_HIDDEN"
local v8 = "1"
local v9 = os.getenv(v7) == (v8)
if v9 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v10 = closure0(nil)
scheduleEvent(v10, 200)
scheduleEvent(v10, 1000)
local v11 = closure1({ v6, v0 })
scheduleEvent(v11, 3000)
local v12 = closure10({ v0 })
scheduleEvent(v12, 60000)
return 0
