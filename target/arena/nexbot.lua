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
    local v0, v1, v2, v3, v4, v5, v6 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_3(v0, v1, v2, v3, v4, v5, v6)
    end
end

function go_3(v0, v1, v2, v3, v4, v5, v6)
    local v7 = (v6).value
    local v8 = v7 == 0
    if v8 then
        local v9 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
        local v10 = v9 == false
        if v10 then
            local v11 = (v6).value
            local v12 = v11 == 0
            if v12 then
                do (v6).value = (1) end
                local v13 = ArenaParity and ArenaParity.summary() or ""
                local v14 = v13 ~= ""
                if v14 then
                    local v15 = "[tibia-probe] "
                    local v16 = v15 .. v13 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v16)
                    g_logger.info(v16)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v17 = "finish: "
                local v18 = "offline"
                local v19 = v17 .. v18 
                local v20 = "[tibia-probe] "
                local v21 = v20 .. v19 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v21)
                g_logger.info(v21)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v22 = g_game.isOnline()
                if v22 then
                    g_game.safeLogout()
                else
                end
                local v23 = closure4(nil)
                scheduleEvent(v23, 2000)
                return nil
            else
            end
        else
            local v24 = g_game.getLocalPlayer():getHealth()
            local v25 = (v4).value
            local v26 = v24 < v25
            if v26 then
                do (v4).value = (v24) end
            else
            end
            local v27 = g_clock.millis()
            local v28 = spiral_wrap_signed((v27 - v2), 32)
            local v29 = (v5).value
            local v30 = v29 == 0
            local getv34 = function()
                if v30 then
                    local v31 = g_game.getLocalPlayer():getExperience()
                    local v32 = spiral_wrap_signed((v31 - v1), 32)
                    local v33 = v32 >= v3
                    return v33
                else
                    return false
                end
            end
            local v34 = getv34()
            local getv68 = function()
                if v34 then
                    do (v5).value = (1) end
                    local v35 = g_game.getLocalPlayer():getExperience()
                    local v36 = spiral_wrap_signed((v35 - v1), 32)
                    local v37 = (v4).value
                    local v38 = format_real_1(v28)
                    local v39 = "cleared at "
                    local v40 = v39 .. v38 
                    local v41 = " ms"
                    local v42 = v40 .. v41 
                    local v43 = "[tibia-probe] "
                    local v44 = v43 .. v42 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v44)
                    g_logger.info(v44)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v45 = format_real_1(v36)
                    local v46 = "cleared: experience +"
                    local v47 = v46 .. v45 
                    local v48 = " health "
                    local v49 = v47 .. v48 
                    local v50 = format_real_1(v24)
                    local v51 = v49 .. v50 
                    local v52 = " lowest health "
                    local v53 = v51 .. v52 
                    local v54 = format_real_1(v37)
                    local v55 = v53 .. v54 
                    local v56 = v43 .. v55 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v56)
                    g_logger.info(v56)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v57 = (v6).value
                    local v58 = v57 == 0
                    if v58 then
                        do (v6).value = (1) end
                        local v59 = ArenaParity and ArenaParity.summary() or ""
                        local v60 = v59 ~= ""
                        if v60 then
                            local v61 = v43 .. v59 
                            TibiaProbeLog = TibiaProbeLog or {}
                            table.insert(TibiaProbeLog, v61)
                            g_logger.info(v61)
                            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        else
                        end
                        local v62 = "finish: "
                        local v63 = "cleared"
                        local v64 = v62 .. v63 
                        local v65 = v43 .. v64 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v65)
                        g_logger.info(v65)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v66 = g_game.isOnline()
                        if v66 then
                            g_game.safeLogout()
                        else
                        end
                        local v67 = closure4(nil)
                        scheduleEvent(v67, 2000)
                    else
                    end
                    return true
                else
                    return false
                end
            end
            local v68 = getv68()
            local v69 = v68 == false
            if v69 then
                local v70 = (math.modf(v28 / 1000))
                local v71 = g_game.getLocalPlayer():getExperience()
                local v72 = spiral_wrap_signed((v71 - v1), 32)
                local v73 = (v4).value
                local v74 = (function() local a = g_game.getAttackingCreature(); if not a then return "nothing" end; return a:getName() .. " " .. a:getHealthPercent() .. "%" end)()
                local v75 = g_game.getLocalPlayer():getPosition()
                local v76 = v75.x
                local v77 = v75.y
                local v78 = v75.z
                local v79 = format_real_1(v76)
                local v80 = ""
                local v81 = v80 .. v79 
                local v82 = ","
                local v83 = v81 .. v82 
                local v84 = format_real_1(v77)
                local v85 = v83 .. v84 
                local v86 = v85 .. v82 
                local v87 = format_real_1(v78)
                local v88 = v86 .. v87 
                local v89 = format_real_1(v70)
                local v90 = "t="
                local v91 = v90 .. v89 
                local v92 = "s experience +"
                local v93 = v91 .. v92 
                local v94 = format_real_1(v72)
                local v95 = v93 .. v94 
                local v96 = " health "
                local v97 = v95 .. v96 
                local v98 = format_real_1(v24)
                local v99 = v97 .. v98 
                local v100 = " lowest "
                local v101 = v99 .. v100 
                local v102 = format_real_1(v73)
                local v103 = v101 .. v102 
                local v104 = " attacking "
                local v105 = v103 .. v104 
                local v106 = v105 .. v74 
                local v107 = " at "
                local v108 = v106 .. v107 
                local v109 = v108 .. v88 
                local v110 = "[tibia-probe] "
                local v111 = v110 .. v109 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v111)
                g_logger.info(v111)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v112 = (function(s) local p = g_game.getLocalPlayer(); local function idAt(slot) local item = p:getInventoryItem(slot); return item and tostring(item:getId()) or "-" end; local a = g_game.getAttackingCreature(); local parts = {}; for name, count in pairs(s.other) do table.insert(parts, name .. "=" .. count) end; table.sort(parts); local d = "-"; if a then local q, r = a:getPosition(), p:getPosition(); d = tostring(math.max(math.abs(q.x - r.x), math.abs(q.y - r.y))) end; return string.format("diag attack calls %d cancels %d hands %s target distance %s chase %s fight %s", s.attack, s.cancel, idAt(InventorySlotLeft) .. "/" .. idAt(InventorySlotRight), d, tostring(g_game.getChaseMode()), tostring(g_game.getFightMode())) .. " calls " .. table.concat(parts, " ") .. " guarded cancelFollow " .. s.guarded end)(v0)
                local v113 = v112 ~= ""
                if v113 then
                    local v114 = v110 .. v112 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v114)
                    g_logger.info(v114)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v115 = v28 > 150000
                if v115 then
                    local v116 = format_real_1(v72)
                    local v117 = "end: experience +"
                    local v118 = v117 .. v116 
                    local v119 = " lowest health "
                    local v120 = v118 .. v119 
                    local v121 = format_real_1(v73)
                    local v122 = v120 .. v121 
                    local v123 = v110 .. v122 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v123)
                    g_logger.info(v123)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v124 = (v6).value
                    local v125 = v124 == 0
                    if v125 then
                        do (v6).value = (1) end
                        local v126 = ArenaParity and ArenaParity.summary() or ""
                        local v127 = v126 ~= ""
                        if v127 then
                            local v128 = v110 .. v126 
                            TibiaProbeLog = TibiaProbeLog or {}
                            table.insert(TibiaProbeLog, v128)
                            g_logger.info(v128)
                            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        else
                        end
                        local v129 = "finish: "
                        local v130 = "run complete"
                        local v131 = v129 .. v130 
                        local v132 = v110 .. v131 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v132)
                        g_logger.info(v132)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v133 = g_game.isOnline()
                        if v133 then
                            g_game.safeLogout()
                        else
                        end
                        local v134 = closure4(nil)
                        scheduleEvent(v134, 2000)
                        return nil
                    else
                    end
                else
                    local v135 = closure6({ v0, v1, v2, v3, v4, v5, v6 })
                    scheduleEvent(v135, 10000)
                    return nil
                end
            else
            end
        end
    else
    end
