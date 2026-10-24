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
local Mut0, closure0, format_real_1, closure4, scan_3, closure5, go_2, closure3, ready_c2, closure6, closure9, closure8, on_text_c7, closure10, poll_0, closure1, closure11
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
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_2(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    end
end

function go_2(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    local v13 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
    local v14 = v13 == false
    if v14 then
        local v15 = (v9).value
        local v16 = v15 == 0
        if v16 then
            do (v9).value = (1) end
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
        local v24 = g_clock.millis()
        local v25 = (v6).creature ~= nil
        local getv28 = function()
            if v25 then
                local v26 = (v6).creature
                local v27 = (v26):isDead()
                return v27
            else
                return false
            end
        end
        local v28 = getv28()
        if v28 then
            local v29 = (v3).value
            local v30 = spiral_wrap_signed((v29 + 1), 32)
            do (v3).value = (v30) end
            local v31 = (v3).value
            local v32 = g_game.getLocalPlayer():getExperience()
            local v33 = (v7).value
            local v34 = spiral_wrap_signed((v32 - v33), 32)
            local v35 = format_real_1(v31)
            local v36 = "kill "
            local v37 = v36 .. v35 
            local v38 = " confirmed dead, experience +"
            local v39 = v37 .. v38 
            local v40 = format_real_1(v34)
            local v41 = v39 .. v40 
            local v42 = "[tibia-probe] "
            local v43 = v42 .. v41 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v43)
            g_logger.info(v43)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            do (v6).creature = nil end
        else
        end
        local v44 = (v6).creature ~= nil
        local v45 = v44 == false
        local getv96 = function()
            if v45 then
                local v46 = g_game.getLocalPlayer():getPosition()
                local v47 = v46.x
                local v48 = v46.y
                local v49 = v46.z
                local v50 = g_map.getSpectators({ x = v47, y = v48, z = v49 }, false)
                local v51 = #(v50)
                local v52 = 1
                local v53 = false
                local v54 = 0
                local v55 = 999
                local v56, v57, v58 = (table.unpack or unpack)(scan_3(v47, v48, v49, v50, v51, v52, v53, v54, v55))
                local getv60 = function()
                    if v56 then
                        local v59 = v58 <= 1
                        return v59
                    else
                        return false
                    end
                end
                local v60 = getv60()
                if v60 then
                    local v61 = (v50)[v57]
                    do (v6).creature = v61 end
                    g_game.attack(v61)
                    do (v5).value = (0) end
                    return v24
                else
                    return v11
                end
            else
                local v63 = spiral_wrap_signed((v24 - v11), 32)
                local v64 = v63 >= 2000
                if v64 then
                    local v65 = (v6).creature
                    local v66 = (v65):getPosition() ~= nil
                    local getv86 = function()
                        if v66 then
                            local v67 = (v65):getPosition()
                            local v68 = v67.x
                            local v69 = v67.y
                            local v70 = v67.z
                            local v71 = g_game.getLocalPlayer():getPosition()
                            local v72 = v71.x
                            local v73 = v71.y
                            local v74 = v71.z
                            local v75 = v68 > v72
                            local getv78 = function()
                                if v75 then
                                    local v76 = spiral_wrap_signed((v68 - v72), 32)
                                    return v76
                                else
                                    local v77 = spiral_wrap_signed((v72 - v68), 32)
                                    return v77
                                end
                            end
                            local v78 = getv78()
                            local v79 = v69 > v73
                            local getv82 = function()
                                if v79 then
                                    local v80 = spiral_wrap_signed((v69 - v73), 32)
                                    return v80
                                else
                                    local v81 = spiral_wrap_signed((v73 - v69), 32)
                                    return v81
                                end
                            end
                            local v82 = getv82()
                            local v83 = v78 > v82
                            local getv84 = function()
                                if v83 then
                                    return v78
                                else
                                    return v82
                                end
                            end
                            local v84 = getv84()
                            local v85 = v84 <= 1
                            return v85
                        else
                            return false
                        end
                    end
                    local v86 = getv86()
                    local getv89 = function()
                        if v86 then
                            local v87 = g_game.getLocalPlayer():getHealth()
                            local v88 = v87 > 0
                            return v88
                        else
                            return false
                        end
                    end
                    local v89 = getv89()
                    local getv92 = function()
                        if v89 then
                            local v90 = (v5).value
                            local v91 = v90 == 0
                            return v91
                        else
                            return false
                        end
                    end
                    local v92 = getv92()
                    if v92 then
                        local v93 = (v2).value
                        local v94 = spiral_wrap_signed((v93 + 1), 32)
                        do (v2).value = (v94) end
                    else
                    end
                    do (v5).value = (0) end
                    return v24
                else
                    return v11
                end
            end
        end
        local v96 = getv96()
        local v97 = g_game.getLocalPlayer():getHealth()
        local v98 = v97 < v10
        local getv101 = function()
            if v98 then
                local v99 = spiral_wrap_signed((v24 - v12), 32)
                local v100 = v99 >= 1000
                return v100
            else
                return false
            end
        end
        local v101 = getv101()
        local getv105 = function()
            if v101 then
                local v102 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                local v103 = (v4).value
                local v104 = spiral_wrap_signed((v103 + 1), 32)
                do (v4).value = (v104) end
                return v24
            else
                return v12
            end
        end
        local v105 = getv105()
        local v106 = (v8).value
        local v107 = spiral_wrap_signed((v24 - v106), 32)
        local v108 = v107 > 200000
        if v108 then
            local v109 = (v4).value
            local v110 = format_real_1(v109)
            local v111 = "potions "
            local v112 = v111 .. v110 
            local v113 = "[tibia-probe] "
            local v114 = v113 .. v112 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v114)
            g_logger.info(v114)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v115 = #(v0)
            local v116 = (v2).value
            local v117 = (v3).value
            local v118 = (function(s) local n = 0; for _, v in ipairs(s) do n = n + v end; return n end)(v0)
            local v119 = (function(s) local sorted = {}; for i, v in ipairs(s) do sorted[i] = v end; table.sort(sorted); return #sorted > 0 and sorted[math.floor((#sorted + 1) / 2)] or 0 end)(v0)
            local v120 = g_game.getLocalPlayer():getExperience()
            local v121 = (v7).value
            local v122 = spiral_wrap_signed((v120 - v121), 32)
            local v123 = g_game.getLocalPlayer():getHealth()
            local v124 = spiral_wrap_signed((v115 + v116), 32)
            local v125 = v124 > 0
            local getv130 = function()
                if v125 then
                    local v126 = v115
                    local v127 = (v126 * 100.0)
                    local v128 = v124
                    local v129 = v127 / v128
                    return v129
                else
                    return 0.0
                end
            end
            local v130 = getv130()
            local v131 = v115 > 0
            local getv135 = function()
                if v131 then
                    local v132 = v118
                    local v133 = v115
                    local v134 = v132 / v133
                    return v134
                else
                    return 0.0
                end
            end
            local v135 = getv135()
            local v136 = "end"
            local v137 = ": swings "
            local v138 = v136 .. v137 
            local v139 = format_real_1(v124)
            local v140 = v138 .. v139 
            local v141 = " landed "
            local v142 = v140 .. v141 
            local v143 = format_real_1(v115)
            local v144 = v142 .. v143 
            local v145 = " ("
            local v146 = v144 .. v145 
            local v147 = string.format("%." .. 1 .. "f", v130)
            local v148 = v146 .. v147 
            local v149 = "%) mean landed "
            local v150 = v148 .. v149 
            local v151 = string.format("%." .. 2 .. "f", v135)
            local v152 = v150 .. v151 
            local v153 = " median "
            local v154 = v152 .. v153 
            local v155 = format_real_1(v119)
            local v156 = v154 .. v155 
            local v157 = " total "
            local v158 = v156 .. v157 
            local v159 = format_real_1(v118)
            local v160 = v158 .. v159 
            local v161 = " kills "
            local v162 = v160 .. v161 
            local v163 = format_real_1(v117)
            local v164 = v162 .. v163 
            local v165 = " experience +"
            local v166 = v164 .. v165 
            local v167 = format_real_1(v122)
            local v168 = v166 .. v167 
            local v169 = " health "
            local v170 = v168 .. v169 
            local v171 = format_real_1(v123)
            local v172 = v170 .. v171 
            local v173 = v113 .. v172 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v173)
            g_logger.info(v173)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v174 = table.concat(v0, ",")
            local v175 = "hits "
            local v176 = v175 .. v174 
            local v177 = v113 .. v176 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v177)
            g_logger.info(v177)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v178 = #(v1)
            local v179 = (function(s) local n = 0; for _, v in ipairs(s) do n = n + v end; return n end)(v1)
            local v180 = (function(s) local sorted = {}; for i, v in ipairs(s) do sorted[i] = v end; table.sort(sorted); return #sorted > 0 and sorted[math.floor((#sorted + 1) / 2)] or 0 end)(v1)
            local v181 = (function(s) local n = 0; for _, v in ipairs(s) do if v > n then n = v end end; return n end)(v1)
            local v182 = v178 > 0
            local getv186 = function()
                if v182 then
                    local v183 = v179
                    local v184 = v178
                    local v185 = v183 / v184
                    return v185
                else
                    return 0.0
                end
            end
            local v186 = getv186()
            local v187 = format_real_1(v178)
            local v188 = "taken: count "
            local v189 = v188 .. v187 
            local v190 = " mean "
            local v191 = v189 .. v190 
            local v192 = string.format("%." .. 2 .. "f", v186)
            local v193 = v191 .. v192 
            local v194 = v193 .. v153 
            local v195 = format_real_1(v180)
            local v196 = v194 .. v195 
            local v197 = " max "
            local v198 = v196 .. v197 
            local v199 = format_real_1(v181)
            local v200 = v198 .. v199 
            local v201 = v200 .. v157 
            local v202 = format_real_1(v179)
            local v203 = v201 .. v202 
            local v204 = v113 .. v203 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v204)
            g_logger.info(v204)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v205 = table.concat(v1, ",")
            local v206 = "taken "
            local v207 = v206 .. v205 
            local v208 = v113 .. v207 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v208)
            g_logger.info(v208)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v209 = (v9).value
            local v210 = v209 == 0
            if v210 then
                do (v9).value = (1) end
                local v211 = "finish: "
                local v212 = "measure complete"
                local v213 = v211 .. v212 
                local v214 = v113 .. v213 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v214)
                g_logger.info(v214)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v215 = g_game.isOnline()
                if v215 then
                    g_game.safeLogout()
                else
                end
                local v216 = closure4(nil)
                scheduleEvent(v216, 2000)
                return nil
            else
            end
        else
            local v217 = closure5({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v96, v105 })
            scheduleEvent(v217, 100)
            return nil
        end
    end
