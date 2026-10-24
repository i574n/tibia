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
local Mut0, Us0_Stepped, Us0_Gated, Us0_Cornered, Us1_Free, Us1_Ramp, Us1_Occupied, Us1_Blocked, Us1_Unknown, Us2_InReach, Us2_OutOfReach, Us2_NoTarget, Us3_Strike, Us3_Approach, Us3_Hold, closure0, format_real_1, closure5, closure4, on_move_c3, closure8, seen_3, count_4, scan_5, scan_6, fill_7, fill_8, fill_9, sum_11, activate_10, sum_12, sum_13, sum_14, arena_protection_zone_16, seen_17, attempt_15, around_18, rejected_19, closure9, go_2, closure7, closure6, ready_c2, closure10, closure12, on_text_c11, closure13, poll_0, closure1, closure14
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

function Us0_Stepped() return { tag = "Us0_Stepped" } end
function Us0_Gated() return { tag = "Us0_Gated" } end
function Us0_Cornered() return { tag = "Us0_Cornered" } end

function Us1_Free() return { tag = "Us1_Free" } end
function Us1_Ramp() return { tag = "Us1_Ramp" } end
function Us1_Occupied() return { tag = "Us1_Occupied" } end
function Us1_Blocked() return { tag = "Us1_Blocked" } end
function Us1_Unknown() return { tag = "Us1_Unknown" } end

function Us2_InReach() return { tag = "Us2_InReach" } end
function Us2_OutOfReach() return { tag = "Us2_OutOfReach" } end
function Us2_NoTarget() return { tag = "Us2_NoTarget" } end

function Us3_Strike() return { tag = "Us3_Strike" } end
function Us3_Approach() return { tag = "Us3_Approach" } end
function Us3_Hold() return { tag = "Us3_Hold" } end

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
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(v4)
        local v5 = (v3) ~= nil
        local getv7 = function()
            if v5 then
                local v6 = (v4) ~= nil
                return v6
            else
                return false
            end
        end
        local v7 = getv7()
        local v8 = (v0).value
        local v9 = v8 == 0
        local v10 = (v9) and (v7)
        local getv12 = function()
            if v10 then
                local v11 = (v2):isMonster()
                return v11
            else
                return false
            end
        end
        local v12 = getv12()
        if v12 then
            local v13 = v3.x
            local v14 = v3.y
            local v15 = v3.z
            local v16 = (v2):getId()
            local v17 = g_clock.millis()
            local v18 = (v1).value
            local v19 = spiral_wrap_signed((v17 - v18), 32)
            local v20 = format_real_1(v16)
            local v21 = "monster "
            local v22 = v21 .. v20 
            local v23 = " moved to "
            local v24 = v22 .. v23 
            local v25 = format_real_1(v13)
            local v26 = v24 .. v25 
            local v27 = ","
            local v28 = v26 .. v27 
            local v29 = format_real_1(v14)
            local v30 = v28 .. v29 
            local v31 = " @login+"
            local v32 = v30 .. v31 
            local v33 = format_real_1(v19)
            local v34 = v32 .. v33 
            local v35 = "[tibia-probe] "
            local v36 = v35 .. v34 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v36)
            g_logger.info(v36)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            return nil
        else
            local v37 = (v0).value
            local v38 = v37 > 0
            local v39 = (v38) and (v7)
            if v39 then
                local v40 = (v2):isLocalPlayer()
                local getv47 = function()
                    if v40 then
                        local v41 = "knight"
                        return v41
                    else
                        local v42 = g_game.getAttackingCreature()
                        local v43 = (v42) == (v2)
                        if v43 then
                            local v44 = "target"
                            return v44
                        else
                            local v45 = ""
                            return v45
                        end
                    end
                end
                local v47 = getv47()
                local v48 = v47 ~= ""
                if v48 then
                    local v49 = v3.x
                    local v50 = v3.y
                    local v51 = v3.z
                    local v52 = g_clock.millis()
                    local v53 = (v0).value
                    local v54 = spiral_wrap_signed((v52 - v53), 32)
                    local v55 = " moved to "
                    local v56 = v47 .. v55 
                    local v57 = format_real_1(v49)
                    local v58 = v56 .. v57 
                    local v59 = ","
                    local v60 = v58 .. v59 
                    local v61 = format_real_1(v50)
                    local v62 = v60 .. v61 
                    local v63 = " @t+"
                    local v64 = v62 .. v63 
                    local v65 = format_real_1(v54)
                    local v66 = v64 .. v65 
                    local v67 = "[tibia-probe] "
                    local v68 = v67 .. v66 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v68)
                    g_logger.info(v68)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    return nil
                else
                end
            else
            end
        end
    end
end

