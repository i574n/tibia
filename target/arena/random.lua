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
local Mut0, Us0_Drink, Us0_Engage, Us0_StepSomewhere, Us0_Stand, closure0, format_real_1, closure5, scan_3, closure6, go_2, closure4, closure3, ready_c2, closure7, closure9, on_text_c8, closure10, poll_0, closure1, closure11
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

function Us0_Drink() return { tag = "Us0_Drink" } end
function Us0_Engage() return { tag = "Us0_Engage" } end
function Us0_StepSomewhere() return { tag = "Us0_StepSomewhere" } end
function Us0_Stand() return { tag = "Us0_Stand" } end

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

function closure5(capt)
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

function closure6(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_2(v0, v1, v2, v3, v5, v6, v7, v8, v9, v10, v11, v12, v13, v4)
    end
end

function go_2(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13)
    local v14 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
    local v15 = v14 == false
    if v15 then
        local v16 = ArenaParity and ArenaParity.summary() or ""
        local v17 = v16 ~= ""
        if v17 then
            local v18 = "[tibia-probe] "
            local v19 = v18 .. v16 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v19)
            g_logger.info(v19)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        else
        end
        local v20 = "finish: "
        local v21 = "offline"
        local v22 = v20 .. v21 
        local v23 = "[tibia-probe] "
        local v24 = v23 .. v22 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v24)
        g_logger.info(v24)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v25 = g_game.isOnline()
        if v25 then
            g_game.safeLogout()
        else
        end
        local v26 = closure5(nil)
        scheduleEvent(v26, 2000)
        return nil
    else
        local v27 = g_clock.millis()
        local v28 = g_game.getLocalPlayer():getHealth()
        local v29 = spiral_wrap_signed((v4 + 1), 32)
        local v30 = v28 < v12
        local getv31 = function()
            if v30 then
                return v28
            else
                return v12
            end
        end
        local v31 = getv31()
        local v32 = v28 <= 0
        if v32 then
            local v33 = g_game.getLocalPlayer():getHealth()
            local v34 = g_game.getLocalPlayer():getExperience()
            local v35 = spiral_wrap_signed((v34 - v0), 32)
            local v36 = format_real_1(v29)
            local v37 = "ticks "
            local v38 = v37 .. v36 
            local v39 = " heals "
            local v40 = v38 .. v39 
            local v41 = format_real_1(v5)
            local v42 = v40 .. v41 
            local v43 = " strikes "
            local v44 = v42 .. v43 
            local v45 = format_real_1(v6)
            local v46 = v44 .. v45 
            local v47 = " holds "
            local v48 = v46 .. v47 
            local v49 = format_real_1(v7)
            local v50 = v48 .. v49 
            local v51 = " retreats "
            local v52 = v50 .. v51 
            local v53 = format_real_1(v9)
            local v54 = v52 .. v53 
            local v55 = " cornered "
            local v56 = v54 .. v55 
            local v57 = format_real_1(v10)
            local v58 = v56 .. v57 
            local v59 = " gated "
            local v60 = v58 .. v59 
            local v61 = format_real_1(v11)
            local v62 = v60 .. v61 
            local v63 = " kills "
            local v64 = v62 .. v63 
            local v65 = format_real_1(v8)
            local v66 = v64 .. v65 
            local v67 = " health "
            local v68 = v66 .. v67 
            local v69 = format_real_1(v33)
            local v70 = v68 .. v69 
            local v71 = " lowest "
            local v72 = v70 .. v71 
            local v73 = format_real_1(v31)
            local v74 = v72 .. v73 
            local v75 = " experience +"
            local v76 = v74 .. v75 
            local v77 = format_real_1(v35)
            local v78 = v76 .. v77 
            local v79 = "dead: "
            local v80 = v79 .. v78 
            local v81 = "[tibia-probe] "
            local v82 = v81 .. v80 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v82)
            g_logger.info(v82)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v83 = ArenaParity and ArenaParity.summary() or ""
            local v84 = v83 ~= ""
            if v84 then
                local v85 = v81 .. v83 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v85)
                g_logger.info(v85)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v86 = "finish: "
            local v87 = "death"
            local v88 = v86 .. v87 
            local v89 = v81 .. v88 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v89)
            g_logger.info(v89)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v90 = g_game.isOnline()
            if v90 then
                g_game.safeLogout()
            else
            end
            local v91 = closure5(nil)
            scheduleEvent(v91, 2000)
            return nil
        else
            local v92 = (function(t) local n = 0; for id, c in pairs(t) do if c:isDead() then n = n + 1; t[id] = nil end end; return n end)(v3)
            local v93 = spiral_wrap_signed((v8 + v92), 32)
            local v94 = math.random(0, 3)
            local v95 = v94 == 0
            local getv104 = function()
                if v95 then
                    return Us0_Drink()
                else
                    local v97 = v94 == 1
                    if v97 then
                        return Us0_Engage()
                    else
                        local v99 = v94 == 2
                        if v99 then
                            return Us0_StepSomewhere()
                        else
                            return Us0_Stand()
                        end
                    end
                end
            end
            local v104 = getv104()
            local getv289 = function()
                local __v = { v104 }
                if __v[1] ~= nil and __v[1].tag == "Us0_Drink" then
                    local v105 = g_clock.millis()
                    local v106 = (v1).value
                    local v107 = spiral_wrap_signed((v105 - v106), 32)
                    local v108 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                    if v108 then
                        local v109 = format_real_1(v28)
                        local v110 = "heal (potion) at health "
                        local v111 = v110 .. v109 
                        local v112 = " t="
                        local v113 = v111 .. v112 
                        local v114 = format_real_1(v107)
                        local v115 = v113 .. v114 
                        local v116 = "[tibia-probe] "
                        local v117 = v116 .. v115 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v117)
                        g_logger.info(v117)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v118 = spiral_wrap_signed((v5 + 1), 32)
                        return { [1]=v29, [2]=v118, [3]=v6, [4]=v7, [5]=v93, [6]=v9, [7]=v10, [8]=v11, [9]=v31, [10]=v13 }
                    else
                        local v119 = format_real_1(v28)
                        local v120 = "heal dropped by the action gate at health "
                        local v121 = v120 .. v119 
                        local v122 = "[tibia-probe] "
                        local v123 = v122 .. v121 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v123)
                        g_logger.info(v123)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        return { [1]=v29, [2]=v5, [3]=v6, [4]=v7, [5]=v93, [6]=v9, [7]=v10, [8]=v11, [9]=v31, [10]=v13 }
                    end
                elseif __v[1] ~= nil and __v[1].tag == "Us0_Engage" then
                    local v134 = g_game.getLocalPlayer():getPosition()
                    local v135 = v134.x
                    local v136 = v134.y
                    local v137 = v134.z
                    local v138 = g_map.getSpectators({ x = v135, y = v136, z = v137 }, false)
                    local v139 = #(v138)
                    local v140 = 1
                    local v141 = false
                    local v142 = 0
                    local v143 = 999
                    local v144, v145, v146 = (table.unpack or unpack)(scan_3(v135, v136, v137, v138, v139, v140, v141, v142, v143))
                    if v144 then
                        do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((true) and ChaseOpponent or DontChase) end
                        local v147 = (v138)[v145]
                        local v148 = g_game.getAttackingCreature()
                        local v149 = (v148) == (v147)
                        local v150 = v149 == false
                        if v150 then
                            g_game.attack(v147)
                            do (v3)[(v147):getId()] = (v147) end
                            local v151 = (v147):getName()
                            local v152 = (v147):getPosition()
                            local v153 = v152.x
                            local v154 = v152.y
                            local v155 = v152.z
                            local v156 = format_real_1(v153)
                            local v157 = ""
                            local v158 = v157 .. v156 
                            local v159 = ","
                            local v160 = v158 .. v159 
                            local v161 = format_real_1(v154)
                            local v162 = v160 .. v161 
                            local v163 = v162 .. v159 
                            local v164 = format_real_1(v155)
                            local v165 = v163 .. v164 
                            local v166 = format_real_1(v135)
                            local v167 = v157 .. v166 
                            local v168 = v167 .. v159 
                            local v169 = format_real_1(v136)
                            local v170 = v168 .. v169 
                            local v171 = v170 .. v159 
                            local v172 = format_real_1(v137)
                            local v173 = v171 .. v172 
                            local v174 = "strike "
                            local v175 = v174 .. v151 
                            local v176 = " at "
                            local v177 = v175 .. v176 
                            local v178 = v177 .. v165 
                            local v179 = " from "
                            local v180 = v178 .. v179 
                            local v181 = v180 .. v173 
                            local v182 = " health "
                            local v183 = v181 .. v182 
                            local v184 = format_real_1(v28)
                            local v185 = v183 .. v184 
                            local v186 = "[tibia-probe] "
                            local v187 = v186 .. v185 
                            TibiaProbeLog = TibiaProbeLog or {}
                            table.insert(TibiaProbeLog, v187)
                            g_logger.info(v187)
                            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        else
                        end
                        local v188 = spiral_wrap_signed((v6 + 1), 32)
                        return { [1]=v29, [2]=v5, [3]=v188, [4]=v7, [5]=v93, [6]=v9, [7]=v10, [8]=v11, [9]=v31, [10]=v13 }
                    else
                        return { [1]=v29, [2]=v5, [3]=v6, [4]=v7, [5]=v93, [6]=v9, [7]=v10, [8]=v11, [9]=v31, [10]=v13 }
                    end
                elseif __v[1] ~= nil and __v[1].tag == "Us0_Stand" then
                    local v258 = spiral_wrap_signed((v7 + 1), 32)
                    return { [1]=v29, [2]=v5, [3]=v6, [4]=v258, [5]=v93, [6]=v9, [7]=v10, [8]=v11, [9]=v31, [10]=v13 }
                elseif __v[1] ~= nil and __v[1].tag == "Us0_StepSomewhere" then
                    local v199 = v27 >= v13
                    local getv202 = function()
                        if v199 then
                            local v200 = g_game.getLocalPlayer():isWalking()
                            local v201 = v200 == false
                            return v201
                        else
                            return false
                        end
                    end
                    local v202 = getv202()
                    if v202 then
                        local v203 = math.random(1, 8)
                        local v204 = v203 == 1
                        local getv229 = function()
                            if v204 then
                                return { [1]=0, [2]=-1, [3]=false }
                            else
                                local v205 = v203 == 2
                                local getv226 = function()
                                    if v205 then
                                        return { [1]=1, [2]=0, [3]=false }
                                    else
                                        local v206 = v203 == 3
                                        local getv223 = function()
                                            if v206 then
                                                return { [1]=0, [2]=1, [3]=false }
                                            else
                                                local v207 = v203 == 4
                                                local getv220 = function()
                                                    if v207 then
                                                        return { [1]=-1, [2]=0, [3]=false }
                                                    else
                                                        local v208 = v203 == 5
                                                        local getv217 = function()
                                                            if v208 then
                                                                return { [1]=1, [2]=-1, [3]=true }
                                                            else
                                                                local v209 = v203 == 6
                                                                local getv214 = function()
                                                                    if v209 then
                                                                        return { [1]=1, [2]=1, [3]=true }
                                                                    else
                                                                        local v210 = v203 == 7
                                                                        local getv211 = function()
                                                                            if v210 then
                                                                                return { [1]=-1, [2]=1, [3]=true }
                                                                            else
                                                                                return { [1]=-1, [2]=-1, [3]=true }
                                                                            end
                                                                        end
                                                                        local v211, v212, v213 = (table.unpack or unpack)(getv211())
                                                                        return { [1]=v211, [2]=v212, [3]=v213 }
                                                                    end
                                                                end
                                                                local v214, v215, v216 = (table.unpack or unpack)(getv214())
                                                                return { [1]=v214, [2]=v215, [3]=v216 }
                                                            end
                                                        end
                                                        local v217, v218, v219 = (table.unpack or unpack)(getv217())
                                                        return { [1]=v217, [2]=v218, [3]=v219 }
                                                    end
                                                end
                                                local v220, v221, v222 = (table.unpack or unpack)(getv220())
                                                return { [1]=v220, [2]=v221, [3]=v222 }
                                            end
                                        end
                                        local v223, v224, v225 = (table.unpack or unpack)(getv223())
                                        return { [1]=v223, [2]=v224, [3]=v225 }
                                    end
                                end
                                local v226, v227, v228 = (table.unpack or unpack)(getv226())
                                return { [1]=v226, [2]=v227, [3]=v228 }
                            end
                        end
                        local v229, v230, v231 = (table.unpack or unpack)(getv229())
                        local v232 = g_game.walk(({ ["0,-1"] = North, ["1,0"] = East, ["0,1"] = South, ["-1,0"] = West, ["1,-1"] = NorthEast, ["1,1"] = SouthEast, ["-1,1"] = SouthWest, ["-1,-1"] = NorthWest })[(v229) .. "," .. (v230)]) ~= false
                        if v232 then
                            local v233 = spiral_wrap_signed((v9 + 1), 32)
                            local getv234 = function()
                                if v231 then
                                    return 3
                                else
                                    return 1
                                end
                            end
                            local v234 = getv234()
                            local v235 = spiral_wrap_signed(spiral_mul_mod32(650, v234), 32)
                            local v236 = spiral_wrap_signed((v27 + v235), 32)
                            return { [1]=v29, [2]=v5, [3]=v6, [4]=v7, [5]=v93, [6]=v233, [7]=v10, [8]=v11, [9]=v31, [10]=v236 }
                        else
                            local v237 = spiral_wrap_signed((v11 + 1), 32)
                            return { [1]=v29, [2]=v5, [3]=v6, [4]=v7, [5]=v93, [6]=v9, [7]=v10, [8]=v237, [9]=v31, [10]=v13 }
                        end
                    else
                        return { [1]=v29, [2]=v5, [3]=v6, [4]=v7, [5]=v93, [6]=v9, [7]=v10, [8]=v11, [9]=v31, [10]=v13 }
                    end
                end
            end
            local v289, v290, v291, v292, v293, v294, v295, v296, v297, v298 = (table.unpack or unpack)(getv289())
            local v299 = math.fmod(v289, 100)
            local v300 = v299 == 0
            if v300 then
                local v301 = g_game.getLocalPlayer():getPosition()
                local v302 = v301.x
                local v303 = v301.y
                local v304 = v301.z
                local v305 = format_real_1(v302)
                local v306 = ""
                local v307 = v306 .. v305 
                local v308 = ","
                local v309 = v307 .. v308 
                local v310 = format_real_1(v303)
                local v311 = v309 .. v310 
                local v312 = v311 .. v308 
                local v313 = format_real_1(v304)
                local v314 = v312 .. v313 
                local v315 = g_game.getLocalPlayer():getHealth()
                local v316 = g_game.getLocalPlayer():getExperience()
                local v317 = spiral_wrap_signed((v316 - v0), 32)
                local v318 = format_real_1(v289)
                local v319 = "ticks "
                local v320 = v319 .. v318 
                local v321 = " heals "
                local v322 = v320 .. v321 
                local v323 = format_real_1(v290)
                local v324 = v322 .. v323 
                local v325 = " strikes "
                local v326 = v324 .. v325 
                local v327 = format_real_1(v291)
                local v328 = v326 .. v327 
                local v329 = " holds "
                local v330 = v328 .. v329 
                local v331 = format_real_1(v292)
                local v332 = v330 .. v331 
                local v333 = " retreats "
                local v334 = v332 .. v333 
                local v335 = format_real_1(v294)
                local v336 = v334 .. v335 
                local v337 = " cornered "
                local v338 = v336 .. v337 
                local v339 = format_real_1(v295)
                local v340 = v338 .. v339 
                local v341 = " gated "
                local v342 = v340 .. v341 
                local v343 = format_real_1(v296)
                local v344 = v342 .. v343 
                local v345 = " kills "
                local v346 = v344 .. v345 
                local v347 = format_real_1(v293)
                local v348 = v346 .. v347 
                local v349 = " health "
                local v350 = v348 .. v349 
                local v351 = format_real_1(v315)
                local v352 = v350 .. v351 
                local v353 = " lowest "
                local v354 = v352 .. v353 
                local v355 = format_real_1(v297)
                local v356 = v354 .. v355 
                local v357 = " experience +"
                local v358 = v356 .. v357 
                local v359 = format_real_1(v317)
                local v360 = v358 .. v359 
                local v361 = " player at "
                local v362 = v361 .. v314 
                local v363 = v360 .. v362 
                local v364 = "[tibia-probe] "
                local v365 = v364 .. v363 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v365)
                g_logger.info(v365)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v366 = g_clock.millis()
            local v367 = (v1).value
            local v368 = spiral_wrap_signed((v366 - v367), 32)
            local v369 = "TIBIA_ARENA_RUN_MS"
            local v370 = tonumber(os.getenv(v369) or "") or (150000)
            local v371 = v368 > v370
            if v371 then
                local v372 = g_game.getLocalPlayer():getHealth()
                local v373 = g_game.getLocalPlayer():getExperience()
                local v374 = spiral_wrap_signed((v373 - v0), 32)
                local v375 = format_real_1(v289)
                local v376 = "ticks "
                local v377 = v376 .. v375 
                local v378 = " heals "
                local v379 = v377 .. v378 
                local v380 = format_real_1(v290)
                local v381 = v379 .. v380 
                local v382 = " strikes "
                local v383 = v381 .. v382 
                local v384 = format_real_1(v291)
                local v385 = v383 .. v384 
                local v386 = " holds "
                local v387 = v385 .. v386 
                local v388 = format_real_1(v292)
                local v389 = v387 .. v388 
                local v390 = " retreats "
                local v391 = v389 .. v390 
                local v392 = format_real_1(v294)
                local v393 = v391 .. v392 
                local v394 = " cornered "
                local v395 = v393 .. v394 
                local v396 = format_real_1(v295)
                local v397 = v395 .. v396 
                local v398 = " gated "
                local v399 = v397 .. v398 
                local v400 = format_real_1(v296)
                local v401 = v399 .. v400 
                local v402 = " kills "
                local v403 = v401 .. v402 
                local v404 = format_real_1(v293)
                local v405 = v403 .. v404 
                local v406 = " health "
                local v407 = v405 .. v406 
                local v408 = format_real_1(v372)
                local v409 = v407 .. v408 
                local v410 = " lowest "
                local v411 = v409 .. v410 
                local v412 = format_real_1(v297)
                local v413 = v411 .. v412 
                local v414 = " experience +"
                local v415 = v413 .. v414 
                local v416 = format_real_1(v374)
                local v417 = v415 .. v416 
                local v418 = "end: "
                local v419 = v418 .. v417 
                local v420 = "[tibia-probe] "
                local v421 = v420 .. v419 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v421)
                g_logger.info(v421)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v422 = ArenaParity and ArenaParity.summary() or ""
                local v423 = v422 ~= ""
                if v423 then
                    local v424 = v420 .. v422 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v424)
                    g_logger.info(v424)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v425 = "finish: "
                local v426 = "run complete"
                local v427 = v425 .. v426 
                local v428 = v420 .. v427 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v428)
                g_logger.info(v428)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v429 = g_game.isOnline()
                if v429 then
                    g_game.safeLogout()
                else
                end
                local v430 = closure5(nil)
                scheduleEvent(v430, 2000)
                return nil
            else
                local v431 = g_game.getLocalPlayer():getExperience()
                local v432 = spiral_wrap_signed((v431 - v0), 32)
                local v433 = v432 >= v2
                if v433 then
                    local v434 = g_clock.millis()
                    local v435 = (v1).value
                    local v436 = spiral_wrap_signed((v434 - v435), 32)
                    local v437 = format_real_1(v436)
                    local v438 = "cleared at "
                    local v439 = v438 .. v437 
                    local v440 = " ms"
                    local v441 = v439 .. v440 
                    local v442 = "[tibia-probe] "
                    local v443 = v442 .. v441 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v443)
                    g_logger.info(v443)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v444 = g_game.getLocalPlayer():getHealth()
                    local v445 = g_game.getLocalPlayer():getExperience()
                    local v446 = spiral_wrap_signed((v445 - v0), 32)
                    local v447 = format_real_1(v289)
                    local v448 = "ticks "
                    local v449 = v448 .. v447 
                    local v450 = " heals "
                    local v451 = v449 .. v450 
                    local v452 = format_real_1(v290)
                    local v453 = v451 .. v452 
                    local v454 = " strikes "
                    local v455 = v453 .. v454 
                    local v456 = format_real_1(v291)
                    local v457 = v455 .. v456 
                    local v458 = " holds "
                    local v459 = v457 .. v458 
                    local v460 = format_real_1(v292)
                    local v461 = v459 .. v460 
                    local v462 = " retreats "
                    local v463 = v461 .. v462 
                    local v464 = format_real_1(v294)
                    local v465 = v463 .. v464 
                    local v466 = " cornered "
                    local v467 = v465 .. v466 
                    local v468 = format_real_1(v295)
                    local v469 = v467 .. v468 
                    local v470 = " gated "
                    local v471 = v469 .. v470 
                    local v472 = format_real_1(v296)
                    local v473 = v471 .. v472 
                    local v474 = " kills "
                    local v475 = v473 .. v474 
                    local v476 = format_real_1(v293)
                    local v477 = v475 .. v476 
                    local v478 = " health "
                    local v479 = v477 .. v478 
                    local v480 = format_real_1(v444)
                    local v481 = v479 .. v480 
                    local v482 = " lowest "
                    local v483 = v481 .. v482 
                    local v484 = format_real_1(v297)
                    local v485 = v483 .. v484 
                    local v486 = " experience +"
                    local v487 = v485 .. v486 
                    local v488 = format_real_1(v446)
                    local v489 = v487 .. v488 
                    local v490 = "cleared: "
                    local v491 = v490 .. v489 
                    local v492 = v442 .. v491 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v492)
                    g_logger.info(v492)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v493 = ArenaParity and ArenaParity.summary() or ""
                    local v494 = v493 ~= ""
                    if v494 then
                        local v495 = v442 .. v493 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v495)
                        g_logger.info(v495)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    else
                    end
                    local v496 = "finish: "
                    local v497 = "cleared"
                    local v498 = v496 .. v497 
                    local v499 = v442 .. v498 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v499)
                    g_logger.info(v499)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v500 = g_game.isOnline()
                    if v500 then
                        g_game.safeLogout()
                    else
                    end
                    local v501 = closure5(nil)
                    scheduleEvent(v501, 2000)
                    return nil
                else
                    local v502 = closure6({ v0, v1, v2, v3, v298, v289, v290, v291, v292, v293, v294, v295, v296, v297 })
                    scheduleEvent(v502, 100)
                    return nil
                end
            end
        end
    end