end

function closure3(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((false) and ChaseOpponent or DontChase) end
        g_game.setFightMode(FightBalanced)
        local v11 = tostring(g_game.getFightMode())
        local v12 = g_game.getLocalPlayer():getPosition()
        local v13 = v12.x
        local v14 = v12.y
        local v15 = v12.z
        local v16 = format_real_1(v13)
        local v17 = ""
        local v18 = v17 .. v16 
        local v19 = ","
        local v20 = v18 .. v19 
        local v21 = format_real_1(v14)
        local v22 = v20 .. v21 
        local v23 = v22 .. v19 
        local v24 = format_real_1(v15)
        local v25 = v23 .. v24 
        local v26 = "fight mode "
        local v27 = v26 .. v11 
        local v28 = " at "
        local v29 = v27 .. v28 
        local v30 = v29 .. v25 
        local v31 = "[tibia-probe] "
        local v32 = v31 .. v30 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v32)
        g_logger.info(v32)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v33 = g_game.getLocalPlayer():getExperience()
        do (v7).value = (v33) end
        local v34 = g_clock.millis()
        do (v8).value = (v34) end
        local v35 = (v8).value
        local v36 = 0
        return go_2(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v35, v36)
    end
end

function ready_c2(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        local v11 = g_game.getLocalPlayer():getName()
        local v12 = g_game.getLocalPlayer():getHealth()
        local v13 = "in game as "
        local v14 = v13 .. v11 
        local v15 = " health "
        local v16 = v14 .. v15 
        local v17 = format_real_1(v12)
        local v18 = v16 .. v17 
        local v19 = "[tibia-probe] "
        local v20 = v19 .. v18 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v20)
        g_logger.info(v20)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v21 = closure3({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 })
        scheduleEvent(v21, 1000)
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