function closure4(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        return closure5({ v0, v1, v2, v3 })
    end
end

function on_move_c3(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(v2)
        return closure4({ v0, v1, v2 })
    end
end

function closure8(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function seen_3(v0, v1, v2, v3)
    local v4 = v2 > v1
    if v4 then
        return v3
    else
        local v5 = (v0)[v2]
        local v6 = (v5):isMonster() and (v5):getPosition() ~= nil
        if v6 then
            local v7 = (v5):getPosition()
            local v8 = v7.x
            local v9 = v7.y
            local v10 = v7.z
            local v11 = format_real_1(v8)
            local v12 = ""
            local v13 = v12 .. v11 
            local v14 = ","
            local v15 = v13 .. v14 
            local v16 = format_real_1(v9)
            local v17 = v15 .. v16 
            local v18 = v17 .. v14 
            local v19 = format_real_1(v10)
            local v20 = v18 .. v19 
            local v21 = spiral_wrap_signed((v2 + 1), 32)
            local v22 = v3 == ""
            local getv26 = function()
                if v22 then
                    return v20
                else
                    local v23 = " "
                    local v24 = v3 .. v23 
                    local v25 = v24 .. v20 
                    return v25
                end
            end
            local v26 = getv26()
            return seen_3(v0, v1, v21, v26)
        else
            local v28 = spiral_wrap_signed((v2 + 1), 32)
            return seen_3(v0, v1, v28, v3)
        end
    end
end

function count_4(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 > v4
    if v7 then
        return v6
    else
        local v8 = (v3)[v5]
        local v9 = spiral_wrap_signed((v5 + 1), 32)
        local v10 = (v8):isMonster() and not (v8):isDead() and (v8):getPosition() ~= nil
        local getv26 = function()
            if v10 then
                local v11 = (v8):getPosition()
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
                local v25 = v24 <= 1
                return v25
            else
                return false
            end
        end
        local v26 = getv26()
        local getv28 = function()
            if v26 then
                local v27 = spiral_wrap_signed((v6 + 1), 32)
                return v27
            else
                return v6
            end
        end
        local v28 = getv28()
        return count_4(v0, v1, v2, v3, v4, v9, v28)
    end
end

function scan_5(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24)
    local v25 = v21 > v20
    local getv84 = function()
        if v25 then
            return { [1]=v22, [2]=v23, [3]=v24 }
        else
            local v26 = (v3)[v21]
            local v27 = (v26):isMonster() and not (v26):isDead() and (v26):getPosition() ~= nil
            local getv81 = function()
                if v27 then
                    local v28 = (v26):getPosition()
                    local v29 = v28.x
                    local v30 = v28.y
                    local v31 = v28.z
                    local v32 = v29 > v0
                    local getv35 = function()
                        if v32 then
                            local v33 = spiral_wrap_signed((v29 - v0), 32)
                            return v33
                        else
                            local v34 = spiral_wrap_signed((v0 - v29), 32)
                            return v34
                        end
                    end
                    local v35 = getv35()
                    local v36 = v30 > v1
                    local getv39 = function()
                        if v36 then
                            local v37 = spiral_wrap_signed((v30 - v1), 32)
                            return v37
                        else
                            local v38 = spiral_wrap_signed((v1 - v30), 32)
                            return v38
                        end
                    end
                    local v39 = getv39()
                    local v40 = v35 > v39
                    local getv41 = function()
                        if v40 then
                            return v35
                        else
                            return v39
                        end
                    end
                    local v41 = getv41()
                    local v42 = v22 == false
                    local getv69 = function()
                        if v42 then
                            return true
                        else
                            local v43 = (v26) == (v4)
                            local v44 = (v26):getHealthPercent()
                            local v45 = (v3)[v23]
                            local v46 = (v45) == (v4)
                            local v47 = (v45):getHealthPercent()
                            if v9 then
                                local v48 = v41 <= 1
                                local v49 = v24 <= 1
                                local v50 = v48 ~= v49
                                if v50 then
                                    return v48
                                else
                                    local v51 = v43 ~= v46
                                    if v51 then
                                        return v43
                                    else
                                        local v52 = v44 ~= v47
                                        if v52 then
                                            local v53 = v44 < v47
                                            return v53
                                        else
                                            local v54 = v41 < v24
                                            return v54
                                        end
                                    end
                                end
                            else
                                local v58 = v43 ~= v46
                                if v58 then
                                    return v43
                                else
                                    local v59 = v41 <= 1
                                    local v60 = v24 <= 1
                                    local v61 = v59 ~= v60
                                    if v61 then
                                        return v59
                                    else
                                        local v62 = v44 ~= v47
                                        if v62 then
                                            local v63 = v44 < v47
                                            return v63
                                        else
                                            local v64 = v41 < v24
                                            return v64
                                        end
                                    end
                                end
                            end
                        end
                    end
                    local v69 = getv69()
                    local v70 = spiral_wrap_signed((v21 + 1), 32)
                    local getv71 = function()
                        if v69 then
                            return { [1]=true, [2]=v21, [3]=v41 }
                        else
                            return { [1]=v22, [2]=v23, [3]=v24 }
                        end
                    end
                    local v71, v72, v73 = (table.unpack or unpack)(getv71())
                    local v74, v75, v76 = (table.unpack or unpack)(scan_5(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v70, v71, v72, v73))
                    return { [1]=v74, [2]=v75, [3]=v76 }
                else
                    local v77 = spiral_wrap_signed((v21 + 1), 32)
                    local v78, v79, v80 = (table.unpack or unpack)(scan_5(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v77, v22, v23, v24))
                    return { [1]=v78, [2]=v79, [3]=v80 }
                end
            end
            local v81, v82, v83 = (table.unpack or unpack)(getv81())
            return { [1]=v81, [2]=v82, [3]=v83 }
        end
    end
    local v84, v85, v86 = (table.unpack or unpack)(getv84())
    return { [1]=v84, [2]=v85, [3]=v86 }
end

function scan_6(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v5 > v4
    local getv58 = function()
        if v9 then
            return { [1]=v6, [2]=v7, [3]=v8 }
        else
            local v10 = (v3)[v5]
            local v11 = (v10):isMonster() and not (v10):isDead() and (v10):getPosition() ~= nil
            local getv27 = function()
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
                    local v26 = v25 <= 1
                    return v26
                else
                    return false
                end
            end
            local v27 = getv27()
            local getv55 = function()
                if v27 then
                    local v28 = v7 == false
                    local getv43 = function()
                        if v28 then
                            return true
                        else
                            local v29 = (v10):getPosition()
                            local v30 = v29.x
                            local v31 = v29.y
                            local v32 = v29.z
                            local v33 = spiral_wrap_signed(spiral_mul_mod32(v30, 100000), 32)
                            local v34 = spiral_wrap_signed((v33 + v31), 32)
                            local v35 = (v3)[v8]
                            local v36 = (v35):getPosition()
                            local v37 = v36.x
                            local v38 = v36.y
                            local v39 = v36.z
                            local v40 = spiral_wrap_signed(spiral_mul_mod32(v37, 100000), 32)
                            local v41 = spiral_wrap_signed((v40 + v38), 32)
                            local v42 = v34 < v41
                            return v42
                        end
                    end
                    local v43 = getv43()
                    local v44 = spiral_wrap_signed((v5 + 1), 32)
                    local v45 = spiral_wrap_signed((v6 + 1), 32)
                    local getv46 = function()
                        if v43 then
                            return v5
                        else
                            return v8
                        end
                    end
                    local v46 = getv46()
                    local v47 = true
                    local v48, v49, v50 = (table.unpack or unpack)(scan_6(v0, v1, v2, v3, v4, v44, v45, v47, v46))
                    return { [1]=v48, [2]=v49, [3]=v50 }
                else
                    local v51 = spiral_wrap_signed((v5 + 1), 32)
                    local v52, v53, v54 = (table.unpack or unpack)(scan_6(v0, v1, v2, v3, v4, v51, v6, v7, v8))
                    return { [1]=v52, [2]=v53, [3]=v54 }
                end
            end
            local v55, v56, v57 = (table.unpack or unpack)(getv55())
            return { [1]=v55, [2]=v56, [3]=v57 }
        end
    end
    local v58, v59, v60 = (table.unpack or unpack)(getv58())
    return { [1]=v58, [2]=v59, [3]=v60 }
end

function fill_7(v0, v1)
    local v2 = v1 < 66
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_7(v0, v3)
    else
    end
end

function fill_8(v0, v1)
    local v2 = v1 < 8
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_8(v0, v3)
    else
    end
end

function fill_9(v0, v1)
    local v2 = v1 < 6
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_9(v0, v3)
    else
    end
end

function sum_11(v0, v1, v2, v3, v4)
    local v5 = v3 >= 8
    if v5 then
        return v4
    else
        local v6 = spiral_wrap_signed((v3 + 1), 32)
        local v7 = spiral_wrap_signed(spiral_mul_mod32(v2, 8), 32)
        local v8 = spiral_wrap_signed((v7 + v3), 32)
        local v9 = (v0)[(v8)+1]
        local v10 = (v1)[(v3)+1]
        local v11 = spiral_wrap_signed(spiral_mul_mod32(v9, v10), 32)
        local v12 = spiral_wrap_signed((v4 + v11), 32)
        return sum_11(v0, v1, v2, v6, v12)
    end
end

function activate_10(v0, v1, v2, v3)
    local v4 = v3 < 6
    if v4 then
        local v5 = 0
        local v6 = 0
        local v7 = sum_11(v0, v1, v3, v5, v6)
        local v8 = (math.modf(v7 / 256))
        local v9 = v8 > 0
        local getv10 = function()
            if v9 then
                return v8
            else
                return 0
            end
        end
        local v10 = getv10()
        v2[(v3)+1] = v10
        local v11 = spiral_wrap_signed((v3 + 1), 32)
        return activate_10(v0, v1, v2, v11)
    else
    end
end

function sum_12(v0, v1, v2, v3)
    local v4 = v2 >= 6
    if v4 then
        return v3
    else
        local v5 = spiral_wrap_signed((v2 + 1), 32)
        local v6 = spiral_wrap_signed((48 + v2), 32)
        local v7 = (v0)[(v6)+1]
        local v8 = (v1)[(v2)+1]
        local v9 = spiral_wrap_signed(spiral_mul_mod32(v7, v8), 32)
        local v10 = spiral_wrap_signed((v3 + v9), 32)
        return sum_12(v0, v1, v5, v10)
    end
end

function sum_13(v0, v1, v2, v3)
    local v4 = v2 >= 6
    if v4 then
        return v3
    else
        local v5 = spiral_wrap_signed((v2 + 1), 32)
        local v6 = spiral_wrap_signed((54 + v2), 32)
        local v7 = (v0)[(v6)+1]
        local v8 = (v1)[(v2)+1]
        local v9 = spiral_wrap_signed(spiral_mul_mod32(v7, v8), 32)
        local v10 = spiral_wrap_signed((v3 + v9), 32)
        return sum_13(v0, v1, v5, v10)
    end
end

function sum_14(v0, v1, v2, v3)
    local v4 = v2 >= 6
    if v4 then
        return v3
    else
        local v5 = spiral_wrap_signed((v2 + 1), 32)
        local v6 = spiral_wrap_signed((60 + v2), 32)
        local v7 = (v0)[(v6)+1]
        local v8 = (v1)[(v2)+1]
        local v9 = spiral_wrap_signed(spiral_mul_mod32(v7, v8), 32)
        local v10 = spiral_wrap_signed((v3 + v9), 32)
        return sum_14(v0, v1, v5, v10)
    end
end

function arena_protection_zone_16(v0, v1)
    local v2 = v1 == -29
    if v2 then
        local v3 = v0 >= 41
        local getv5 = function()
            if v3 then
                local v4 = v0 <= 43
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            return true
        else
            local v6 = v0 == 45
            return v6
        end
    else
        local v8 = v1 == -28
        if v8 then
            local v9 = v0 >= 41
            local getv11 = function()
                if v9 then
                    local v10 = v0 <= 43
                    return v10
                else
                    return false
                end
            end
            local v11 = getv11()
            if v11 then
                return true
            else
                local v12 = v0 == 45
                return v12
            end
        else
            local v14 = v1 == -27
            if v14 then
                local v15 = v0 >= 40
                if v15 then
                    local v16 = v0 <= 45
                    return v16
                else
                    return false
                end
            else
                local v18 = v1 == -26
                if v18 then
                    local v19 = v0 >= 41
                    if v19 then
                        local v20 = v0 <= 45
                        return v20
                    else
                        return false
                    end
                else
                    local v22 = v1 == -25
                    if v22 then
                        local v23 = v0 >= 41
                        if v23 then
                            local v24 = v0 <= 45
                            return v24
                        else
                            return false
                        end
                    else
                        local v26 = v1 == -24
                        if v26 then
                            local v27 = v0 >= 41
                            if v27 then
                                local v28 = v0 <= 45
                                return v28
                            else
                                return false
                            end
                        else
                            local v30 = v1 == -23
                            if v30 then
                                local v31 = v0 >= 41
                                if v31 then
                                    local v32 = v0 <= 45
                                    return v32
                                else
                                    return false
                                end
                            else
                                local v34 = v1 == -22
                                if v34 then
                                    local v35 = v0 >= 41
                                    if v35 then
                                        local v36 = v0 <= 45
                                        return v36
                                    else
                                        return false
                                    end
                                else
                                    local v38 = v1 == -21
                                    if v38 then
                                        local v39 = v0 >= 38
                                        if v39 then
                                            local v40 = v0 <= 45
                                            return v40
                                        else
                                            return false
                                        end
                                    else
                                        local v42 = v1 == -20
                                        if v42 then
                                            local v43 = v0 >= 38
                                            if v43 then
                                                local v44 = v0 <= 45
                                                return v44
                                            else
                                                return false
                                            end
                                        else
                                            local v46 = v1 == -19
                                            if v46 then
                                                local v47 = v0 >= 38
                                                if v47 then
                                                    local v48 = v0 <= 45
                                                    return v48
                                                else
                                                    return false
                                                end
                                            else
                                                local v50 = v1 == -18
                                                if v50 then
                                                    local v51 = v0 >= 38
                                                    if v51 then
                                                        local v52 = v0 <= 45
                                                        return v52
                                                    else
                                                        return false
                                                    end
                                                else
                                                    local v54 = v1 == -10
                                                    if v54 then
                                                        local v55 = v0 >= 7
                                                        local getv57 = function()
                                                            if v55 then
                                                                local v56 = v0 <= 14
                                                                return v56
                                                            else
                                                                return false
                                                            end
                                                        end
                                                        local v57 = getv57()
                                                        local getv61 = function()
                                                            if v57 then
                                                                return true
                                                            else
                                                                local v58 = v0 >= 21
                                                                if v58 then
                                                                    local v59 = v0 <= 23
                                                                    return v59
                                                                else
                                                                    return false
                                                                end
                                                            end
                                                        end
                                                        local v61 = getv61()
                                                        local getv65 = function()
                                                            if v61 then
                                                                return true
                                                            else
                                                                local v62 = v0 >= 25
                                                                if v62 then
                                                                    local v63 = v0 <= 27
                                                                    return v63
                                                                else
                                                                    return false
                                                                end
                                                            end
                                                        end
                                                        local v65 = getv65()
                                                        local getv69 = function()
                                                            if v65 then
                                                                return true
                                                            else
                                                                local v66 = v0 >= 29
                                                                if v66 then
                                                                    local v67 = v0 <= 31
                                                                    return v67
                                                                else
                                                                    return false
                                                                end
                                                            end
                                                        end
                                                        local v69 = getv69()
                                                        if v69 then
                                                            return true
                                                        else
                                                            local v70 = v0 >= 33
                                                            if v70 then
                                                                local v71 = v0 <= 40
                                                                return v71
                                                            else
                                                                return false
                                                            end
                                                        end
                                                    else
                                                        local v74 = v1 == -9
                                                        if v74 then
                                                            local v75 = v0 >= 7
                                                            local getv77 = function()
                                                                if v75 then
                                                                    local v76 = v0 <= 14
                                                                    return v76
                                                                else
                                                                    return false
                                                                end
                                                            end
                                                            local v77 = getv77()
                                                            local getv81 = function()
                                                                if v77 then
                                                                    return true
                                                                else
                                                                    local v78 = v0 >= 21
                                                                    if v78 then
                                                                        local v79 = v0 <= 23
                                                                        return v79
                                                                    else
                                                                        return false
                                                                    end
                                                                end
                                                            end
                                                            local v81 = getv81()
                                                            local getv85 = function()
                                                                if v81 then
                                                                    return true
                                                                else
                                                                    local v82 = v0 >= 25
                                                                    if v82 then
                                                                        local v83 = v0 <= 27
                                                                        return v83
                                                                    else
                                                                        return false
                                                                    end
                                                                end
                                                            end
                                                            local v85 = getv85()
                                                            local getv89 = function()
                                                                if v85 then
                                                                    return true
                                                                else
                                                                    local v86 = v0 >= 29
                                                                    if v86 then
                                                                        local v87 = v0 <= 31
                                                                        return v87
                                                                    else
                                                                        return false
                                                                    end
                                                                end
                                                            end
                                                            local v89 = getv89()
                                                            if v89 then
                                                                return true
                                                            else
                                                                local v90 = v0 >= 33
                                                                if v90 then
                                                                    local v91 = v0 <= 40
                                                                    return v91
                                                                else
                                                                    return false
                                                                end
                                                            end
                                                        else
                                                            local v94 = v1 == -8
                                                            if v94 then
                                                                local v95 = v0 >= 7
                                                                local getv97 = function()
                                                                    if v95 then
                                                                        local v96 = v0 <= 14
                                                                        return v96
                                                                    else
                                                                        return false
                                                                    end
                                                                end
                                                                local v97 = getv97()
                                                                if v97 then
                                                                    return true
                                                                else
                                                                    local v98 = v0 >= 21
                                                                    if v98 then
                                                                        local v99 = v0 <= 40
                                                                        return v99
                                                                    else
                                                                        return false
                                                                    end
                                                                end
                                                            else
                                                                local v102 = v1 == -7
                                                                if v102 then
                                                                    local v103 = v0 >= 7
                                                                    local getv105 = function()
                                                                        if v103 then
                                                                            local v104 = v0 <= 14
                                                                            return v104
                                                                        else
                                                                            return false
                                                                        end
                                                                    end
                                                                    local v105 = getv105()
                                                                    if v105 then
                                                                        return true
                                                                    else
                                                                        local v106 = v0 >= 21
                                                                        if v106 then
                                                                            local v107 = v0 <= 40
                                                                            return v107
                                                                        else
                                                                            return false
                                                                        end
                                                                    end
                                                                else
                                                                    local v110 = v1 == -6
                                                                    if v110 then
                                                                        local v111 = v0 >= 7
                                                                        local getv113 = function()
                                                                            if v111 then
                                                                                local v112 = v0 <= 14
                                                                                return v112
                                                                            else
                                                                                return false
                                                                            end
                                                                        end
                                                                        local v113 = getv113()
                                                                        if v113 then
                                                                            return true
                                                                        else
                                                                            local v114 = v0 >= 21
                                                                            if v114 then
                                                                                local v115 = v0 <= 40
                                                                                return v115
                                                                            else
                                                                                return false
                                                                            end
                                                                        end
                                                                    else
                                                                        local v118 = v1 == -5
                                                                        if v118 then
                                                                            local v119 = v0 >= 7
                                                                            local getv121 = function()
                                                                                if v119 then
                                                                                    local v120 = v0 <= 14
                                                                                    return v120
                                                                                else
                                                                                    return false
                                                                                end
                                                                            end
                                                                            local v121 = getv121()
                                                                            if v121 then
                                                                                return true
                                                                            else
                                                                                local v122 = v0 >= 21
                                                                                if v122 then
                                                                                    local v123 = v0 <= 40
                                                                                    return v123
                                                                                else
                                                                                    return false
                                                                                end
                                                                            end
                                                                        else
                                                                            local v126 = v1 == -4
                                                                            if v126 then
                                                                                local v127 = v0 >= 7
                                                                                local getv129 = function()
                                                                                    if v127 then
                                                                                        local v128 = v0 <= 14
                                                                                        return v128
                                                                                    else
                                                                                        return false
                                                                                    end
                                                                                end
                                                                                local v129 = getv129()
                                                                                if v129 then
                                                                                    return true
                                                                                else
                                                                                    local v130 = v0 >= 21
                                                                                    if v130 then
                                                                                        local v131 = v0 <= 40
                                                                                        return v131
                                                                                    else
                                                                                        return false
                                                                                    end
                                                                                end
                                                                            else
                                                                                local v134 = v1 == -3
                                                                                if v134 then
                                                                                    local v135 = v0 >= 7
                                                                                    local getv137 = function()
                                                                                        if v135 then
                                                                                            local v136 = v0 <= 14
                                                                                            return v136
                                                                                        else
                                                                                            return false
                                                                                        end
                                                                                    end
                                                                                    local v137 = getv137()
                                                                                    if v137 then
                                                                                        return true
                                                                                    else
                                                                                        local v138 = v0 >= 21
                                                                                        if v138 then
                                                                                            local v139 = v0 <= 40
                                                                                            return v139
                                                                                        else
                                                                                            return false
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    local v142 = v1 == -2
                                                                                    if v142 then
                                                                                        local v143 = v0 >= 7
                                                                                        local getv145 = function()
                                                                                            if v143 then
                                                                                                local v144 = v0 <= 14
                                                                                                return v144
                                                                                            else
                                                                                                return false
                                                                                            end
                                                                                        end
                                                                                        local v145 = getv145()
                                                                                        if v145 then
                                                                                            return true
                                                                                        else
                                                                                            local v146 = v0 >= 21
                                                                                            if v146 then
                                                                                                local v147 = v0 <= 40
                                                                                                return v147
                                                                                            else
                                                                                                return false
                                                                                            end
                                                                                        end
                                                                                    else
                                                                                        local v150 = v1 == -1
                                                                                        if v150 then
                                                                                            local v151 = v0 >= 7
                                                                                            local getv153 = function()
                                                                                                if v151 then
                                                                                                    local v152 = v0 <= 14
                                                                                                    return v152
                                                                                                else
                                                                                                    return false
                                                                                                end
                                                                                            end
                                                                                            local v153 = getv153()
                                                                                            if v153 then
                                                                                                return true
                                                                                            else
                                                                                                local v154 = v0 >= 21
                                                                                                if v154 then
                                                                                                    local v155 = v0 <= 40
                                                                                                    return v155
                                                                                                else
                                                                                                    return false
                                                                                                end
                                                                                            end
                                                                                        else
                                                                                            local v158 = v1 == 0
                                                                                            if v158 then
                                                                                                local v159 = v0 >= 7
                                                                                                local getv161 = function()
                                                                                                    if v159 then
                                                                                                        local v160 = v0 <= 14
                                                                                                        return v160
                                                                                                    else
                                                                                                        return false
                                                                                                    end
                                                                                                end
                                                                                                local v161 = getv161()
                                                                                                if v161 then
                                                                                                    return true
                                                                                                else
                                                                                                    local v162 = v0 >= 21
                                                                                                    if v162 then
                                                                                                        local v163 = v0 <= 40
                                                                                                        return v163
                                                                                                    else
                                                                                                        return false
                                                                                                    end
                                                                                                end
                                                                                            else
                                                                                                local v166 = v1 == 1
                                                                                                if v166 then
                                                                                                    local v167 = v0 >= 8
                                                                                                    local getv169 = function()
                                                                                                        if v167 then
                                                                                                            local v168 = v0 <= 14
                                                                                                            return v168
                                                                                                        else
                                                                                                            return false
                                                                                                        end
                                                                                                    end
                                                                                                    local v169 = getv169()
                                                                                                    if v169 then
                                                                                                        return true
                                                                                                    else
                                                                                                        local v170 = v0 >= 33
                                                                                                        if v170 then
                                                                                                            local v171 = v0 <= 40
                                                                                                            return v171
                                                                                                        else
                                                                                                            return false
                                                                                                        end
                                                                                                    end
                                                                                                else
                                                                                                    local v174 = v1 == 2
                                                                                                    if v174 then
                                                                                                        local v175 = v0 >= 33
                                                                                                        if v175 then
                                                                                                            local v176 = v0 <= 40
                                                                                                            return v176
                                                                                                        else
                                                                                                            return false
                                                                                                        end
                                                                                                    else
                                                                                                        local v178 = v1 == 3
                                                                                                        if v178 then
                                                                                                            local v179 = v0 >= 33
                                                                                                            if v179 then
                                                                                                                local v180 = v0 <= 40
                                                                                                                return v180
                                                                                                            else
                                                                                                                return false
                                                                                                            end
                                                                                                        else
                                                                                                            local v182 = v1 == 4
                                                                                                            if v182 then
                                                                                                                local v183 = v0 >= 33
                                                                                                                if v183 then
                                                                                                                    local v184 = v0 <= 40
                                                                                                                    return v184
                                                                                                                else
                                                                                                                    return false
                                                                                                                end
                                                                                                            else
                                                                                                                local v186 = v1 == 5
                                                                                                                if v186 then
                                                                                                                    local v187 = v0 >= 33
                                                                                                                    if v187 then
                                                                                                                        local v188 = v0 <= 40
                                                                                                                        return v188
                                                                                                                    else
                                                                                                                        return false
                                                                                                                    end
                                                                                                                else
                                                                                                                    return false
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function seen_17(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 > v4
    if v7 then
        return v6
    else
        local v8 = (v3)[v5]
        local v9 = (v8):isMonster() and not (v8):isDead() and (v8):getPosition() ~= nil
        local getv25 = function()
            if v9 then
                local v10 = (v8):getPosition()
                local v11 = v10.x
                local v12 = v10.y
                local v13 = v10.z
                local v14 = v11 > v0
                local getv17 = function()
                    if v14 then
                        local v15 = spiral_wrap_signed((v11 - v0), 32)
                        return v15
                    else
                        local v16 = spiral_wrap_signed((v0 - v11), 32)
                        return v16
                    end
                end
                local v17 = getv17()
                local v18 = v12 > v1
                local getv21 = function()
                    if v18 then
                        local v19 = spiral_wrap_signed((v12 - v1), 32)
                        return v19
                    else
                        local v20 = spiral_wrap_signed((v1 - v12), 32)
                        return v20
                    end
                end
                local v21 = getv21()
                local v22 = v17 > v21
                local getv23 = function()
                    if v22 then
                        return v17
                    else
                        return v21
                    end
                end
                local v23 = getv23()
                local v24 = v23 <= 2
                return v24
            else
                return false
            end
        end
        local v25 = getv25()
        if v25 then
            local v26 = (v8):getPosition()
            local v27 = v26.x
            local v28 = v26.y
            local v29 = v26.z
            local v30 = format_real_1(v27)
            local v31 = ""
            local v32 = v31 .. v30 
            local v33 = ","
            local v34 = v32 .. v33 
            local v35 = format_real_1(v28)
            local v36 = v34 .. v35 
            local v37 = v36 .. v33 
            local v38 = format_real_1(v29)
            local v39 = v37 .. v38 
            local v40 = spiral_wrap_signed((v5 + 1), 32)
            local v41 = (v6) == ""
            local getv45 = function()
                if v41 then
                    return v39
                else
                    local v42 = " "
                    local v43 = v6 .. v42 
                    local v44 = v43 .. v39 
                    return v44
                end
            end
            local v45 = getv45()
            return seen_17(v0, v1, v2, v3, v4, v40, v45)
        else
            local v47 = spiral_wrap_signed((v5 + 1), 32)
            return seen_17(v0, v1, v2, v3, v4, v47, v6)
        end
    end
end

function attempt_15(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22)
    local v23 = v22 >= 7
    if v23 then
        local v24 = Us0_Cornered()
        return { [1]=v24, [2]=0 }
    else
        local v25 = v22 == 0
        local getv50 = function()
            if v25 then
                return { [1]=v19, [2]=v20, [3]=true }
            else
                local v26 = v22 == 1
                local getv47 = function()
                    if v26 then
                        return { [1]=v19, [2]=0, [3]=true }
                    else
                        local v27 = v22 == 2
                        local getv44 = function()
                            if v27 then
                                return { [1]=0, [2]=v20, [3]=true }
                            else
                                local v28 = v22 == 3
                                local getv41 = function()
                                    if v28 then
                                        local v29 = v19 == 0
                                        return { [1]=1, [2]=v20, [3]=v29 }
                                    else
                                        local v30 = v22 == 4
                                        local getv38 = function()
                                            if v30 then
                                                local v31 = v19 == 0
                                                return { [1]=-1, [2]=v20, [3]=v31 }
                                            else
                                                local v32 = v22 == 5
                                                local getv35 = function()
                                                    if v32 then
                                                        local v33 = v20 == 0
                                                        return { [1]=v19, [2]=1, [3]=v33 }
                                                    else
                                                        local v34 = v20 == 0
                                                        return { [1]=v19, [2]=-1, [3]=v34 }
                                                    end
                                                end
                                                local v35, v36, v37 = (table.unpack or unpack)(getv35())
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
                        end
                        local v44, v45, v46 = (table.unpack or unpack)(getv44())
                        return { [1]=v44, [2]=v45, [3]=v46 }
                    end
                end
                local v47, v48, v49 = (table.unpack or unpack)(getv47())
                return { [1]=v47, [2]=v48, [3]=v49 }
            end
        end
        local v50, v51, v52 = (table.unpack or unpack)(getv50())
        local getv56 = function()
            if v52 then
                local v53 = v50 ~= 0
                if v53 then
                    return true
                else
                    local v54 = v51 ~= 0
                    return v54
                end
            else
                return false
            end
        end
        local v56 = getv56()
        local getv79 = function()
            if v56 then
                local v57 = spiral_wrap_signed((v15 + v50), 32)
                local v58 = spiral_wrap_signed((v16 + v51), 32)
                local v59 = spiral_wrap_signed((v57 - 1933), 32)
                local v60 = spiral_wrap_signed((v58 - 1350), 32)
                local v61 = arena_protection_zone_16(v59, v60)
                local getv77 = function()
                    if v61 then
                        return Us1_Blocked()
                    else
                        local v63 = (function() local tile = g_map.getTile({ x = v57, y = v58, z = v17 }); if not tile then return 4 elseif tile:isWalkable() and not tile:hasFloorChange() then return 0 elseif tile:isWalkable() then return 1 elseif tile:isWalkable(true) then return 2 else return 3 end end)()
                        local v64 = v63 == 0
                        if v64 then
                            return Us1_Free()
                        else
                            local v66 = v63 == 1
                            if v66 then
                                return Us1_Ramp()
                            else
                                local v68 = v63 == 2
                                if v68 then
                                    return Us1_Occupied()
                                else
                                    local v70 = v63 == 3
                                    if v70 then
                                        return Us1_Blocked()
                                    else
                                        return Us1_Unknown()
                                    end
                                end
                            end
                        end
                    end
                end
                local v77 = getv77()
                local __v = { v77 }
                if __v[1] ~= nil and __v[1].tag == "Us1_Free" then
                    return true
                else
                    return false
                end
            else
                return false
            end
        end
        local v79 = getv79()
        if v79 then
            local v80 = g_game.walk(({ ["0,-1"] = North, ["1,0"] = East, ["0,1"] = South, ["-1,0"] = West, ["1,-1"] = NorthEast, ["1,1"] = SouthEast, ["-1,1"] = SouthWest, ["-1,-1"] = NorthWest })[(v50) .. "," .. (v51)]) ~= false
            if v80 then
                local v81 = g_clock.millis()
                local v82 = (v6).value
                local v83 = spiral_wrap_signed((v81 - v82), 32)
                local v84 = format_real_1(v15)
                local v85 = ""
                local v86 = v85 .. v84 
                local v87 = ","
                local v88 = v86 .. v87 
                local v89 = format_real_1(v16)
                local v90 = v88 .. v89 
                local v91 = v90 .. v87 
                local v92 = format_real_1(v17)
                local v93 = v91 .. v92 
                local v94 = #(v18)
                local v95 = 1
                local v96 = seen_17(v15, v16, v17, v18, v94, v95, v85)
                local v97 = "step away from "
                local v98 = v97 .. v93 
                local v99 = " by "
                local v100 = v98 .. v99 
                local v101 = format_real_1(v50)
                local v102 = v100 .. v101 
                local v103 = v102 .. v87 
                local v104 = format_real_1(v51)
                local v105 = v103 .. v104 
                local v106 = " @t+"
                local v107 = v105 .. v106 
                local v108 = format_real_1(v83)
                local v109 = v107 .. v108 
                local v110 = " near "
                local v111 = v109 .. v110 
                local v112 = v111 .. v96 
                local v113 = "[tibia-probe] "
                local v114 = v113 .. v112 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v114)
                g_logger.info(v114)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v115 = v50 ~= 0
                local getv117 = function()
                    if v115 then
                        local v116 = v51 ~= 0
                        return v116
                    else
                        return false
                    end
                end
                local v117 = getv117()
                local getv118 = function()
                    if v117 then
                        return 3
                    else
                        return 1
                    end
                end
                local v118 = getv118()
                local v119 = spiral_wrap_signed(spiral_mul_mod32(650, v118), 32)
                local v120 = spiral_wrap_signed((v21 + v119), 32)
                local v121 = Us0_Stepped()
                return { [1]=v121, [2]=v120 }
            else
                local v122 = Us0_Gated()
                return { [1]=v122, [2]=0 }
            end
        else
            local v125 = spiral_wrap_signed((v22 + 1), 32)
            return attempt_15(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v125)
        end
    end
end

function around_18(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 > v4
    if v7 then
        return v6
    else
        local v8 = (v3)[v5]
        local v9 = (v8):isMonster() and (v8):getPosition() ~= nil
        local getv25 = function()
            if v9 then
                local v10 = (v8):getPosition()
                local v11 = v10.x
                local v12 = v10.y
                local v13 = v10.z
                local v14 = v11 > v0
                local getv17 = function()
                    if v14 then
                        local v15 = spiral_wrap_signed((v11 - v0), 32)
                        return v15
                    else
                        local v16 = spiral_wrap_signed((v0 - v11), 32)
                        return v16
                    end
                end
                local v17 = getv17()
                local v18 = v12 > v1
                local getv21 = function()
                    if v18 then
                        local v19 = spiral_wrap_signed((v12 - v1), 32)
                        return v19
                    else
                        local v20 = spiral_wrap_signed((v1 - v12), 32)
                        return v20
                    end
                end
                local v21 = getv21()
                local v22 = v17 > v21
                local getv23 = function()
                    if v22 then
                        return v17
                    else
                        return v21
                    end
                end
                local v23 = getv23()
                local v24 = v23 <= 1
                return v24
            else
                return false
            end
        end
        local v25 = getv25()
        if v25 then
            local v26 = spiral_wrap_signed((v5 + 1), 32)
            local v27 = v6 == ""
            local getv59 = function()
                if v27 then
                    local v28 = (v8):getPosition()
                    local v29 = v28.x
                    local v30 = v28.y
                    local v31 = v28.z
                    local v32 = format_real_1(v29)
                    local v33 = ""
                    local v34 = v33 .. v32 
                    local v35 = ","
                    local v36 = v34 .. v35 
                    local v37 = format_real_1(v30)
                    local v38 = v36 .. v37 
                    local v39 = v38 .. v35 
                    local v40 = format_real_1(v31)
                    local v41 = v39 .. v40 
                    return v41
                else
                    local v42 = " "
                    local v43 = v6 .. v42 
                    local v44 = (v8):getPosition()
                    local v45 = v44.x
                    local v46 = v44.y
                    local v47 = v44.z
                    local v48 = format_real_1(v45)
                    local v49 = ""
                    local v50 = v49 .. v48 
                    local v51 = ","
                    local v52 = v50 .. v51 
                    local v53 = format_real_1(v46)
                    local v54 = v52 .. v53 
                    local v55 = v54 .. v51 
                    local v56 = format_real_1(v47)
                    local v57 = v55 .. v56 
                    local v58 = v43 .. v57 
                    return v58
                end
            end
            local v59 = getv59()
            return around_18(v0, v1, v2, v3, v4, v26, v59)
        else
            local v61 = spiral_wrap_signed((v5 + 1), 32)
            return around_18(v0, v1, v2, v3, v4, v61, v6)
        end
    end
end

function rejected_19(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 >= 7
    if v7 then
        return v6
    else
        local v8 = v5 == 0
        local getv33 = function()
            if v8 then
                return { [1]=v3, [2]=v4, [3]=true }
            else
                local v9 = v5 == 1
                local getv30 = function()
                    if v9 then
                        return { [1]=v3, [2]=0, [3]=true }
                    else
                        local v10 = v5 == 2
                        local getv27 = function()
                            if v10 then
                                return { [1]=0, [2]=v4, [3]=true }
                            else
                                local v11 = v5 == 3
                                local getv24 = function()
                                    if v11 then
                                        local v12 = v3 == 0
                                        return { [1]=1, [2]=v4, [3]=v12 }
                                    else
                                        local v13 = v5 == 4
                                        local getv21 = function()
                                            if v13 then
                                                local v14 = v3 == 0
                                                return { [1]=-1, [2]=v4, [3]=v14 }
                                            else
                                                local v15 = v5 == 5
                                                local getv18 = function()
                                                    if v15 then
                                                        local v16 = v4 == 0
                                                        return { [1]=v3, [2]=1, [3]=v16 }
                                                    else
                                                        local v17 = v4 == 0
                                                        return { [1]=v3, [2]=-1, [3]=v17 }
                                                    end
                                                end
                                                local v18, v19, v20 = (table.unpack or unpack)(getv18())
                                                return { [1]=v18, [2]=v19, [3]=v20 }
                                            end
                                        end
                                        local v21, v22, v23 = (table.unpack or unpack)(getv21())
                                        return { [1]=v21, [2]=v22, [3]=v23 }
                                    end
                                end
                                local v24, v25, v26 = (table.unpack or unpack)(getv24())
                                return { [1]=v24, [2]=v25, [3]=v26 }
                            end
                        end
                        local v27, v28, v29 = (table.unpack or unpack)(getv27())
                        return { [1]=v27, [2]=v28, [3]=v29 }
                    end
                end
                local v30, v31, v32 = (table.unpack or unpack)(getv30())
                return { [1]=v30, [2]=v31, [3]=v32 }
            end
        end
        local v33, v34, v35 = (table.unpack or unpack)(getv33())
        local getv39 = function()
            if v35 then
                local v36 = v33 ~= 0
                if v36 then
                    return true
                else
                    local v37 = v34 ~= 0
                    return v37
                end
            else
                return false
            end
        end
        local v39 = getv39()
        if v39 then
            local v40 = spiral_wrap_signed((v0 + v33), 32)
            local v41 = spiral_wrap_signed((v1 + v34), 32)
            local v42 = spiral_wrap_signed((v40 - 1933), 32)
            local v43 = spiral_wrap_signed((v41 - 1350), 32)
            local v44 = arena_protection_zone_16(v42, v43)
            local getv70 = function()
                if v44 then
                    local v45 = "zone"
                    return v45
                else
                    local v46 = (function() local tile = g_map.getTile({ x = v40, y = v41, z = v2 }); if not tile then return 4 elseif tile:isWalkable() and not tile:hasFloorChange() then return 0 elseif tile:isWalkable() then return 1 elseif tile:isWalkable(true) then return 2 else return 3 end end)()
                    local v47 = v46 == 0
                    local getv59 = function()
                        if v47 then
                            return Us1_Free()
                        else
                            local v49 = v46 == 1
                            if v49 then
                                return Us1_Ramp()
                            else
                                local v51 = v46 == 2
                                if v51 then
                                    return Us1_Occupied()
                                else
                                    local v53 = v46 == 3
                                    if v53 then
                                        return Us1_Blocked()
                                    else
                                        return Us1_Unknown()
                                    end
                                end
                            end
                        end
                    end
                    local v59 = getv59()
                    local __v = { v59 }
                    if __v[1] ~= nil and __v[1].tag == "Us1_Blocked" then
                        local v63 = "blocked"
                        return v63
                    elseif __v[1] ~= nil and __v[1].tag == "Us1_Free" then
                        local v60 = "walk"
                        return v60
                    elseif __v[1] ~= nil and __v[1].tag == "Us1_Occupied" then
                        local v62 = "creature"
                        return v62
                    elseif __v[1] ~= nil and __v[1].tag == "Us1_Ramp" then
                        local v61 = "walk"
                        return v61
                    elseif __v[1] ~= nil and __v[1].tag == "Us1_Unknown" then
                        local v64 = "none"
                        return v64
                    end
                end
            end
            local v70 = getv70()
            local v71 = format_real_1(v33)
            local v72 = ""
            local v73 = v72 .. v71 
            local v74 = ","
            local v75 = v73 .. v74 
            local v76 = format_real_1(v34)
            local v77 = v75 .. v76 
            local v78 = ":"
            local v79 = v77 .. v78 
            local v80 = v79 .. v70 
            local v81 = spiral_wrap_signed((v5 + 1), 32)
            local v82 = v6 == ""
            local getv86 = function()
                if v82 then
                    return v80
                else
                    local v83 = " "
                    local v84 = v6 .. v83 
                    local v85 = v84 .. v80 
                    return v85
                end
            end
            local v86 = getv86()
            return rejected_19(v0, v1, v2, v3, v4, v81, v86)
        else
            local v88 = spiral_wrap_signed((v5 + 1), 32)
            return rejected_19(v0, v1, v2, v3, v4, v88, v6)
        end
    end
end

function closure9(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_2(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v17, v18, v19, v20, v21, v22, v23, v24, v25, v15, v16)
    end
end

function go_2(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    local v26 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
    local v27 = v26 == false
    if v27 then
        local v28 = ArenaParity and ArenaParity.summary() or ""
        local v29 = v28 ~= ""
        if v29 then
            local v30 = "[tibia-probe] "
            local v31 = v30 .. v28 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v31)
            g_logger.info(v31)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        else
        end
        local v32 = "finish: "
        local v33 = "offline"
        local v34 = v32 .. v33 
        local v35 = "[tibia-probe] "
        local v36 = v35 .. v34 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v36)
        g_logger.info(v36)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v37 = g_game.isOnline()
        if v37 then
            g_game.safeLogout()
        else
        end
        local v38 = closure8(nil)
        scheduleEvent(v38, 2000)
        return nil
    else
        local v39 = g_clock.millis()
        local v40 = g_game.getLocalPlayer():getHealth()
        local v41 = spiral_wrap_signed((v15 + 1), 32)
        local v42 = v40 < v23
        local getv43 = function()
            if v42 then
                return v40
            else
                return v23
            end
        end
        local v43 = getv43()
        local v44 = v40 <= 0
        if v44 then
            local v45 = g_game.getLocalPlayer():getHealth()
            local v46 = g_game.getLocalPlayer():getExperience()
            local v47 = spiral_wrap_signed((v46 - v5), 32)
            local v48 = format_real_1(v41)
            local v49 = "ticks "
            local v50 = v49 .. v48 
            local v51 = " heals "
            local v52 = v50 .. v51 
            local v53 = format_real_1(v16)
            local v54 = v52 .. v53 
            local v55 = " strikes "
            local v56 = v54 .. v55 
            local v57 = format_real_1(v17)
            local v58 = v56 .. v57 
            local v59 = " holds "
            local v60 = v58 .. v59 
            local v61 = format_real_1(v18)
            local v62 = v60 .. v61 
            local v63 = " retreats "
            local v64 = v62 .. v63 
            local v65 = format_real_1(v20)
            local v66 = v64 .. v65 
            local v67 = " cornered "
            local v68 = v66 .. v67 
            local v69 = format_real_1(v21)
            local v70 = v68 .. v69 
            local v71 = " gated "
            local v72 = v70 .. v71 
            local v73 = format_real_1(v22)
            local v74 = v72 .. v73 
            local v75 = " kills "
            local v76 = v74 .. v75 
            local v77 = format_real_1(v19)
            local v78 = v76 .. v77 
            local v79 = " health "
            local v80 = v78 .. v79 
            local v81 = format_real_1(v45)
            local v82 = v80 .. v81 
            local v83 = " lowest "
            local v84 = v82 .. v83 
            local v85 = format_real_1(v43)
            local v86 = v84 .. v85 
            local v87 = " experience +"
            local v88 = v86 .. v87 
            local v89 = format_real_1(v47)
            local v90 = v88 .. v89 
            local v91 = "dead: "
            local v92 = v91 .. v90 
            local v93 = "[tibia-probe] "
            local v94 = v93 .. v92 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v94)
            g_logger.info(v94)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v95 = ArenaParity and ArenaParity.summary() or ""
            local v96 = v95 ~= ""
            if v96 then
                local v97 = v93 .. v95 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v97)
                g_logger.info(v97)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v98 = "finish: "
            local v99 = "death"
            local v100 = v98 .. v99 
            local v101 = v93 .. v100 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v101)
            g_logger.info(v101)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            local v102 = g_game.isOnline()
            if v102 then
                g_game.safeLogout()
            else
            end
            local v103 = closure8(nil)
            scheduleEvent(v103, 2000)
            return nil
        else
            local v104 = (function(t) local n = 0; for id, c in pairs(t) do if c:isDead() then n = n + 1; t[id] = nil end end; return n end)(v8)
            local v105 = spiral_wrap_signed((v19 + v104), 32)
            local v106 = g_game.getLocalPlayer():getPosition()
            local v107 = v106.x
            local v108 = v106.y
            local v109 = v106.z
            local v110 = g_map.getSpectators({ x = v107, y = v108, z = v109 }, false)
            if v10 then
                local v111 = (v13).value
                local v112 = v111 < 0
                if v112 then
                    local v113 = #(v110)
                    local v114 = format_real_1(v107)
                    local v115 = ""
                    local v116 = v115 .. v114 
                    local v117 = ","
                    local v118 = v116 .. v117 
                    local v119 = format_real_1(v108)
                    local v120 = v118 .. v119 
                    local v121 = v120 .. v117 
                    local v122 = format_real_1(v109)
                    local v123 = v121 .. v122 
                    local v124 = "start positions: knight "
                    local v125 = v124 .. v123 
                    local v126 = " monsters "
                    local v127 = v125 .. v126 
                    local v128 = 1
                    local v129 = seen_3(v110, v113, v128, v115)
                    local v130 = v127 .. v129 
                    local v131 = "[tibia-probe] "
                    local v132 = v131 .. v130 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v132)
                    g_logger.info(v132)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                    local v133 = #(v110)
                    local v134 = 1
                    local v135 = 0
                    local v136 = count_4(v107, v108, v109, v110, v133, v134, v135)
                    local v137 = (v11).value
                    local v138 = spiral_wrap_signed((v39 - v111), 32)
                    local v139 = spiral_wrap_signed(spiral_mul_mod32(v136, v138), 32)
                    local v140 = spiral_wrap_signed((v137 + v139), 32)
                    do (v11).value = (v140) end
                    local v141 = v136 > 3
                    local getv142 = function()
                        if v141 then
                            return 3
                        else
                            return v136
                        end
                    end
                    local v142 = getv142()
                    do (v14)[v142] = ((v14)[v142] or 0) + (v138) end
                end
                do (v13).value = (v39) end
            else
            end
            local v143 = g_game.getAttackingCreature()
            local v144 = #(v110)
            local v145 = 1
            local v146 = false
            local v147 = 0
            local v148 = 999
            local v149, v150, v151 = (table.unpack or unpack)(scan_5(v107, v108, v109, v110, v143, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v144, v145, v146, v147, v148))
            local v152 = v149 == false
            local getv155 = function()
                if v152 then
                    return 0
                else
                    local v153 = v151 <= 1
                    if v153 then
                        return 1
                    else
                        return 2
                    end
                end
            end
            local v155 = getv155()
            local v156 = spiral_wrap_signed((v39 - v24), 32)
            local v157 = v156 >= 1000
            local v158 = #(v110)
            local v159 = 1
            local v160 = 0
            local v161 = false
            local v162 = 0
            local v163, v164, v165 = (table.unpack or unpack)(scan_6(v107, v108, v109, v110, v158, v159, v160, v161, v162))
            local getv167 = function()
                if v164 then
                    local v166 = v39 >= v25
                    return v166
                else
                    return false
                end
            end
            local v167 = getv167()
            local getv170 = function()
                if v167 then
                    local v168 = g_game.getLocalPlayer():isWalking()
                    local v169 = v168 == false
                    return v169
                else
                    return false
                end
            end
            local v170 = getv170()
            local v171 = v3 > 0
            local getv765 = function()
                if v171 then
                    local v172 = (v9).value
                    local v173 = spiral_wrap_signed((v39 - v172), 32)
                    local v174 = v173 >= 2000
                    local getv177 = function()
                        if v149 then
                            local v175 = (v110)[v150]
                            local v176 = (v175):getHealthPercent()
                            return v176
                        else
                            return 0
                        end
                    end
                    local v177 = getv177()
                    local getv178 = function()
                        if v149 then
                            return v151
                        else
                            return 0
                        end
                    end
                    local v178 = getv178()
                    local v179 = g_game.getLocalPlayer():getMaxHealth()
                    local v180 = spiral_wrap_signed((v0 - 1), 32)
                    local v181 = spiral_wrap_signed(spiral_mul_mod32(v180, 256), 32)
                    local v182 = (math.modf(v181 / v179))
                    local v183 = spiral_wrap_signed((v182 + 1), 32)
                    local v184 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(66)
                    local v185 = 0
                    fill_7(v184, v185)
                    v184[(0)+1] = -256
                    v184[(7)+1] = v183
                    v184[(15)+1] = 256
                    v184[(48)+1] = 256
                    v184[(55)+1] = 256
                    v184[(17)+1] = 256
                    v184[(21)+1] = -256
                    local v186 = spiral_wrap_signed((v3 - 1), 32)
                    local v187 = spiral_wrap_signed(spiral_mul_mod32(v186, 85), 32)
                    local v188 = spiral_wrap_signed(-(v187), 32)
                    v184[(23)+1] = v188
                    v184[(62)+1] = 1024
                    local v189 = spiral_wrap_signed(spiral_mul_mod32(v40, 256), 32)
                    local v190 = (math.modf(v189 / v179))
                    local v191 = spiral_wrap_signed(spiral_mul_mod32(v177, 256), 32)
                    local v192 = (math.modf(v191 / 100))
                    local v193 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(8)
                    local v194 = 0
                    fill_8(v193, v194)
                    v193[(0)+1] = v190
                    local v195 = spiral_wrap_signed(spiral_mul_mod32(v163, 85), 32)
                    v193[(1)+1] = v195
                    v193[(2)+1] = v192
                    local v196 = v178 > 7
                    local getv197 = function()
                        if v196 then
                            return 7
                        else
                            return v178
                        end
                    end
                    local v197 = getv197()
                    local v198 = spiral_wrap_signed(spiral_mul_mod32(v197, 32), 32)
                    v193[(3)+1] = v198
                    local getv199 = function()
                        if v157 then
                            return 256
                        else
                            return 0
                        end
                    end
                    local v199 = getv199()
                    v193[(4)+1] = v199
                    local getv200 = function()
                        if v174 then
                            return 256
                        else
                            return 0
                        end
                    end
                    local v200 = getv200()
                    v193[(5)+1] = v200
                    v193[(6)+1] = 0
                    v193[(7)+1] = 256
                    local v201 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(6)
                    local v202 = 0
                    fill_9(v201, v202)
                    local v203 = 0
                    activate_10(v184, v193, v201, v203)
                    local v204 = 0
                    local v205 = 0
                    local v206 = sum_12(v184, v201, v204, v205)
                    local v207 = (math.modf(v206 / 256))
                    local v208 = 0
                    local v209 = 0
                    local v210 = sum_13(v184, v201, v208, v209)
                    local v211 = (math.modf(v210 / 256))
                    local v212 = 0
                    local v213 = 0
                    local v214 = sum_14(v184, v201, v212, v213)
                    local v215 = (math.modf(v214 / 256))
                    local v216 = v207 > 0
                    local v217 = v211 > 0
                    local getv219 = function()
                        if v217 then
                            local v218 = v211 >= v215
                            return v218
                        else
                            return false
                        end
                    end
                    local v219 = getv219()
                    local v220 = v215 > 0
                    local getv222 = function()
                        if v220 then
                            local v221 = v215 > v211
                            return v221
                        else
                            return false
                        end
                    end
                    local v222 = getv222()
                    local getv223 = function()
                        if v216 then
                            return 1
                        else
                            return 0
                        end
                    end
                    local v223 = getv223()
                    local getv224 = function()
                        if v219 then
                            return 2
                        else
                            return 0
                        end
                    end
                    local v224 = getv224()
                    local v225 = spiral_wrap_signed((v223 + v224), 32)
                    local getv226 = function()
                        if v222 then
                            return 4
                        else
                            return 0
                        end
                    end
                    local v226 = getv226()
                    local v227 = spiral_wrap_signed((v225 + v226), 32)
                    local v228 = math.fmod(v227, 2)
                    local v229 = v228 == 1
                    local v230 = (v229) and (v157)
                    local getv254 = function()
                        if v230 then
                            local v231 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                            if v231 then
                                local v232 = format_real_1(v40)
                                local v233 = "heal (potion) at health "
                                local v234 = v233 .. v232 
                                local v235 = "[tibia-probe] "
                                local v236 = v235 .. v234 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v236)
                                g_logger.info(v236)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                                local v237 = spiral_wrap_signed((v16 + 1), 32)
                                return { [1]=v41, [2]=v237, [3]=v17, [4]=v18, [5]=v105, [6]=v20, [7]=v21, [8]=v22, [9]=v43, [10]=v39, [11]=v25 }
                            else
                                local v238 = format_real_1(v40)
                                local v239 = "heal dropped by the action gate at health "
                                local v240 = v239 .. v238 
                                local v241 = "[tibia-probe] "
                                local v242 = v241 .. v240 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v242)
                                g_logger.info(v242)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                                return { [1]=v41, [2]=v16, [3]=v17, [4]=v18, [5]=v105, [6]=v20, [7]=v21, [8]=v22, [9]=v43, [10]=v24, [11]=v25 }
                            end
                        else
                            return { [1]=v41, [2]=v16, [3]=v17, [4]=v18, [5]=v105, [6]=v20, [7]=v21, [8]=v22, [9]=v43, [10]=v24, [11]=v25 }
                        end
                    end
                    local v254, v255, v256, v257, v258, v259, v260, v261, v262, v263, v264 = (table.unpack or unpack)(getv254())
                    local v265 = (math.modf(v227 / 4))
                    local v266 = math.fmod(v265, 2)
                    local v267 = v266 == 1
                    local v268 = (v267) and (v170)
                    local getv370 = function()
                        if v268 then
                            local v269 = (v110)[v165]
                            local v270 = (v269):getPosition()
                            local v271 = v270.x
                            local v272 = v270.y
                            local v273 = v270.z
                            do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((false) and ChaseOpponent or DontChase) end
                            local v274 = spiral_wrap_signed((v107 - v271), 32)
                            local v275 = v274 > 0
                            local getv278 = function()
                                if v275 then
                                    return 1
                                else
                                    local v276 = v274 < 0
                                    if v276 then
                                        return -1
                                    else
                                        return 0
                                    end
                                end
                            end
                            local v278 = getv278()
                            local v279 = spiral_wrap_signed((v108 - v272), 32)
                            local v280 = v279 > 0
                            local getv283 = function()
                                if v280 then
                                    return 1
                                else
                                    local v281 = v279 < 0
                                    if v281 then
                                        return -1
                                    else
                                        return 0
                                    end
                                end
                            end
                            local v283 = getv283()
                            local v284 = g_clock.millis()
                            local v285 = 0
                            local v286, v287 = (table.unpack or unpack)(attempt_15(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v107, v108, v109, v110, v278, v283, v284, v285))
                            local getv329 = function()
                                local __v = { v286 }
                                if __v[1] ~= nil and __v[1].tag == "Us0_Cornered" then
                                    local v288 = spiral_wrap_signed((v260 + 1), 32)
                                    local v289 = math.fmod(v288, 50)
                                    local v290 = v289 == 1
                                    if v290 then
                                        local v291 = #(v110)
                                        local v292 = format_real_1(v107)
                                        local v293 = ""
                                        local v294 = v293 .. v292 
                                        local v295 = ","
                                        local v296 = v294 .. v295 
                                        local v297 = format_real_1(v108)
                                        local v298 = v296 .. v297 
                                        local v299 = v298 .. v295 
                                        local v300 = format_real_1(v109)
                                        local v301 = v299 .. v300 
                                        local v302 = format_real_1(v271)
                                        local v303 = v293 .. v302 
                                        local v304 = v303 .. v295 
                                        local v305 = format_real_1(v272)
                                        local v306 = v304 .. v305 
                                        local v307 = v306 .. v295 
                                        local v308 = format_real_1(v273)
                                        local v309 = v307 .. v308 
                                        local v310 = 1
                                        local v311 = around_18(v107, v108, v109, v110, v291, v310, v293)
                                        local v312 = 0
                                        local v313 = rejected_19(v107, v108, v109, v278, v283, v312, v293)
                                        local v314 = "cornered at "
                                        local v315 = v314 .. v301 
                                        local v316 = " threat "
                                        local v317 = v315 .. v316 
                                        local v318 = v317 .. v309 
                                        local v319 = " adjacent ["
                                        local v320 = v318 .. v319 
                                        local v321 = v320 .. v311 
                                        local v322 = "] candidates ["
                                        local v323 = v321 .. v322 
                                        local v324 = v323 .. v313 
                                        local v325 = "]"
                                        local v326 = v324 .. v325 
                                        local v327 = "[tibia-probe] "
                                        local v328 = v327 .. v326 
                                        TibiaProbeLog = TibiaProbeLog or {}
                                        table.insert(TibiaProbeLog, v328)
                                        g_logger.info(v328)
                                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                                    else
                                    end
                                    return { [1]=v286, [2]=v287 }
                                else
                                    return { [1]=v286, [2]=v287 }
                                end
                            end
                            local v329, v330 = (table.unpack or unpack)(getv329())
                            local __v = { v329 }
                            if __v[1] ~= nil and __v[1].tag == "Us0_Cornered" then
                                local v333 = spiral_wrap_signed((v260 + 1), 32)
                                return { [1]=false, [2]=v254, [3]=v255, [4]=v256, [5]=v257, [6]=v258, [7]=v259, [8]=v333, [9]=v261, [10]=v262, [11]=v263, [12]=v264 }
                            elseif __v[1] ~= nil and __v[1].tag == "Us0_Gated" then
                                local v332 = spiral_wrap_signed((v261 + 1), 32)
                                return { [1]=false, [2]=v254, [3]=v255, [4]=v256, [5]=v257, [6]=v258, [7]=v259, [8]=v260, [9]=v332, [10]=v262, [11]=v263, [12]=v264 }
                            elseif __v[1] ~= nil and __v[1].tag == "Us0_Stepped" then
                                local v331 = spiral_wrap_signed((v259 + 1), 32)
                                return { [1]=true, [2]=v254, [3]=v255, [4]=v256, [5]=v257, [6]=v258, [7]=v331, [8]=v260, [9]=v261, [10]=v262, [11]=v263, [12]=v330 }
                            end
                        else
                            return { [1]=false, [2]=v254, [3]=v255, [4]=v256, [5]=v257, [6]=v258, [7]=v259, [8]=v260, [9]=v261, [10]=v262, [11]=v263, [12]=v264 }
                        end
                    end
                    local v370, v371, v372, v373, v374, v375, v376, v377, v378, v379, v380, v381 = (table.unpack or unpack)(getv370())
                    if v370 then
                        return { [1]=v371, [2]=v372, [3]=v373, [4]=v374, [5]=v375, [6]=v376, [7]=v377, [8]=v378, [9]=v379, [10]=v380, [11]=v381 }
                    else
                        local v382 = (math.modf(v227 / 2))
                        local v383 = math.fmod(v382, 2)
                        local v384 = v383 == 1
                        local v385 = (v384) and (v149)
                        if v385 then
                            local v386 = v155 == 2
                            local v387 = g_game.getChaseMode() == ChaseOpponent
                            local v388 = v387 ~= v386
                            if v388 then
                                local getv391 = function()
                                    if v386 then
                                        local v389 = "on"
                                        return v389
                                    else
                                        local v390 = "off"
                                        return v390
                                    end
                                end
                                local v391 = getv391()
                                local v392 = g_clock.millis()
                                local v393 = (v6).value
                                local v394 = spiral_wrap_signed((v392 - v393), 32)
                                local v395 = "chase "
                                local v396 = v395 .. v391 
                                local v397 = " @t+"
                                local v398 = v396 .. v397 
                                local v399 = format_real_1(v394)
                                local v400 = v398 .. v399 
                                local v401 = "[tibia-probe] "
                                local v402 = v401 .. v400 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v402)
                                g_logger.info(v402)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                            else
                            end
                            do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((v386) and ChaseOpponent or DontChase) end
                            local v403 = (v110)[v150]
                            local v404 = g_game.getAttackingCreature()
                            local v405 = (v404) == (v403)
                            local v406 = v405 == false
                            if v406 then
                                g_game.attack(v403)
                                do (v8)[(v403):getId()] = (v403) end
                                local getv409 = function()
                                    if v386 then
                                        local v407 = "approach"
                                        return v407
                                    else
                                        local v408 = "strike"
                                        return v408
                                    end
                                end
                                local v409 = getv409()
                                local v410 = (v403):getName()
                                local v411 = (v403):getPosition()
                                local v412 = v411.x
                                local v413 = v411.y
                                local v414 = v411.z
                                local v415 = format_real_1(v412)
                                local v416 = ""
                                local v417 = v416 .. v415 
                                local v418 = ","
                                local v419 = v417 .. v418 
                                local v420 = format_real_1(v413)
                                local v421 = v419 .. v420 
                                local v422 = v421 .. v418 
                                local v423 = format_real_1(v414)
                                local v424 = v422 .. v423 
                                local v425 = format_real_1(v107)
                                local v426 = v416 .. v425 
                                local v427 = v426 .. v418 
                                local v428 = format_real_1(v108)
                                local v429 = v427 .. v428 
                                local v430 = v429 .. v418 
                                local v431 = format_real_1(v109)
                                local v432 = v430 .. v431 
                                local v433 = g_clock.millis()
                                local v434 = (v6).value
                                local v435 = spiral_wrap_signed((v433 - v434), 32)
                                local v436 = " "
                                local v437 = v409 .. v436 
                                local v438 = v437 .. v410 
                                local v439 = " at "
                                local v440 = v438 .. v439 
                                local v441 = v440 .. v424 
                                local v442 = " from "
                                local v443 = v441 .. v442 
                                local v444 = v443 .. v432 
                                local v445 = " health "
                                local v446 = v444 .. v445 
                                local v447 = format_real_1(v40)
                                local v448 = v446 .. v447 
                                local v449 = " @t+"
                                local v450 = v448 .. v449 
                                local v451 = format_real_1(v435)
                                local v452 = v450 .. v451 
                                local v453 = "[tibia-probe] "
                                local v454 = v453 .. v452 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v454)
                                g_logger.info(v454)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                            else
                            end
                            local v455 = spiral_wrap_signed((v373 + 1), 32)
                            return { [1]=v371, [2]=v372, [3]=v455, [4]=v374, [5]=v375, [6]=v376, [7]=v377, [8]=v378, [9]=v379, [10]=v380, [11]=v381 }
                        else
                            local v456 = g_game.isAttacking()
                            local getv458 = function()
                                if v456 then
                                    local v457 = v155 == 1
                                    return v457
                                else
                                    return false
                                end
                            end
                            local v458 = getv458()
                            if v458 then
                                g_game.cancelAttack()
                                local v459 = format_real_1(v40)
                                local v460 = "hold at health "
                                local v461 = v460 .. v459 
                                local v462 = "[tibia-probe] "
                                local v463 = v462 .. v461 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v463)
                                g_logger.info(v463)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                            else
                            end
                            local v464 = spiral_wrap_signed((v374 + 1), 32)
                            return { [1]=v371, [2]=v372, [3]=v373, [4]=v464, [5]=v375, [6]=v376, [7]=v377, [8]=v378, [9]=v379, [10]=v380, [11]=v381 }
                        end
                    end
                else
                    local v487 = v155 == 1
                    local getv493 = function()
                        if v487 then
                            return Us2_InReach()
                        else
                            local v489 = v155 == 2
                            if v489 then
                                return Us2_OutOfReach()
                            else
                                return Us2_NoTarget()
                            end
                        end
                    end
                    local v493 = getv493()
                    local getv495 = function()
                        if v157 then
                            local v494 = v40 < v0
                            return v494
                        else
                            return false
                        end
                    end
                    local v495 = getv495()
                    local getv519 = function()
                        if v495 then
                            local v496 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                            if v496 then
                                local v497 = format_real_1(v40)
                                local v498 = "heal (potion) at health "
                                local v499 = v498 .. v497 
                                local v500 = "[tibia-probe] "
                                local v501 = v500 .. v499 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v501)
                                g_logger.info(v501)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                                local v502 = spiral_wrap_signed((v16 + 1), 32)
                                return { [1]=v41, [2]=v502, [3]=v17, [4]=v18, [5]=v105, [6]=v20, [7]=v21, [8]=v22, [9]=v43, [10]=v39, [11]=v25 }
                            else
                                local v503 = format_real_1(v40)
                                local v504 = "heal dropped by the action gate at health "
                                local v505 = v504 .. v503 
                                local v506 = "[tibia-probe] "
                                local v507 = v506 .. v505 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v507)
                                g_logger.info(v507)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                                return { [1]=v41, [2]=v16, [3]=v17, [4]=v18, [5]=v105, [6]=v20, [7]=v21, [8]=v22, [9]=v43, [10]=v24, [11]=v25 }
                            end
                        else
                            return { [1]=v41, [2]=v16, [3]=v17, [4]=v18, [5]=v105, [6]=v20, [7]=v21, [8]=v22, [9]=v43, [10]=v24, [11]=v25 }
                        end
                    end
                    local v519, v520, v521, v522, v523, v524, v525, v526, v527, v528, v529 = (table.unpack or unpack)(getv519())
                    local v530 = v2 > 0
                    local getv532 = function()
                        if v530 then
                            local v531 = v163 >= v2
                            return v531
                        else
                            return false
                        end
                    end
                    local v532 = getv532()
                    local v533 = (v532) and (v170)
                    local getv635 = function()
                        if v533 then
                            local v534 = (v110)[v165]
                            local v535 = (v534):getPosition()
                            local v536 = v535.x
                            local v537 = v535.y
                            local v538 = v535.z
                            do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((false) and ChaseOpponent or DontChase) end
                            local v539 = spiral_wrap_signed((v107 - v536), 32)
                            local v540 = v539 > 0
                            local getv543 = function()
                                if v540 then
                                    return 1
                                else
                                    local v541 = v539 < 0
                                    if v541 then
                                        return -1
                                    else
                                        return 0
                                    end
                                end
                            end
                            local v543 = getv543()
                            local v544 = spiral_wrap_signed((v108 - v537), 32)
                            local v545 = v544 > 0
                            local getv548 = function()
                                if v545 then
                                    return 1
                                else
                                    local v546 = v544 < 0
                                    if v546 then
                                        return -1
                                    else
                                        return 0
                                    end
                                end
                            end
                            local v548 = getv548()
                            local v549 = g_clock.millis()
                            local v550 = 0
                            local v551, v552 = (table.unpack or unpack)(attempt_15(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v107, v108, v109, v110, v543, v548, v549, v550))
                            local getv594 = function()
                                local __v = { v551 }
                                if __v[1] ~= nil and __v[1].tag == "Us0_Cornered" then
                                    local v553 = spiral_wrap_signed((v525 + 1), 32)
                                    local v554 = math.fmod(v553, 50)
                                    local v555 = v554 == 1
                                    if v555 then
                                        local v556 = #(v110)
                                        local v557 = format_real_1(v107)
                                        local v558 = ""
                                        local v559 = v558 .. v557 
                                        local v560 = ","
                                        local v561 = v559 .. v560 
                                        local v562 = format_real_1(v108)
                                        local v563 = v561 .. v562 
                                        local v564 = v563 .. v560 
                                        local v565 = format_real_1(v109)
                                        local v566 = v564 .. v565 
                                        local v567 = format_real_1(v536)
                                        local v568 = v558 .. v567 
                                        local v569 = v568 .. v560 
                                        local v570 = format_real_1(v537)
                                        local v571 = v569 .. v570 
                                        local v572 = v571 .. v560 
                                        local v573 = format_real_1(v538)
                                        local v574 = v572 .. v573 
                                        local v575 = 1
                                        local v576 = around_18(v107, v108, v109, v110, v556, v575, v558)
                                        local v577 = 0
                                        local v578 = rejected_19(v107, v108, v109, v543, v548, v577, v558)
                                        local v579 = "cornered at "
                                        local v580 = v579 .. v566 
                                        local v581 = " threat "
                                        local v582 = v580 .. v581 
                                        local v583 = v582 .. v574 
                                        local v584 = " adjacent ["
                                        local v585 = v583 .. v584 
                                        local v586 = v585 .. v576 
                                        local v587 = "] candidates ["
                                        local v588 = v586 .. v587 
                                        local v589 = v588 .. v578 
                                        local v590 = "]"
                                        local v591 = v589 .. v590 
                                        local v592 = "[tibia-probe] "
                                        local v593 = v592 .. v591 
                                        TibiaProbeLog = TibiaProbeLog or {}
                                        table.insert(TibiaProbeLog, v593)
                                        g_logger.info(v593)
                                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                                    else
                                    end
                                    return { [1]=v551, [2]=v552 }
                                else
                                    return { [1]=v551, [2]=v552 }
                                end
                            end
                            local v594, v595 = (table.unpack or unpack)(getv594())
                            local __v = { v594 }
                            if __v[1] ~= nil and __v[1].tag == "Us0_Cornered" then
                                local v598 = spiral_wrap_signed((v525 + 1), 32)
                                return { [1]=false, [2]=v519, [3]=v520, [4]=v521, [5]=v522, [6]=v523, [7]=v524, [8]=v598, [9]=v526, [10]=v527, [11]=v528, [12]=v529 }
                            elseif __v[1] ~= nil and __v[1].tag == "Us0_Gated" then
                                local v597 = spiral_wrap_signed((v526 + 1), 32)
                                return { [1]=false, [2]=v519, [3]=v520, [4]=v521, [5]=v522, [6]=v523, [7]=v524, [8]=v525, [9]=v597, [10]=v527, [11]=v528, [12]=v529 }
                            elseif __v[1] ~= nil and __v[1].tag == "Us0_Stepped" then
                                local v596 = spiral_wrap_signed((v524 + 1), 32)
                                return { [1]=true, [2]=v519, [3]=v520, [4]=v521, [5]=v522, [6]=v523, [7]=v596, [8]=v525, [9]=v526, [10]=v527, [11]=v528, [12]=v595 }
                            end
                        else
                            return { [1]=false, [2]=v519, [3]=v520, [4]=v521, [5]=v522, [6]=v523, [7]=v524, [8]=v525, [9]=v526, [10]=v527, [11]=v528, [12]=v529 }
                        end
                    end
                    local v635, v636, v637, v638, v639, v640, v641, v642, v643, v644, v645, v646 = (table.unpack or unpack)(getv635())
                    if v635 then
                        return { [1]=v636, [2]=v637, [3]=v638, [4]=v639, [5]=v640, [6]=v641, [7]=v642, [8]=v643, [9]=v644, [10]=v645, [11]=v646 }
                    else
                        local getv658 = function()
                            local __v = { v493 }
                            if __v[1] ~= nil and __v[1].tag == "Us2_InReach" then
                                local v647 = v40 >= v1
                                if v647 then
                                    return Us3_Strike()
                                else
                                    return Us3_Hold()
                                end
                            elseif __v[1] ~= nil and __v[1].tag == "Us2_NoTarget" then
                                return Us3_Hold()
                            elseif __v[1] ~= nil and __v[1].tag == "Us2_OutOfReach" then
                                local v651 = v40 >= v1
                                if v651 then
                                    return Us3_Approach()
                                else
                                    return Us3_Hold()
                                end
                            end
                        end
                        local v658 = getv658()
                        local getv661 = function()
                            local __v = { v658 }
                            if __v[1] ~= nil and __v[1].tag == "Us3_Approach" then
                                return 2
                            elseif __v[1] ~= nil and __v[1].tag == "Us3_Hold" then
                                return 0
                            elseif __v[1] ~= nil and __v[1].tag == "Us3_Strike" then
                                return 1
                            end
                        end
                        local v661 = getv661()
                        local v662 = v661 == 1
                        local getv664 = function()
                            if v662 then
                                return true
                            else
                                local v663 = v661 == 2
                                return v663
                            end
                        end
                        local v664 = getv664()
                        if v664 then
                            local v665 = v661 == 2
                            local v666 = g_game.getChaseMode() == ChaseOpponent
                            local v667 = v666 ~= v665
                            if v667 then
                                local getv670 = function()
                                    if v665 then
                                        local v668 = "on"
                                        return v668
                                    else
                                        local v669 = "off"
                                        return v669
                                    end
                                end
                                local v670 = getv670()
                                local v671 = g_clock.millis()
                                local v672 = (v6).value
                                local v673 = spiral_wrap_signed((v671 - v672), 32)
                                local v674 = "chase "
                                local v675 = v674 .. v670 
                                local v676 = " @t+"
                                local v677 = v675 .. v676 
                                local v678 = format_real_1(v673)
                                local v679 = v677 .. v678 
                                local v680 = "[tibia-probe] "
                                local v681 = v680 .. v679 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v681)
                                g_logger.info(v681)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                            else
                            end
                            do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((v665) and ChaseOpponent or DontChase) end
                            local v682 = (v110)[v150]
                            local v683 = g_game.getAttackingCreature()
                            local v684 = (v683) == (v682)
                            local v685 = v684 == false
                            if v685 then
                                g_game.attack(v682)
                                do (v8)[(v682):getId()] = (v682) end
                                local getv688 = function()
                                    if v665 then
                                        local v686 = "approach"
                                        return v686
                                    else
                                        local v687 = "strike"
                                        return v687
                                    end
                                end
                                local v688 = getv688()
                                local v689 = (v682):getName()
                                local v690 = (v682):getPosition()
                                local v691 = v690.x
                                local v692 = v690.y
                                local v693 = v690.z
                                local v694 = format_real_1(v691)
                                local v695 = ""
                                local v696 = v695 .. v694 
                                local v697 = ","
                                local v698 = v696 .. v697 
                                local v699 = format_real_1(v692)
                                local v700 = v698 .. v699 
                                local v701 = v700 .. v697 
                                local v702 = format_real_1(v693)
                                local v703 = v701 .. v702 
                                local v704 = format_real_1(v107)
                                local v705 = v695 .. v704 
                                local v706 = v705 .. v697 
                                local v707 = format_real_1(v108)
                                local v708 = v706 .. v707 
                                local v709 = v708 .. v697 
                                local v710 = format_real_1(v109)
                                local v711 = v709 .. v710 
                                local v712 = g_clock.millis()
                                local v713 = (v6).value
                                local v714 = spiral_wrap_signed((v712 - v713), 32)
                                local v715 = " "
                                local v716 = v688 .. v715 
                                local v717 = v716 .. v689 
                                local v718 = " at "
                                local v719 = v717 .. v718 
                                local v720 = v719 .. v703 
                                local v721 = " from "
                                local v722 = v720 .. v721 
                                local v723 = v722 .. v711 
                                local v724 = " health "
                                local v725 = v723 .. v724 
                                local v726 = format_real_1(v40)
                                local v727 = v725 .. v726 
                                local v728 = " @t+"
                                local v729 = v727 .. v728 
                                local v730 = format_real_1(v714)
                                local v731 = v729 .. v730 
                                local v732 = "[tibia-probe] "
                                local v733 = v732 .. v731 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v733)
                                g_logger.info(v733)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                            else
                            end
                            local v734 = spiral_wrap_signed((v638 + 1), 32)
                            return { [1]=v636, [2]=v637, [3]=v734, [4]=v639, [5]=v640, [6]=v641, [7]=v642, [8]=v643, [9]=v644, [10]=v645, [11]=v646 }
                        else
                            local v735 = g_game.isAttacking()
                            local v736 = (v735) and (v487)
                            if v736 then
                                g_game.cancelAttack()
                                local v737 = format_real_1(v40)
                                local v738 = "hold at health "
                                local v739 = v738 .. v737 
                                local v740 = "[tibia-probe] "
                                local v741 = v740 .. v739 
                                TibiaProbeLog = TibiaProbeLog or {}
                                table.insert(TibiaProbeLog, v741)
                                g_logger.info(v741)
                                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                            else
                            end
                            local v742 = spiral_wrap_signed((v639 + 1), 32)
                            return { [1]=v636, [2]=v637, [3]=v638, [4]=v742, [5]=v640, [6]=v641, [7]=v642, [8]=v643, [9]=v644, [10]=v645, [11]=v646 }
                        end
                    end
                end
            end
            local v765, v766, v767, v768, v769, v770, v771, v772, v773, v774, v775 = (table.unpack or unpack)(getv765())
            local v776 = math.fmod(v765, 10)
            local v777 = v776 == 0
            if v777 then
                local v778 = g_game.getLocalPlayer():getPosition()
                local v779 = v778.x
                local v780 = v778.y
                local v781 = v778.z
                local v782 = format_real_1(v779)
                local v783 = "seen at "
                local v784 = v783 .. v782 
                local v785 = ","
                local v786 = v784 .. v785 
                local v787 = format_real_1(v780)
                local v788 = v786 .. v787 
                local v789 = ": "
                local v790 = v788 .. v789 
                local v791 = (function() local parts = {}; for _, c in ipairs(g_map.getSpectators({ x = v779, y = v780, z = v781 }, false)) do if c:isMonster() and not c:isDead() and c:getPosition() ~= nil then local p = c:getPosition(); table.insert(parts, string.format("%s %d%% %d,%d", c:getName(), c:getHealthPercent(), p.x, p.y)) end end; if #parts == 0 then return "none" end; return table.concat(parts, "; ") end)()
                local v792 = v790 .. v791 
                local v793 = "[tibia-probe] "
                local v794 = v793 .. v792 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v794)
                g_logger.info(v794)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v795 = math.fmod(v765, 100)
            local v796 = v795 == 0
            if v796 then
                local v797 = (function() local a = g_game.getAttackingCreature(); if not a then return "nothing" end; local p = a:getPosition(); return a:getName() .. " " .. a:getHealthPercent() .. "% at " .. string.format("%d,%d,%d", p.x, p.y, p.z) end)()
                local v798 = g_game.getLocalPlayer():getPosition()
                local v799 = v798.x
                local v800 = v798.y
                local v801 = v798.z
                local v802 = format_real_1(v799)
                local v803 = ""
                local v804 = v803 .. v802 
                local v805 = ","
                local v806 = v804 .. v805 
                local v807 = format_real_1(v800)
                local v808 = v806 .. v807 
                local v809 = v808 .. v805 
                local v810 = format_real_1(v801)
                local v811 = v809 .. v810 
                local v812 = (function() local p = g_game.getLocalPlayer(); return tostring(p.isInProtectionZone and p:isInProtectionZone() or "?") end)()
                local v813 = g_game.getLocalPlayer():getHealth()
                local v814 = g_game.getLocalPlayer():getExperience()
                local v815 = spiral_wrap_signed((v814 - v5), 32)
                local v816 = format_real_1(v765)
                local v817 = "ticks "
                local v818 = v817 .. v816 
                local v819 = " heals "
                local v820 = v818 .. v819 
                local v821 = format_real_1(v766)
                local v822 = v820 .. v821 
                local v823 = " strikes "
                local v824 = v822 .. v823 
                local v825 = format_real_1(v767)
                local v826 = v824 .. v825 
                local v827 = " holds "
                local v828 = v826 .. v827 
                local v829 = format_real_1(v768)
                local v830 = v828 .. v829 
                local v831 = " retreats "
                local v832 = v830 .. v831 
                local v833 = format_real_1(v770)
                local v834 = v832 .. v833 
                local v835 = " cornered "
                local v836 = v834 .. v835 
                local v837 = format_real_1(v771)
                local v838 = v836 .. v837 
                local v839 = " gated "
                local v840 = v838 .. v839 
                local v841 = format_real_1(v772)
                local v842 = v840 .. v841 
                local v843 = " kills "
                local v844 = v842 .. v843 
                local v845 = format_real_1(v769)
                local v846 = v844 .. v845 
                local v847 = " health "
                local v848 = v846 .. v847 
                local v849 = format_real_1(v813)
                local v850 = v848 .. v849 
                local v851 = " lowest "
                local v852 = v850 .. v851 
                local v853 = format_real_1(v773)
                local v854 = v852 .. v853 
                local v855 = " experience +"
                local v856 = v854 .. v855 
                local v857 = format_real_1(v815)
                local v858 = v856 .. v857 
                local v859 = " attacking "
                local v860 = v859 .. v797 
                local v861 = " player at "
                local v862 = v860 .. v861 
                local v863 = v862 .. v811 
                local v864 = " pz "
                local v865 = v863 .. v864 
                local v866 = v865 .. v812 
                local v867 = v858 .. v866 
                local v868 = "[tibia-probe] "
                local v869 = v868 .. v867 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v869)
                g_logger.info(v869)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
            else
            end
            local v870 = g_clock.millis()
            local v871 = (v6).value
            local v872 = spiral_wrap_signed((v870 - v871), 32)
            local v873 = "TIBIA_ARENA_RUN_MS"
            local v874 = tonumber(os.getenv(v873) or "") or (150000)
            local v875 = v872 > v874
            if v875 then
                local v876 = g_game.getLocalPlayer():getHealth()
                local v877 = g_game.getLocalPlayer():getExperience()
                local v878 = spiral_wrap_signed((v877 - v5), 32)
                local v879 = format_real_1(v765)
                local v880 = "ticks "
                local v881 = v880 .. v879 
                local v882 = " heals "
                local v883 = v881 .. v882 
                local v884 = format_real_1(v766)
                local v885 = v883 .. v884 
                local v886 = " strikes "
                local v887 = v885 .. v886 
                local v888 = format_real_1(v767)
                local v889 = v887 .. v888 
                local v890 = " holds "
                local v891 = v889 .. v890 
                local v892 = format_real_1(v768)
                local v893 = v891 .. v892 
                local v894 = " retreats "
                local v895 = v893 .. v894 
                local v896 = format_real_1(v770)
                local v897 = v895 .. v896 
                local v898 = " cornered "
                local v899 = v897 .. v898 
                local v900 = format_real_1(v771)
                local v901 = v899 .. v900 
                local v902 = " gated "
                local v903 = v901 .. v902 
                local v904 = format_real_1(v772)
                local v905 = v903 .. v904 
                local v906 = " kills "
                local v907 = v905 .. v906 
                local v908 = format_real_1(v769)
                local v909 = v907 .. v908 
                local v910 = " health "
                local v911 = v909 .. v910 
                local v912 = format_real_1(v876)
                local v913 = v911 .. v912 
                local v914 = " lowest "
                local v915 = v913 .. v914 
                local v916 = format_real_1(v773)
                local v917 = v915 .. v916 
                local v918 = " experience +"
                local v919 = v917 .. v918 
                local v920 = format_real_1(v878)
                local v921 = v919 .. v920 
                local v922 = "end: "
                local v923 = v922 .. v921 
                local v924 = "[tibia-probe] "
                local v925 = v924 .. v923 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v925)
                g_logger.info(v925)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v926 = ArenaParity and ArenaParity.summary() or ""
                local v927 = v926 ~= ""
                if v927 then
                    local v928 = v924 .. v926 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v928)
                    g_logger.info(v928)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                else
                end
                local v929 = "finish: "
                local v930 = "run complete"
                local v931 = v929 .. v930 
                local v932 = v924 .. v931 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v932)
                g_logger.info(v932)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                local v933 = g_game.isOnline()
                if v933 then
                    g_game.safeLogout()
                else
                end
                local v934 = closure8(nil)
                scheduleEvent(v934, 2000)
                return nil
            else
                local v935 = g_game.getLocalPlayer():getExperience()
                local v936 = spiral_wrap_signed((v935 - v5), 32)
                local v937 = v936 >= v7
                if v937 then
                    local v938 = g_clock.millis()
                    local v939 = (v6).value
                    local v940 = spiral_wrap_signed((v938 - v939), 32)
                    local v941 = format_real_1(v940)
                    local v942 = "cleared at "
                    local v943 = v942 .. v941 
                    local v944 = " ms"
                    local v945 = v943 .. v944 
                    local v946 = "[tibia-probe] "
                    local v947 = v946 .. v945 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v947)
                    g_logger.info(v947)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v948 = g_game.getLocalPlayer():getHealth()
                    local v949 = g_game.getLocalPlayer():getExperience()
                    local v950 = spiral_wrap_signed((v949 - v5), 32)
                    local v951 = format_real_1(v765)
                    local v952 = "ticks "
                    local v953 = v952 .. v951 
                    local v954 = " heals "
                    local v955 = v953 .. v954 
                    local v956 = format_real_1(v766)
                    local v957 = v955 .. v956 
                    local v958 = " strikes "
                    local v959 = v957 .. v958 
                    local v960 = format_real_1(v767)
                    local v961 = v959 .. v960 
                    local v962 = " holds "
                    local v963 = v961 .. v962 
                    local v964 = format_real_1(v768)
                    local v965 = v963 .. v964 
                    local v966 = " retreats "
                    local v967 = v965 .. v966 
                    local v968 = format_real_1(v770)
                    local v969 = v967 .. v968 
                    local v970 = " cornered "
                    local v971 = v969 .. v970 
                    local v972 = format_real_1(v771)
                    local v973 = v971 .. v972 
                    local v974 = " gated "
                    local v975 = v973 .. v974 
                    local v976 = format_real_1(v772)
                    local v977 = v975 .. v976 
                    local v978 = " kills "
                    local v979 = v977 .. v978 
                    local v980 = format_real_1(v769)
                    local v981 = v979 .. v980 
                    local v982 = " health "
                    local v983 = v981 .. v982 
                    local v984 = format_real_1(v948)
                    local v985 = v983 .. v984 
                    local v986 = " lowest "
                    local v987 = v985 .. v986 
                    local v988 = format_real_1(v773)
                    local v989 = v987 .. v988 
                    local v990 = " experience +"
                    local v991 = v989 .. v990 
                    local v992 = format_real_1(v950)
                    local v993 = v991 .. v992 
                    local v994 = "cleared: "
                    local v995 = v994 .. v993 
                    local v996 = v946 .. v995 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v996)
                    g_logger.info(v996)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    if v10 then
                        local v997 = (v11).value
                        local v998 = (v12).value
                        local v999 = v998
                        local v1000 = (v999 * 1000.0)
                        local v1001 = v997 > 1
                        local getv1002 = function()
                            if v1001 then
                                return v997
                            else
                                return 1
                            end
                        end
                        local v1002 = getv1002()
                        local v1003 = v1002
                        local v1004 = v1000 / v1003
                        local v1005 = format_real_1(v997)
                        local v1006 = "adjacency: "
                        local v1007 = v1006 .. v1005 
                        local v1008 = " monster-ms adjacent, "
                        local v1009 = v1007 .. v1008 
                        local v1010 = format_real_1(v998)
                        local v1011 = v1009 .. v1010 
                        local v1012 = " landed hits, "
                        local v1013 = v1011 .. v1012 
                        local v1014 = string.format("%." .. 3 .. "f", v1004)
                        local v1015 = v1013 .. v1014 
                        local v1016 = " landed hits per adjacent monster-second"
                        local v1017 = v1015 .. v1016 
                        local v1018 = v946 .. v1017 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v1018)
                        g_logger.info(v1018)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                        local v1019 = (v14)[0] or 0
                        local v1020 = (v14)[1] or 0
                        local v1021 = (v14)[2] or 0
                        local v1022 = (v14)[3] or 0
                        local v1023 = format_real_1(v1019)
                        local v1024 = "adjacent time by count: 0 "
                        local v1025 = v1024 .. v1023 
                        local v1026 = " 1 "
                        local v1027 = v1025 .. v1026 
                        local v1028 = format_real_1(v1020)
                        local v1029 = v1027 .. v1028 
                        local v1030 = " 2 "
                        local v1031 = v1029 .. v1030 
                        local v1032 = format_real_1(v1021)
                        local v1033 = v1031 .. v1032 
                        local v1034 = " 3 "
                        local v1035 = v1033 .. v1034 
                        local v1036 = format_real_1(v1022)
                        local v1037 = v1035 .. v1036 
                        local v1038 = v1037 .. v944 
                        local v1039 = v946 .. v1038 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v1039)
                        g_logger.info(v1039)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    else
                    end
                    local v1040 = ArenaParity and ArenaParity.summary() or ""
                    local v1041 = v1040 ~= ""
                    if v1041 then
                        local v1042 = v946 .. v1040 
                        TibiaProbeLog = TibiaProbeLog or {}
                        table.insert(TibiaProbeLog, v1042)
                        g_logger.info(v1042)
                        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    else
                    end
                    local v1043 = "finish: "
                    local v1044 = "cleared"
                    local v1045 = v1043 .. v1044 
                    local v1046 = v946 .. v1045 
                    TibiaProbeLog = TibiaProbeLog or {}
                    table.insert(TibiaProbeLog, v1046)
                    g_logger.info(v1046)
                    g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                    local v1047 = g_game.isOnline()
                    if v1047 then
                        g_game.safeLogout()
                    else
                    end
                    local v1048 = closure8(nil)
                    scheduleEvent(v1048, 2000)
                    return nil
                else
                    local v1049 = closure9({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v774, v775, v765, v766, v767, v768, v769, v770, v771, v772, v773 })
                    scheduleEvent(v1049, 100)
                    return nil
                end
            end
        end
    end