end

function closure4(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = g_game.getLocalPlayer():getPosition()
        local v4 = v3.x
        local v5 = v3.y
        local v6 = v3.z
        local v7 = format_real_1(v4)
        local v8 = ""
        local v9 = v8 .. v7 
        local v10 = ","
        local v11 = v9 .. v10 
        local v12 = format_real_1(v5)
        local v13 = v11 .. v12 
        local v14 = v13 .. v10 
        local v15 = format_real_1(v6)
        local v16 = v14 .. v15 
        local v17 = "random control starts at "
        local v18 = v17 .. v16 
        local v19 = " (drink, engage, random step or stand, equal odds every "
        local v20 = v18 .. v19 
        local v21 = 100
        local v22 = format_real_1(v21)
        local v23 = v20 .. v22 
        local v24 = " ms)"
        local v25 = v23 .. v24 
        local v26 = "[tibia-probe] "
        local v27 = v26 .. v25 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v27)
        g_logger.info(v27)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v28 = g_clock.millis()
        do (v0).value = (v28) end
        local v29 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v30 = tonumber(os.getenv(v29) or "") or (90)
        local v31 = 0
        local v32 = 0
        local v33 = 0
        local v34 = 0
        local v35 = 0
        local v36 = 0
        local v37 = 0
        local v38 = 0
        local v39 = 999
        local v40 = 0
        return go_2(v2, v0, v30, v1, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40)
    end