function closure9(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 = (table.unpack or unpack)(capt)
    return function(dom)
        local v10 = (v9).value
        local v11 = v10 == 0
        if v11 then
            do (v9).value = (1) end
            local v12 = "finish: "
            local v13 = "death"
            local v14 = v12 .. v13 
            local v15 = "[tibia-probe] "
            local v16 = v15 .. v14 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v16)
            g_logger.info(v16)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v17 = g_game.isOnline()
            if v17 then
                g_game.safeLogout()
            else
            end
            local v18 = closure4(nil)
            scheduleEvent(v18, 2000)
            return nil
        else
        end
    end
end

function closure8(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(v11)
        local v12 = "loses (%d+) hitpoints? due to your"
        local v13 = tonumber(string.match(v11, v12)) or -1
        local v14 = "You lose (%d+) hitpoints? due to an attack"
        local v15 = tonumber(string.match(v11, v14)) or -1
        local v16 = v15 >= 0
        if v16 then
            table.insert(v1, v15)
            return nil
        else
            local v17 = v13 >= 0
            if v17 then
                table.insert(v0, v13)
                do (v5).value = (1) end
                local v18 = "critical"
                local v19 = string.find(v11, v18, 1, true) ~= nil 
                if v19 then
                    local v20 = "critical: "
                    local v21 = v20 .. v11 
                    local v22 = "[tibia-probe] "
                    local v23 = v22 .. v21 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v23)
                    g_logger.info(v23)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    return nil
                else
                end
            else
                local v24 = "You died"
                local v25 = string.find(v11, v24, 1, true) ~= nil 
                if v25 then
                    local v26 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
                    if v26 then
                        local v27 = (v4).value
                        local v28 = format_real_1(v27)
                        local v29 = "potions "
                        local v30 = v29 .. v28 
                        local v31 = "[tibia-probe] "
                        local v32 = v31 .. v30 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v32)
                        g_logger.info(v32)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v33 = #(v0)
                        local v34 = (v2).value
                        local v35 = (v3).value
                        local v36 = (function(s) local n = 0; for _, v in ipairs(s) do n = n + v end; return n end)(v0)
                        local v37 = (function(s) local sorted = {}; for i, v in ipairs(s) do sorted[i] = v end; table.sort(sorted); return #sorted > 0 and sorted[math.floor((#sorted + 1) / 2)] or 0 end)(v0)
                        local v38 = g_game.getLocalPlayer():getExperience()
                        local v39 = (v7).value
                        local v40 = spiral_wrap_signed((v38 - v39), 32)
                        local v41 = g_game.getLocalPlayer():getHealth()
                        local v42 = spiral_wrap_signed((v33 + v34), 32)
                        local v43 = v42 > 0
                        local getv48 = function()
                            if v43 then
                                local v44 = v33
                                local v45 = (v44 * 100.0)
                                local v46 = v42
                                local v47 = v45 / v46
                                return v47
                            else
                                return 0.0
                            end
                        end
                        local v48 = getv48()
                        local v49 = v33 > 0
                        local getv53 = function()
                            if v49 then
                                local v50 = v36
                                local v51 = v33
                                local v52 = v50 / v51
                                return v52
                            else
                                return 0.0
                            end
                        end
                        local v53 = getv53()
                        local v54 = "death"
                        local v55 = ": swings "
                        local v56 = v54 .. v55 
                        local v57 = format_real_1(v42)
                        local v58 = v56 .. v57 
                        local v59 = " landed "
                        local v60 = v58 .. v59 
                        local v61 = format_real_1(v33)
                        local v62 = v60 .. v61 
                        local v63 = " ("
                        local v64 = v62 .. v63 
                        local v65 = string.format("%." .. 1 .. "f", v48)
                        local v66 = v64 .. v65 
                        local v67 = "%) mean landed "
                        local v68 = v66 .. v67 
                        local v69 = string.format("%." .. 2 .. "f", v53)
                        local v70 = v68 .. v69 
                        local v71 = " median "
                        local v72 = v70 .. v71 
                        local v73 = format_real_1(v37)
                        local v74 = v72 .. v73 
                        local v75 = " total "
                        local v76 = v74 .. v75 
                        local v77 = format_real_1(v36)
                        local v78 = v76 .. v77 
                        local v79 = " kills "
                        local v80 = v78 .. v79 
                        local v81 = format_real_1(v35)
                        local v82 = v80 .. v81 
                        local v83 = " experience +"
                        local v84 = v82 .. v83 
                        local v85 = format_real_1(v40)
                        local v86 = v84 .. v85 
                        local v87 = " health "
                        local v88 = v86 .. v87 
                        local v89 = format_real_1(v41)
                        local v90 = v88 .. v89 
                        local v91 = v31 .. v90 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v91)
                        g_logger.info(v91)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v92 = table.concat(v0, ",")
                        local v93 = "hits "
                        local v94 = v93 .. v92 
                        local v95 = v31 .. v94 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v95)
                        g_logger.info(v95)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v96 = #(v1)
                        local v97 = (function(s) local n = 0; for _, v in ipairs(s) do n = n + v end; return n end)(v1)
                        local v98 = (function(s) local sorted = {}; for i, v in ipairs(s) do sorted[i] = v end; table.sort(sorted); return #sorted > 0 and sorted[math.floor((#sorted + 1) / 2)] or 0 end)(v1)
                        local v99 = (function(s) local n = 0; for _, v in ipairs(s) do if v > n then n = v end end; return n end)(v1)
                        local v100 = v96 > 0
                        local getv104 = function()
                            if v100 then
                                local v101 = v97
                                local v102 = v96
                                local v103 = v101 / v102
                                return v103
                            else
                                return 0.0
                            end
                        end
                        local v104 = getv104()
                        local v105 = format_real_1(v96)
                        local v106 = "taken: count "
                        local v107 = v106 .. v105 
                        local v108 = " mean "
                        local v109 = v107 .. v108 
                        local v110 = string.format("%." .. 2 .. "f", v104)
                        local v111 = v109 .. v110 
                        local v112 = v111 .. v71 
                        local v113 = format_real_1(v98)
                        local v114 = v112 .. v113 
                        local v115 = " max "
                        local v116 = v114 .. v115 
                        local v117 = format_real_1(v99)
                        local v118 = v116 .. v117 
                        local v119 = v118 .. v75 
                        local v120 = format_real_1(v97)
                        local v121 = v119 .. v120 
                        local v122 = v31 .. v121 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v122)
                        g_logger.info(v122)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v123 = table.concat(v1, ",")
                        local v124 = "taken "
                        local v125 = v124 .. v123 
                        local v126 = v31 .. v125 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v126)
                        g_logger.info(v126)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    else
                    end
                    local v127 = closure9({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 })
                    scheduleEvent(v127, 500)
                    local v128 = "server text ["
                    local v129 = v128 .. v10 
                    local v130 = "]: "
                    local v131 = v129 .. v130 
                    local v132 = v131 .. v11 
                    local v133 = "[tibia-probe] "
                    local v134 = v133 .. v132 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v134)
                    g_logger.info(v134)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    return nil
                else
                    local v135 = "You lose"
                    local v136 = string.find(v11, v135, 1, true) ~= nil 
                    local v137 = v136 == false
                    if v137 then
                        local v138 = "server text ["
                        local v139 = v138 .. v10 
                        local v140 = "]: "
                        local v141 = v139 .. v140 
                        local v142 = v141 .. v11 
                        local v143 = "[tibia-probe] "
                        local v144 = v143 .. v142 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v144)
                        g_logger.info(v144)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        return nil
                    else
                    end
                end
            end
        end
    end