end

function closure7(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 = (table.unpack or unpack)(capt)
    return function(dom)
        local v14 = g_game.getLocalPlayer():getPosition()
        local v15 = v14.x
        local v16 = v14.y
        local v17 = v14.z
        local v18 = format_real_1(v15)
        local v19 = ""
        local v20 = v19 .. v18 
        local v21 = ","
        local v22 = v20 .. v21 
        local v23 = format_real_1(v16)
        local v24 = v22 .. v23 
        local v25 = v24 .. v21 
        local v26 = format_real_1(v17)
        local v27 = v25 .. v26 
        local v28 = "TIBIA_ARENA_TARGETING"
        local v29 = "current"
        local v30 = os.getenv(v28) or (v29)
        local v31 = os.time()
        local v32 = "policy starts at "
        local v33 = v32 .. v27 
        local v34 = " thresholds heal<"
        local v35 = v33 .. v34 
        local v36 = format_real_1(v0)
        local v37 = v35 .. v36 
        local v38 = " strike>="
        local v39 = v37 .. v38 
        local v40 = format_real_1(v1)
        local v41 = v39 .. v40 
        local v42 = " kite at "
        local v43 = v41 .. v42 
        local v44 = format_real_1(v3)
        local v45 = v43 .. v44 
        local v46 = " retreat at "
        local v47 = v45 .. v46 
        local v48 = format_real_1(v2)
        local v49 = v47 .. v48 
        local v50 = " targeting "
        local v51 = v49 .. v50 
        local v52 = v51 .. v30 
        local v53 = " wall "
        local v54 = v52 .. v53 
        local v55 = format_real_1(v31)
        local v56 = v54 .. v55 
        local v57 = "[tibia-probe] "
        local v58 = v57 .. v56 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v58)
        g_logger.info(v58)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v59 = g_clock.millis()
        do (v5).value = (v59) end
        local v60 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v61 = tonumber(os.getenv(v60) or "") or (90)
        local v62 = 0
        local v63 = 0
        local v64 = 0
        local v65 = 0
        local v66 = 0
        local v67 = 0
        local v68 = 0
        local v69 = 0
        local v70 = 999
        local v71 = -1000
        local v72 = 0
        return go_2(v0, v1, v2, v3, v4, v13, v5, v61, v7, v6, v8, v9, v10, v11, v12, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72)
    end