end

function closure3(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getExperience()
        do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((false) and ChaseOpponent or DontChase) end
        g_game.setFightMode(FightBalanced)
        local v3 = closure4({ v0, v1, v2 })
        scheduleEvent(v3, 1000)
        return nil
    end
end

function ready_c2(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getName()
        local v3 = g_game.getLocalPlayer():getHealth()
        local v4 = g_game.getLocalPlayer():getMana()
        local v5 = "in game as "
        local v6 = v5 .. v2 
        local v7 = " health "
        local v8 = v6 .. v7 
        local v9 = format_real_1(v3)
        local v10 = v8 .. v9 
        local v11 = " mana "
        local v12 = v10 .. v11 
        local v13 = format_real_1(v4)
        local v14 = v12 .. v13 
        local v15 = "[tibia-probe] "
        local v16 = v15 .. v14 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v16)
        g_logger.info(v16)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v17 = closure3({ v0, v1 })
        scheduleEvent(v17, 1500)
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
        local v10 = closure5(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure9(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(v2)
        local v3 = g_clock.millis()
        local v4 = (v0).value
        local v5 = spiral_wrap_signed((v3 - v4), 32)
        local v6 = "server text ["
        local v7 = v6 .. v1 
        local v8 = "] t="
        local v9 = v7 .. v8 
        local v10 = format_real_1(v5)
        local v11 = v9 .. v10 
        local v12 = ": "
        local v13 = v11 .. v12 
        local v14 = v13 .. v2 
        local v15 = "[tibia-probe] "
        local v16 = v15 .. v14 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v16)
        g_logger.info(v16)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        return nil
    end
end

function on_text_c8(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        return closure9({ v0, v1 })
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2, v3, v4)
    end
end

function poll_0(v0, v1, v2, v3, v4)
    local v5 = v0 == ""
    local getv9 = function()
        if v5 then
            return true
        else
            local v6 = "/"
            local v7 = v6 .. v0 
            local v8 = g_resources.fileExists(v7)
            return v8
        end
    end
    local v9 = getv9()
    if v9 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v10 = ready_c2({ v3, v4 })
        local v11 = closure7(nil)
        local v12 = on_text_c8({ v2 })
        connect(g_game, { onGameStart = v10, onLoginError = function(message) (v11)(tostring(message)) end, onTextMessage = function(mode, text) (v12)(tostring(mode))(tostring(text)) end })
        local v13 = "@god"
        local v14 = "@god\ngod"
        g_game.loginWorld(v13, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v14)
        return nil
    else
        local v15 = closure10({ v0, v1, v2, v3, v4 })
        scheduleEvent(v15, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        local v4 = "TIBIA_LOGIN_GATE"
        local v5 = ""
        local v6 = os.getenv(v4) or (v5)
        return poll_0(v6, v0, v1, v2, v3)
    end
end

function closure11(capt)
    return function(dom)
        local v0 = ArenaParity and ArenaParity.summary() or ""
        local v1 = v0 ~= ""
        if v1 then
            local v2 = "[tibia-probe] "
            local v3 = v2 .. v0 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v3)
            g_logger.info(v3)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        else
        end
        local v4 = "finish: "
        local v5 = "timeout"
        local v6 = v4 .. v5 
        local v7 = "[tibia-probe] "
        local v8 = v7 .. v6 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v8)
        g_logger.info(v8)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v9 = g_game.isOnline()
        if v9 then
            g_game.safeLogout()
        else
        end
        local v10 = closure5(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

math.randomseed(os.time())
local v0 = { value = 0 }
local v1 = {}
local v2 = "TIBIA_ARENA_CHARACTER"
local v3 = "Knight Sample"
local v4 = os.getenv(v2) or (v3)
local v5 = "_1511"
local v6 = v4 .. v5 
do (function(key) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = false }; g_settings.setNode("bot", s); g_settings.save() end)(v6) end
local v7 = os.getenv(v2) or (v3)
local v8 = "TIBIA_PROBE_HIDDEN"
local v9 = "1"
local v10 = os.getenv(v8) == (v9)
if v10 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v11 = closure0(nil)
scheduleEvent(v11, 200)
scheduleEvent(v11, 1000)
local v12 = closure1({ v7, v0, v0, v1 })
scheduleEvent(v12, 3000)
local v13 = closure11(nil)
scheduleEvent(v13, 200000)
return 0