end

function closure3(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        g_game.setFightMode(FightBalanced)
        local v6 = "TIBIA_ARENA_CHARACTER"
        local v7 = "Knight Sample"
        local v8 = os.getenv(v6) or (v7)
        local v9 = "_1511"
        local v10 = v8 .. v9 
        local v11 = "nExBot"
        do (function(key, config) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = true, config = config }; g_settings.setNode("bot", s); g_settings.save() end)(v10, v11) end
        modules.game_bot.refresh()
        local v12 = g_clock.millis()
        local v13 = (v5).value
        local v14 = spiral_wrap_signed((v12 - v13), 32)
        local v15 = format_real_1(v14)
        local v16 = "client bot starts @t+"
        local v17 = v16 .. v15 
        local v18 = "[tibia-probe] "
        local v19 = v18 .. v17 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v19)
        g_logger.info(v19)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v20 = g_game.getLocalPlayer():getExperience()
        local v21 = g_clock.millis()
        go_2(v20, v21, v4, v2, v3, v1)
        return go_3(v0, v20, v21, v4, v2, v3, v1)
    end
end

function ready_c2(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        local v6 = g_game.getLocalPlayer():getName()
        local v7 = g_game.getLocalPlayer():getHealth()
        local v8 = "in game as "
        local v9 = v8 .. v6 
        local v10 = " health "
        local v11 = v9 .. v10 
        local v12 = format_real_1(v7)
        local v13 = v11 .. v12 
        local v14 = " "
        local v15 = v13 .. v14 
        local v16 = "(nExBot 4.0.4 at 19632d4, TargetBot arena config)"
        local v17 = v15 .. v16 
        local v18 = "[tibia-probe] "
        local v19 = v18 .. v17 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v19)
        g_logger.info(v19)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v20 = g_clock.millis()
        do (v5).value = (v20) end
        local v21 = closure3({ v0, v1, v2, v3, v4, v5 })
        scheduleEvent(v21, 2500)
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
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    end
end

function poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    local v10 = v0 == ""
    local getv14 = function()
        if v10 then
            return true
        else
            local v11 = "/"
            local v12 = v11 .. v0 
            local v13 = g_resources.fileExists(v12)
            return v13
        end
    end
    local v14 = getv14()
    if v14 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v15 = ready_c2({ v4, v5, v6, v7, v8, v9 })
        local v16 = closure7(nil)
        local v17 = on_text_c8({ v2, v3 })
        connect(g_game, { onGameStart = v15, onLoginError = function(message) (v16)(tostring(message)) end, onTextMessage = function(mode, text) (v17)(tostring(mode))(tostring(text)) end })
        local v18 = "@god"
        local v19 = "@god\ngod"
        g_game.loginWorld(v18, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v19)
        return nil
    else
        local v20 = closure10({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 })
        scheduleEvent(v20, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8 = (table.unpack or unpack)(capt)
    return function(dom)
        local v9 = "TIBIA_LOGIN_GATE"
        local v10 = ""
        local v11 = os.getenv(v9) or (v10)
        return poll_0(v11, v0, v1, v2, v3, v4, v5, v6, v7, v8)
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

local v0 = (function() local s = { attack = 0, cancel = 0, guarded = 0, other = {} }; local nativeAttack, nativeCancel, nativeCancelAndFollow, nativeCancelFollow = g_game.attack, g_game.cancelAttack, g_game.cancelAttackAndFollow, g_game.cancelFollow; g_game.attack = function(...) s.attack = s.attack + 1 return nativeAttack(...) end; if nativeCancel then g_game.cancelAttack = function(...) s.cancel = s.cancel + 1 return nativeCancel(...) end end; if nativeCancelAndFollow then g_game.cancelAttackAndFollow = function(...) s.cancel = s.cancel + 1 return nativeCancelAndFollow(...) end end; g_game.cancelFollow = function(...) if not g_game.getFollowingCreature() then s.guarded = s.guarded + 1 return end return nativeCancelFollow(...) end; for _, name in ipairs({ "stop", "walk", "autoWalk", "forceWalk", "turn", "follow", "cancelFollow", "setChaseMode", "setFightMode", "useInventoryItemWith", "useWith", "move", "look", "talk", "equipItem" }) do local native = g_game[name]; if native then g_game[name] = function(...) s.other[name] = (s.other[name] or 0) + 1 return native(...) end end end; return s end)()
local v1 = { value = 0 }
local v2 = { value = 999 }
local v3 = { value = 0 }
local v4 = "TIBIA_ARENA_FULL_EXPERIENCE"
local v5 = tonumber(os.getenv(v4) or "") or (90)
local v6 = { value = 0 }
local v7 = "TIBIA_ARENA_CHARACTER"
local v8 = "Knight Sample"
local v9 = os.getenv(v7) or (v8)
local v10 = "_1511"
local v11 = v9 .. v10 
do (function(key) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = false }; g_settings.setNode("bot", s); g_settings.save() end)(v11) end
local v12 = os.getenv(v7) or (v8)
local v13 = "TIBIA_PROBE_HIDDEN"
local v14 = "1"
local v15 = os.getenv(v13) == (v14)
if v15 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v16 = closure0(nil)
scheduleEvent(v16, 200)
scheduleEvent(v16, 1000)
local v17 = closure1({ v12, v1, v6, v0, v1, v2, v3, v5, v6 })
scheduleEvent(v17, 3000)
local v18 = closure11({ v1 })
scheduleEvent(v18, 200000)
return 0