end

function on_text_c7(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 = (table.unpack or unpack)(capt)
    return function(v10)
        return closure8({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 })
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22)
    end
end

function poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22)
    local v23 = v0 == ""
    local getv27 = function()
        if v23 then
            return true
        else
            local v24 = "/"
            local v25 = v24 .. v0 
            local v26 = g_resources.fileExists(v25)
            return v26
        end
    end
    local v27 = getv27()
    if v27 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v28 = ready_c2({ v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 })
        local v29 = closure6(nil)
        local v30 = on_text_c7({ v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 })
        connect(g_game, { onGameStart = v28, onLoginError = function(message) (v29)(tostring(message)) end, onTextMessage = function(mode, text) (v30)(tostring(mode))(tostring(text)) end })
        local v31 = "@god"
        local v32 = "@god\ngod"
        g_game.loginWorld(v31, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v32)
        return nil
    else
        local v33 = closure10({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 })
        scheduleEvent(v33, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 = (table.unpack or unpack)(capt)
    return function(dom)
        local v22 = "TIBIA_LOGIN_GATE"
        local v23 = ""
        local v24 = os.getenv(v22) or (v23)
        return poll_0(v24, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21)
    end
end

function closure11(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 = (table.unpack or unpack)(capt)
    return function(dom)
        local v10 = (v9).value
        local v11 = v10 == 0
        if v11 then
            do (v9).value = (1) end
            local v12 = "finish: "
            local v13 = "timeout"
            local v14 = v12 .. v13 
            local v15 = "[tibia-probe] "
            local v16 = v15 .. v14 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v16)
            g_logger.info(v16)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v17 = g_game.isOnline()
            if v17 then
                g_game.safeLogout()
            else
            end
            local v18 = closure4(nil)
            scheduleEvent(v18, 2000)
            return nil
        else
        end
    end
end

local v0 = {}
local v1 = {}
local v2 = { value = 0 }
local v3 = { value = 0 }
local v4 = { value = 0 }
local v5 = { value = 0 }
local v6 = {}
local v7 = { value = 0 }
local v8 = { value = 0 }
local v9 = { value = 0 }
local v10 = "TIBIA_MEASURE_POTION_BELOW"
local v11 = tonumber(os.getenv(v10) or "") or (90)
local v12 = "TIBIA_ARENA_CHARACTER"
local v13 = "Knight Sample"
local v14 = os.getenv(v12) or (v13)
local v15 = "TIBIA_PROBE_HIDDEN"
local v16 = "1"
local v17 = os.getenv(v15) == (v16)
if v17 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v18 = closure0(nil)
scheduleEvent(v18, 200)
scheduleEvent(v18, 1000)
local v19 = closure1({ v14, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v11 })
scheduleEvent(v19, 3000)
local v20 = closure11({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 })
scheduleEvent(v20, 260000)
return 0