end

function closure6(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = (table.unpack or unpack)(capt)
    return function(dom)
        local v13 = g_game.getLocalPlayer():getExperience()
        do (function(mode) if g_game.getChaseMode() ~= mode then g_game.setChaseMode(mode) end end)((false) and ChaseOpponent or DontChase) end
        g_game.setFightMode(FightBalanced)
        local v14 = closure7({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 })
        scheduleEvent(v14, 1000)
        return nil
    end
end

function ready_c2(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 = (table.unpack or unpack)(capt)
    return function(dom)
        local v16 = g_game.getLocalPlayer():getName()
        local v17 = g_game.getLocalPlayer():getHealth()
        local v18 = g_game.getLocalPlayer():getMana()
        local v19 = "in game as "
        local v20 = v19 .. v16 
        local v21 = " health "
        local v22 = v20 .. v21 
        local v23 = format_real_1(v17)
        local v24 = v22 .. v23 
        local v25 = " mana "
        local v26 = v24 .. v25 
        local v27 = format_real_1(v18)
        local v28 = v26 .. v27 
        local v29 = "[tibia-probe] "
        local v30 = v29 .. v28 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v30)
        g_logger.info(v30)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v31 = g_clock.millis()
        do (v13).value = (v31) end
        local v32 = on_move_c3({ v14, v15 })
        local handler = function(c, n, o) (v32)(c)(n)(o) end; connect(Creature, { onPositionChange = handler }); connect(LocalPlayer, { onPositionChange = handler })
        local v33 = closure6({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 })
        scheduleEvent(v33, 1500)
        return nil
    end
end

function closure10(capt)
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
        local v10 = closure8(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

function closure12(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8 = (table.unpack or unpack)(capt)
    return function(v9)
        local v10 = "due to your"
        local v11 = string.find(v9, v10, 1, true) ~= nil 
        if v11 then
            local v12 = g_clock.millis()
            do (v1).value = (v12) end
        else
        end
        local v13 = g_clock.millis()
        local v14 = (v0).value
        local v15 = spiral_wrap_signed((v13 - v14), 32)
        local v16 = "server text ["
        local v17 = v16 .. v8 
        local v18 = "]: "
        local v19 = v17 .. v18 
        local v20 = v19 .. v9 
        local v21 = " @t+"
        local v22 = v20 .. v21 
        local v23 = format_real_1(v15)
        local v24 = v22 .. v23 
        local v25 = "[tibia-probe] "
        local v26 = v25 .. v24 
        TibiaProbeLog = TibiaProbeLog or {}
        table.insert(TibiaProbeLog, v26)
        g_logger.info(v26)
        g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        local v27 = g_game.getLocalPlayer():getSkillLevel(Skill.Shielding)
        local v28 = (v7).value
        local v29 = v27 ~= v28
        if v29 then
            do (v7).value = (v27) end
            local v30 = format_real_1(v27)
            local v31 = "shield skill "
            local v32 = v31 .. v30 
            local v33 = v32 .. v21 
            local v34 = format_real_1(v15)
            local v35 = v33 .. v34 
            local v36 = v25 .. v35 
            TibiaProbeLog = TibiaProbeLog or {}
            table.insert(TibiaProbeLog, v36)
            g_logger.info(v36)
            g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
        else
        end
        local getv39 = function()
            if v2 then
                local v37 = "due to an attack"
                local v38 = string.find(v9, v37, 1, true) ~= nil 
                return v38
            else
                return false
            end
        end
        local v39 = getv39()
        if v39 then
            local v40 = (v4).value
            local v41 = spiral_wrap_signed((v40 + 1), 32)
            do (v4).value = (v41) end
            local v42 = g_game.getLocalPlayer() ~= nil and g_game.isOnline()
            if v42 then
                local v43 = g_game.getLocalPlayer():getPosition()
                local v44 = v43.x
                local v45 = v43.y
                local v46 = v43.z
                local v47 = g_map.getSpectators({ x = v44, y = v45, z = v46 }, false)
                local v48 = #(v47)
                local v49 = 1
                local v50 = 0
                local v51 = count_4(v44, v45, v46, v47, v48, v49, v50)
                local v52 = format_real_1(v15)
                local v53 = "hit at "
                local v54 = v53 .. v52 
                local v55 = " ms with "
                local v56 = v54 .. v55 
                local v57 = format_real_1(v51)
                local v58 = v56 .. v57 
                local v59 = " adjacent"
                local v60 = v58 .. v59 
                local v61 = v25 .. v60 
                TibiaProbeLog = TibiaProbeLog or {}
                table.insert(TibiaProbeLog, v61)
                g_logger.info(v61)
                g_resources.writeFileContents("/tibia-probe.log", table.concat(TibiaProbeLog, string.char(10)) .. string.char(10))
                return nil
            else
            end
        else
        end
    end
end

function on_text_c11(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7 = (table.unpack or unpack)(capt)
    return function(v8)
        return closure12({ v0, v1, v2, v3, v4, v5, v6, v7, v8 })
    end
end

function closure13(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    end
end

function poll_0(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    local v26 = v0 == ""
    local getv30 = function()
        if v26 then
            return true
        else
            local v27 = "/"
            local v28 = v27 .. v0 
            local v29 = g_resources.fileExists(v28)
            return v29
        end
    end
    local v30 = getv30()
    if v30 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v31 = ready_c2({ v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 })
        local v32 = closure10(nil)
        local v33 = on_text_c11({ v2, v3, v4, v5, v6, v7, v8, v9 })
        connect(g_game, { onGameStart = v31, onLoginError = function(message) (v32)(tostring(message)) end, onTextMessage = function(mode, text) (v33)(tostring(mode))(tostring(text)) end })
        local v34 = "@god"
        local v35 = "@god\ngod"
        g_game.loginWorld(v34, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v35)
        return nil
    else
        local v36 = closure13({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 })
        scheduleEvent(v36, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 = (table.unpack or unpack)(capt)
    return function(dom)
        local v25 = "TIBIA_LOGIN_GATE"
        local v26 = ""
        local v27 = os.getenv(v25) or (v26)
        return poll_0(v27, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24)
    end
end

function closure14(capt)
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
        local v10 = closure8(nil)
        scheduleEvent(v10, 2000)
        return nil
    end
end

local v0 = "TIBIA_ARENA_HEAL_BELOW"
local v1 = tonumber(os.getenv(v0) or "") or (120)
local v2 = "TIBIA_ARENA_STRIKE_ABOVE"
local v3 = tonumber(os.getenv(v2) or "") or (40)
local v4 = "TIBIA_ARENA_RETREAT_AT"
local v5 = tonumber(os.getenv(v4) or "") or (0)
local v6 = "TIBIA_ARENA_KITE_AT"
local v7 = tonumber(os.getenv(v6) or "") or (0)
local v8 = "TIBIA_ARENA_TARGETING"
local v9 = "reach"
local v10 = os.getenv(v8) == (v9)
local v11 = { value = 0 }
local v12 = { value = -2000 }
local v13 = {}
local v14 = "TIBIA_ARENA_ADJACENCY"
local v15 = "1"
local v16 = os.getenv(v14) == (v15)
local v17 = { value = 0 }
local v18 = { value = 0 }
local v19 = { value = -1 }
local v20 = {}
local v21 = { value = 0 }
local v22 = { value = 0 }
local v23 = "TIBIA_ARENA_CHARACTER"
local v24 = "Knight Sample"
local v25 = os.getenv(v23) or (v24)
local v26 = "_1511"
local v27 = v25 .. v26 
do (function(key) local s = g_settings.getNode("bot") or {}; s[key] = { enabled = false }; g_settings.setNode("bot", s); g_settings.save() end)(v27) end
local v28 = os.getenv(v23) or (v24)
local v29 = "TIBIA_ARENA_RUN_MS"
local v30 = tonumber(os.getenv(v29) or "") or (150000)
local v31 = spiral_wrap_signed((v30 + 50000), 32)
local v32 = "TIBIA_PROBE_HIDDEN"
local v33 = os.getenv(v32) == (v15)
if v33 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
g_settings.set("enableAudio", false)
if g_sounds then g_sounds.setAudioEnabled(false); g_sounds.stopAll() end
local v34 = closure0(nil)
scheduleEvent(v34, 200)
scheduleEvent(v34, 1000)
local v35 = closure1({ v28, v11, v12, v16, v17, v18, v19, v20, v21, v1, v3, v5, v7, v10, v11, v12, v13, v16, v17, v18, v19, v20, v22, v11, v22 })
scheduleEvent(v35, 3000)
local v36 = closure14(nil)
scheduleEvent(v36, v31)
return 0
