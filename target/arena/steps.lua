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
local Mut0, format_real_0, closure2, closure1, closure0, closure3, scan_3, closure7, go_2, closure6, closure9, closure10, go_4, closure8, closure12, closure11, ready_c5, closure13, closure15, on_text_c14, closure16, poll_1, closure4, closure17
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

function format_real_0(v0)
    local v1 = ""
    local v2 = { __tag = "Mut0", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure2(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(v5)
        local v6 = (v4) ~= nil
        local getv8 = function()
            if v6 then
                local v7 = (v5) ~= nil
                return v7
            else
                return false
            end
        end
        local v8 = getv8()
        if v8 then
            local v9 = (v3):isLocalPlayer()
            local v10 = (v3):isMonster()
            local v11 = (v10) or (v9)
            if v11 then
                local v12 = v4.x
                local v13 = v4.y
                local v14 = v4.z
                local v15 = v5.x
                local v16 = v5.y
                local v17 = v5.z
                local v18 = v12 > v15
                local getv21 = function()
                    if v18 then
                        local v19 = spiral_wrap_signed((v12 - v15), 32)
                        return v19
                    else
                        local v20 = spiral_wrap_signed((v15 - v12), 32)
                        return v20
                    end
                end
                local v21 = getv21()
                local v22 = v13 > v16
                local getv25 = function()
                    if v22 then
                        local v23 = spiral_wrap_signed((v13 - v16), 32)
                        return v23
                    else
                        local v24 = spiral_wrap_signed((v16 - v13), 32)
                        return v24
                    end
                end
                local v25 = getv25()
                local v26 = v14 == v17
                local getv29 = function()
                    if v26 then
                        local v27 = spiral_wrap_signed((v21 + v25), 32)
                        local v28 = v27 ~= 0
                        return v28
                    else
                        return false
                    end
                end
                local v29 = getv29()
                local getv31 = function()
                    if v29 then
                        local v30 = v21 <= 1
                        return v30
                    else
                        return false
                    end
                end
                local v31 = getv31()
                local getv33 = function()
                    if v31 then
                        local v32 = v25 <= 1
                        return v32
                    else
                        return false
                    end
                end
                local v33 = getv33()
                if v33 then
                    local v34 = g_clock.millis()
                    local v35 = (v3):getId()
                    local v36 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
                    local getv52 = function()
                        if v36 then
                            local v37 = g_game.getLocalPlayer():getPosition()
                            local v38 = v37.x
                            local v39 = v37.y
                            local v40 = v37.z
                            local v41 = v12 > v38
                            local getv44 = function()
                                if v41 then
                                    local v42 = spiral_wrap_signed((v12 - v38), 32)
                                    return v42
                                else
                                    local v43 = spiral_wrap_signed((v38 - v12), 32)
                                    return v43
                                end
                            end
                            local v44 = getv44()
                            local v45 = v13 > v39
                            local getv48 = function()
                                if v45 then
                                    local v46 = spiral_wrap_signed((v13 - v39), 32)
                                    return v46
                                else
                                    local v47 = spiral_wrap_signed((v39 - v13), 32)
                                    return v47
                                end
                            end
                            local v48 = getv48()
                            local v49 = v44 > v48
                            local getv50 = function()
                                if v49 then
                                    return v44
                                else
                                    return v48
                                end
                            end
                            local v50 = getv50()
                            local v51 = v50 <= 1
                            return v51
                        else
                            return false
                        end
                    end
                    local v52 = getv52()
                    local v53 = v21 == 1
                    local getv55 = function()
                        if v53 then
                            local v54 = v25 == 1
                            return v54
                        else
                            return false
                        end
                    end
                    local v55 = getv55()
                    local getv58 = function()
                        if v9 then
                            local v56 = "knight-"
                            return v56
                        else
                            local v57 = ""
                            return v57
                        end
                    end
                    local v58 = getv58()
                    local getv61 = function()
                        if v55 then
                            local v59 = "diagonal"
                            return v59
                        else
                            local v60 = "straight"
                            return v60
                        end
                    end
                    local v61 = getv61()
                    local v62 = v58 .. v61 
                    local getv64 = function()
                        if v0 then
                            local v63 = v9 == false
                            return v63
                        else
                            return false
                        end
                    end
                    local v64 = getv64()
                    local getv69 = function()
                        if v64 then
                            local getv67 = function()
                                if v52 then
                                    local v65 = "-adjacent"
                                    return v65
                                else
                                    local v66 = "-chasing"
                                    return v66
                                end
                            end
                            local v67 = getv67()
                            local v68 = v62 .. v67 
                            return v68
                        else
                            return v62
                        end
                    end
                    local v69 = getv69()
                    local v70 = (function(s, id) local p = s[id]; return p and p.at or -1 end)(v1, v35)
                    local v71 = (function(s, id) local p = s[id]; return p and p.kind or "" end)(v1, v35)
                    do (v1)[v35] = { at = v34, kind = v69 } end
                    local v72 = v70 >= 0
                    if v72 then
                        local v73 = spiral_wrap_signed((v34 - v70), 32)
                        do (function(s, label, value) s[label] = s[label] or {}; table.insert(s[label], value) end)(v2, v71, v73) end
                        local v74 = (v3):getName()
                        local v75 = format_real_0(v15)
                        local v76 = ""
                        local v77 = v76 .. v75 
                        local v78 = ","
                        local v79 = v77 .. v78 
                        local v80 = format_real_0(v16)
                        local v81 = v79 .. v80 
                        local v82 = v81 .. v78 
                        local v83 = format_real_0(v17)
                        local v84 = v82 .. v83 
                        local v85 = format_real_0(v12)
                        local v86 = v76 .. v85 
                        local v87 = v86 .. v78 
                        local v88 = format_real_0(v13)
                        local v89 = v87 .. v88 
                        local v90 = v89 .. v78 
                        local v91 = format_real_0(v14)
                        local v92 = v90 .. v91 
                        local v93 = " "
                        local v94 = v74 .. v93 
                        local v95 = format_real_0(v35)
                        local v96 = v94 .. v95 
                        local v97 = v96 .. v93 
                        local v98 = v97 .. v69 
                        local v99 = " step "
                        local v100 = v98 .. v99 
                        local v101 = v100 .. v84 
                        local v102 = " -> "
                        local v103 = v101 .. v102 
                        local v104 = v103 .. v92 
                        local v105 = "; interval after its "
                        local v106 = v104 .. v105 
                        local v107 = v106 .. v71 
                        local v108 = v107 .. v99 
                        local v109 = format_real_0(v73)
                        local v110 = v108 .. v109 
                        local v111 = " ms"
                        local v112 = v110 .. v111 
                        local v113 = "[tibia-probe] "
                        local v114 = v113 .. v112 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v114)
                        g_logger.info(v114)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        return nil
                    else
                    end
                else
                end
            else
            end
        else
        end
    end
end

function closure1(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(v4)
        return closure2({ v0, v1, v2, v3, v4 })
    end
end

function closure0(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        return closure1({ v0, v1, v2, v3 })
    end
end

function closure3(capt)
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

function closure7(capt)
    return function(dom)
        return go_2()
    end
end

function go_2()
    local v0 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
    if v0 then
        local v1 = g_game.getLocalPlayer():getPosition()
        local v2 = v1.x
        local v3 = v1.y
        local v4 = v1.z
        local v5 = g_map.getSpectators({ x = v2, y = v3, z = v4 }, false)
        local v6 = #(v5)
        local v7 = 1
        local v8 = false
        local v9 = 0
        local v10 = 999
        local v11, v12, v13 = (table.unpack or unpack)(scan_3(v2, v3, v4, v5, v6, v7, v8, v9, v10))
        local getv15 = function()
            if v11 then
                local v14 = v13 <= 2
                return v14
            else
                return false
            end
        end
        local v15 = getv15()
        local getv18 = function()
            if v15 then
                local v16 = g_game.getLocalPlayer():isWalking()
                local v17 = v16 == false
                return v17
            else
                return false
            end
        end
        local v18 = getv18()
        if v18 then
            local v19 = (v5)[v12]
            local v20 = (v19):getPosition()
            local v21 = v20.x
            local v22 = v20.y
            local v23 = v20.z
            local v24 = spiral_wrap_signed((v2 - v21), 32)
            local v25 = v24 > 0
            local getv28 = function()
                if v25 then
                    return 1
                else
                    local v26 = v24 < 0
                    if v26 then
                        return -1
                    else
                        return 0
                    end
                end
            end
            local v28 = getv28()
            local v29 = spiral_wrap_signed((v3 - v22), 32)
            local v30 = v29 > 0
            local getv33 = function()
                if v30 then
                    return 1
                else
                    local v31 = v29 < 0
                    if v31 then
                        return -1
                    else
                        return 0
                    end
                end
            end
            local v33 = getv33()
            local v34 = v28 ~= 0
            local getv36 = function()
                if v34 then
                    return true
                else
                    local v35 = v33 ~= 0
                    return v35
                end
            end
            local v36 = getv36()
            if v36 then
                local v37 = g_game.walk(({ ["0,-1"] = North, ["1,0"] = East, ["0,1"] = South, ["-1,0"] = West, ["1,-1"] = NorthEast, ["1,1"] = SouthEast, ["-1,1"] = SouthWest, ["-1,-1"] = NorthWest })[(v28) .. "," .. (v33)]) ~= false
            else
            end
        else
        end
        local v38 = closure7(nil)
        scheduleEvent(v38, 1300)
        return nil
    else
    end
end

function closure6(capt)
    return function(dom)
        return go_2()
    end
end

function closure9(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = spiral_wrap_signed((v2 + 1), 32)
        return go_4(v0, v1, v3)
    end
end

function closure10(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = spiral_wrap_signed((v1 - 1), 32)
        local v3 = 0
        return go_4(v0, v2, v3)
    end
end

function go_4(v0, v1, v2)
    local v3 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
    if v3 then
        local v4 = g_game.getLocalPlayer():isWalking()
        if v4 then
            local v5 = math.fmod(v2, 40)
            local v6 = v5 == 39
            if v6 then
                local v7 = g_game.getLocalPlayer():getPosition()
                local v8 = v7.x
                local v9 = v7.y
                local v10 = v7.z
                local v11 = format_real_0(v8)
                local v12 = ""
                local v13 = v12 .. v11 
                local v14 = ","
                local v15 = v13 .. v14 
                local v16 = format_real_0(v9)
                local v17 = v15 .. v16 
                local v18 = v17 .. v14 
                local v19 = format_real_0(v10)
                local v20 = v18 .. v19 
                local v21 = "knight walk still walking at "
                local v22 = v21 .. v20 
                local v23 = " after "
                local v24 = v22 .. v23 
                local v25 = spiral_wrap_signed((v2 + 1), 32)
                local v26 = format_real_0(v25)
                local v27 = v24 .. v26 
                local v28 = " polls"
                local v29 = v27 .. v28 
                local v30 = "[tibia-probe] "
                local v31 = v30 .. v29 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v31)
                g_logger.info(v31)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v32 = closure9({ v0, v1, v2 })
            scheduleEvent(v32, 50)
            return nil
        else
            local v33 = v1 == 0
            if v33 then
                local v34 = spiral_wrap_signed(-(v0), 32)
                local v35 = 5
                local v36 = 0
                return go_4(v34, v35, v36)
            else
                local v37 = g_game.walk(({ ["0,-1"] = North, ["1,0"] = East, ["0,1"] = South, ["-1,0"] = West, ["1,-1"] = NorthEast, ["1,1"] = SouthEast, ["-1,1"] = SouthWest, ["-1,-1"] = NorthWest })[(v0) .. "," .. (0)]) ~= false
                local v38 = v37 == false
                if v38 then
                    local v39 = format_real_0(v0)
                    local v40 = "knight walk step "
                    local v41 = v40 .. v39 
                    local v42 = " refused at "
                    local v43 = v41 .. v42 
                    local v44 = g_game.getLocalPlayer():getPosition()
                    local v45 = v44.x
                    local v46 = v44.y
                    local v47 = v44.z
                    local v48 = format_real_0(v45)
                    local v49 = ""
                    local v50 = v49 .. v48 
                    local v51 = ","
                    local v52 = v50 .. v51 
                    local v53 = format_real_0(v46)
                    local v54 = v52 .. v53 
                    local v55 = v54 .. v51 
                    local v56 = format_real_0(v47)
                    local v57 = v55 .. v56 
                    local v58 = v43 .. v57 
                    local v59 = "[tibia-probe] "
                    local v60 = v59 .. v58 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v60)
                    g_logger.info(v60)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v61 = closure10({ v0, v1 })
                scheduleEvent(v61, 50)
                return nil
            end
        end
    else
        local v62 = "[tibia-probe] "
        local v63 = "knight walk stopped: no player in game"
        local v64 = v62 .. v63 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v64)
        g_logger.info(v64)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        return nil
    end
end

function closure8(capt)
    return function(dom)
        local v0 = g_game.getLocalPlayer():getPosition() ~= nil
        local getv16 = function()
            if v0 then
                local v1 = g_game.getLocalPlayer():getPosition()
                local v2 = v1.x
                local v3 = v1.y
                local v4 = v1.z
                local v5 = format_real_0(v2)
                local v6 = ""
                local v7 = v6 .. v5 
                local v8 = ","
                local v9 = v7 .. v8 
                local v10 = format_real_0(v3)
                local v11 = v9 .. v10 
                local v12 = v11 .. v8 
                local v13 = format_real_0(v4)
                local v14 = v12 .. v13 
                return v14
            else
                local v15 = "nil"
                return v15
            end
        end
        local v16 = getv16()
        local v17 = g_game.getLocalPlayer():isWalking()
        local getv20 = function()
            if v17 then
                local v18 = "yes"
                return v18
            else
                local v19 = "no"
                return v19
            end
        end
        local v20 = getv20()
        local v21 = "knight walk starts at "
        local v22 = v21 .. v16 
        local v23 = " speed "
        local v24 = v22 .. v23 
        local v25 = tostring(g_game.getLocalPlayer():getSpeed())
        local v26 = v24 .. v25 
        local v27 = " walking "
        local v28 = v26 .. v27 
        local v29 = v28 .. v20 
        local v30 = "[tibia-probe] "
        local v31 = v30 .. v29 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v31)
        g_logger.info(v31)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v32 = -1
        local v33 = 5
        local v34 = 0
        return go_4(v32, v33, v34)
    end
end

function closure12(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function closure11(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = (function(s) local parts = {}; for label, values in pairs(s) do local sorted = {}; for i, v in ipairs(values) do sorted[i] = v end; table.sort(sorted); if #sorted == 0 then table.insert(parts, label .. " none") else table.insert(parts, string.format("%s n=%d median %d min %d max %d", label, #sorted, sorted[math.floor((#sorted + 1) / 2)], sorted[1], sorted[#sorted])) end end; table.sort(parts); return table.concat(parts, "; ") end)(v0)
        local v2 = "end: "
        local v3 = v2 .. v1 
        local v4 = "[tibia-probe] "
        local v5 = v4 .. v3 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v5)
        g_logger.info(v5)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v6 = "finish: "
        local v7 = "steps measured"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v9)
        g_logger.info(v9)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v10 = g_game.isOnline()
        if v10 then
            g_game.safeLogout()
        else
        end
        local v11 = closure12(nil)
        scheduleEvent(v11, 2000)
        return nil
    end
end

function ready_c5(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = g_game.getLocalPlayer():getName()
        local v4 = g_game.getLocalPlayer():getPosition() ~= nil
        local getv20 = function()
            if v4 then
                local v5 = g_game.getLocalPlayer():getPosition()
                local v6 = v5.x
                local v7 = v5.y
                local v8 = v5.z
                local v9 = format_real_0(v6)
                local v10 = ""
                local v11 = v10 .. v9 
                local v12 = ","
                local v13 = v11 .. v12 
                local v14 = format_real_0(v7)
                local v15 = v13 .. v14 
                local v16 = v15 .. v12 
                local v17 = format_real_0(v8)
                local v18 = v16 .. v17 
                return v18
            else
                local v19 = "nil"
                return v19
            end
        end
        local v20 = getv20()
        local v21 = tostring(g_game.getLocalPlayer():getSpeed())
        local v22 = "in game as "
        local v23 = v22 .. v3 
        local v24 = " at "
        local v25 = v23 .. v24 
        local v26 = v25 .. v20 
        local v27 = " speed "
        local v28 = v26 .. v27 
        local v29 = v28 .. v21 
        local v30 = "[tibia-probe] "
        local v31 = v30 .. v29 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v31)
        g_logger.info(v31)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        if v0 then
            local v32 = closure6(nil)
            scheduleEvent(v32, 2000)
        else
        end
        if v1 then
            local v33 = closure8(nil)
            scheduleEvent(v33, 2000)
        else
        end
        local v34 = closure11({ v2 })
        scheduleEvent(v34, 45000)
        return nil
    end
end

function closure13(capt)
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
        local v10 = closure12(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure15(capt)
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

function on_text_c14(capt)
    return function(v0)
        return closure15({ v0 })
    end
end

function closure16(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_1(v0, v1, v2, v3, v4)
    end
end

function poll_1(v0, v1, v2, v3, v4)
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
        local v10 = ready_c5({ v2, v3, v4 })
        local v11 = closure13(nil)
        local v12 = on_text_c14(nil)
        connect(g_game, { onGameStart = v10, onLoginError = function(message) (v11)(tostring(message)) end, onTextMessage = function(mode, text) (v12)(tostring(mode))(tostring(text)) end })
        local v13 = "@god"
        local v14 = "@god\ngod"
        g_game.loginWorld(v13, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v14)
        return nil
    else
        local v15 = closure16({ v0, v1, v2, v3, v4 })
        scheduleEvent(v15, 50)
        return nil
    end
end

function closure4(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        local v4 = "TIBIA_LOGIN_GATE"
        local v5 = ""
        local v6 = os.getenv(v4) or (v5)
        return poll_1(v6, v0, v1, v2, v3)
    end
end

function closure17(capt)
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
        local v6 = closure12(nil)
        scheduleEvent(v6, 2000)
        return nil
    end
end

local v0 = "TIBIA_STEPS_CHASE"
local v1 = "1"
local v2 = os.getenv(v0) == (v1)
local v3 = "TIBIA_STEPS_KNIGHT_WALK"
local v4 = os.getenv(v3) == (v1)
local v5 = {}
local v6 = {}
local v7 = closure0({ v2, v5, v6 })
local handler = function(c, n, o) (v7)(c)(n)(o) end; connect(Creature, { onPositionChange = handler }); connect(LocalPlayer, { onPositionChange = handler })
local v8 = "TIBIA_ARENA_CHARACTER"
local v9 = "Knight Sample"
local v10 = os.getenv(v8) or (v9)
local v11 = "TIBIA_PROBE_HIDDEN"
local v12 = os.getenv(v11) == (v1)
if v12 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v13 = closure3(nil)
scheduleEvent(v13, 200)
scheduleEvent(v13, 1000)
local v14 = closure4({ v10, v2, v4, v6 })
scheduleEvent(v14, 3000)
local v15 = closure17(nil)
scheduleEvent(v15, 90000)
return 0
