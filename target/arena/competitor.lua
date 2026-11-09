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
local Us0_Some, Us0_None, Us1_ReachFirst, Us1_CurrentFirst, Us1_Scored, Mut0, Uh0_Cons, Mut1, Mut2, Us2_Knight, Us2_Target, Us3_Some, Us3_None, Us4_Some, Us4_None, Us5_Some, Us5_None, Us6_Stepped, Us6_Gated, Us6_Cornered, Us7_Free, Us7_Ramp, Us7_Occupied, Us7_Blocked, Us7_Unknown, Us8_InReach, Us8_OutOfReach, Us8_NoTarget, Us9_Strike, Us9_Approach, Us9_Hold, Uh1_Cons, get_environment_variable_1, method2, method3, env_i32_0, env_text_4, disable_client_bot_5, mute_6, closure0, file_exists_8, log_flush_10, write_log_line_9, closure3, typed_c2, format_real_11, player_present_12, live_monster_14, adjacent_from_13, closure5, typed_c4, labelled_15, closure9, closure8, closure7, on_position_change_16, chasing_17, parity_summary_19, method21, method22, method23, forget_dead_20, positioned_monster_25, positions_from_24, scan_sight_26, scan_threats_27, fill_28, outputs_from_29, arena_protection_zone_dy35_36, arena_protection_zone_dy36_37, arena_protection_zone_11_44, arena_protection_zone_10_43, arena_protection_zone_9_42, arena_protection_zone_8_41, arena_protection_zone_7_40, arena_protection_zone_6_39, arena_protection_zone_5_38, arena_protection_zone_4_35, arena_protection_zone_3_34, arena_protection_zone_2_33, arena_protection_zone_1_32, arena_protection_zone_31, walk_footing_47, footing_of_46, footing_at_45, diagonal_south_51, diagonal_step_50, south_or_west_step_49, step_48, near_from_52, attempt_from_30, adjacent_from_53, rejected_from_54, method56, remember_55, monster_lines_58, method59, monsters_described_57, attacking_described_60, player_zone_61, closure12, ticked_18, closure11, closure10, closure6, closure13, poll_7, closure1, closure14
function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

function Us1_ReachFirst() return { tag = "Us1_ReachFirst" } end
function Us1_CurrentFirst() return { tag = "Us1_CurrentFirst" } end
function Us1_Scored(v0, v1, v2, v3) return { tag = "Us1_Scored",  _1 = v0,  _2 = v1,  _3 = v2,  _4 = v3 } end

Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1, v2) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1,  _3 = v2 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

function Us2_Knight() return { tag = "Us2_Knight" } end
function Us2_Target() return { tag = "Us2_Target" } end

function Us3_Some(v0) return { tag = "Us3_Some",  _1 = v0 } end
function Us3_None() return { tag = "Us3_None" } end

function Us4_Some(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) return { tag = "Us4_Some",  _1 = v0,  _2 = v1,  _3 = v2,  _4 = v3,  _5 = v4,  _6 = v5,  _7 = v6,  _8 = v7,  _9 = v8,  _10 = v9,  _11 = v10 } end
function Us4_None() return { tag = "Us4_None" } end

function Us5_Some(v0, v1) return { tag = "Us5_Some",  _1 = v0,  _2 = v1 } end
function Us5_None() return { tag = "Us5_None" } end

function Us6_Stepped() return { tag = "Us6_Stepped" } end
function Us6_Gated() return { tag = "Us6_Gated" } end
function Us6_Cornered() return { tag = "Us6_Cornered" } end

function Us7_Free() return { tag = "Us7_Free" } end
function Us7_Ramp() return { tag = "Us7_Ramp" } end
function Us7_Occupied() return { tag = "Us7_Occupied" } end
function Us7_Blocked() return { tag = "Us7_Blocked" } end
function Us7_Unknown() return { tag = "Us7_Unknown" } end

function Us8_InReach() return { tag = "Us8_InReach" } end
function Us8_OutOfReach() return { tag = "Us8_OutOfReach" } end
function Us8_NoTarget() return { tag = "Us8_NoTarget" } end

function Us9_Strike() return { tag = "Us9_Strike" } end
function Us9_Approach() return { tag = "Us9_Approach" } end
function Us9_Hold() return { tag = "Us9_Hold" } end

Uh1_Nil = (function() local shared = { tag = "Uh1_Nil" } return function() return shared end end)()
function Uh1_Cons(v0, v1) return { tag = "Uh1_Cons",  _1 = v0,  _2 = v1 } end

function get_environment_variable_1(v0)
    local v1 = os.getenv(v0) or ""
    return v1
end

function method2(v0, v1, v2)
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
            return method2(v0, v1, v12)
        else
            return v2
        end
    end
end

function method3(v0, v1)
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
            return method3(v0, v3)
        else
            return v3
        end
    end
end

function env_i32_0(v0, v1)
    local v2 = get_environment_variable_1(v0)
    local v3 = string.len(v2)
    local v4 = 0
    local v5 = method2(v2, v3, v4)
    local v6 = spiral_wrap_signed((v3 - 1), 32)
    local v7 = string.sub(v2, (v5)+1, (v6)+1)
    local v8 = string.len(v7)
    local v9 = method3(v7, v8)
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

function env_text_4(v0, v1)
    local v2 = get_environment_variable_1(v0)
    local v3 = v2 == ""
    if v3 then
        return v1
    else
        return v2
    end
end

function disable_client_bot_5(v0)
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

function mute_6()
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
        return mute_6()
    end
end

function file_exists_8(v0)
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

function log_flush_10()
    local v0 = table.concat(TibiaProbeLog, string.char(10))
    local v1 = (v0 .. "\n")
    g_resources.writeFileContents("/tibia-probe.log", v1)
    return nil
end

function write_log_line_9(v0)
    local v1 = TibiaProbeLog == nil
    if v1 then
        TibiaProbeLog = {}
    else
    end
    table.insert(TibiaProbeLog, v0)
    g_logger.info(v0)
    return log_flush_10()
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
        write_log_line_9(v3)
        local v4 = "[tibia-probe] finish: game login error"
        write_log_line_9(v4)
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

function format_real_11(v0)
    local v1 = ""
    local v2 = { __tag = "Mut2", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = (v4 .. v3)
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function player_present_12()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function live_monster_14(v0)
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

function adjacent_from_13(v0, v1, v2, v3, v4, v5)
    local v6 = #(v3)
    local v7 = v4 > v6
    if v7 then
        return v5
    else
        local v8 = spiral_wrap_signed((v4 + 1), 32)
        local v9 = (v3)[v4]
        local v10 = live_monster_14(v9)
        local getv26 = function()
            if v10 then
                local v11 = (v9):getPosition()
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
                local v27 = spiral_wrap_signed((v5 + 1), 32)
                return v27
            else
                return v5
            end
        end
        local v28 = getv28()
        return adjacent_from_13(v0, v1, v2, v3, v8, v28)
    end
end

function closure5(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 = (table.unpack or unpack)(capt)
    return function(v16)
        local v17 = tostring(v15)
        local v18 = tostring(v16)
        local v19 = "due to your"
        local v20 = string.find(v18, v19, 1, true) ~= nil 
        if v20 then
            local v21 = g_clock.millis()
            v6.l0 = v21
        else
        end
        local v22 = g_clock.millis()
        local v23 = v5 ~= nil and v5.l0
        local v24 = spiral_wrap_signed((v22 - v23), 32)
        local v25 = ("server text [" .. v17)
        local v26 = (v25 .. "]: ")
        local v27 = (v26 .. v18)
        local v28 = (v27 .. " @t+")
        local v29 = format_real_11(v24)
        local v30 = (v28 .. v29)
        local v31 = ("[tibia-probe] " .. v30)
        write_log_line_9(v31)
        local v32 = g_game.getLocalPlayer():getSkillLevel(Skill.Shielding)
        local v33 = v7 ~= nil and v7.l0
        local v34 = v32 ~= v33
        if v34 then
            v7.l0 = v32
            local v35 = format_real_11(v32)
            local v36 = ("shield skill " .. v35)
            local v37 = (v36 .. " @t+")
            local v38 = format_real_11(v24)
            local v39 = (v37 .. v38)
            local v40 = ("[tibia-probe] " .. v39)
            write_log_line_9(v40)
        else
        end
        local getv43 = function()
            if v10 then
                local v41 = "due to an attack"
                local v42 = string.find(v18, v41, 1, true) ~= nil 
                return v42
            else
                return false
            end
        end
        local v43 = getv43()
        if v43 then
            local v44 = v12 ~= nil and v12.l0
            local v45 = spiral_wrap_signed((v44 + 1), 32)
            v12.l0 = v45
            local v46 = player_present_12()
            if v46 then
                local v47 = g_game.getLocalPlayer():getPosition()
                local v48 = v47.x
                local v49 = v47.y
                local v50 = v47.z
                local v51 = g_map.getSpectators({ x = v48, y = v49, z = v50 }, false)
                local v52 = 1
                local v53 = 0
                local v54 = adjacent_from_13(v48, v49, v50, v51, v52, v53)
                local v55 = format_real_11(v24)
                local v56 = ("hit at " .. v55)
                local v57 = (v56 .. " ms with ")
                local v58 = format_real_11(v54)
                local v59 = (v57 .. v58)
                local v60 = (v59 .. " adjacent")
                local v61 = ("[tibia-probe] " .. v60)
                return write_log_line_9(v61)
            else
            end
        else
        end
    end
end

function typed_c4(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = (table.unpack or unpack)(capt)
    return function(v15)
        return closure5({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 })
    end
end

function labelled_15(v0, v1, v2, v3)
    local v4 = string.len(v1)
    local v5 = v2 >= v4
    if v5 then
        return v3
    else
        local v6 = spiral_wrap_signed((v2 + 1), 32)
        local v7 = string.sub(v1, v6, v6)
        local v8 = string.lower(v7)
        local v9 = v2 > 0
        local getv11 = function()
            if v9 then
                local v10 = v8 ~= v7
                return v10
            else
                return false
            end
        end
        local v11 = getv11()
        local getv13 = function()
            if v11 then
                local v12 = (v0 .. v8)
                return v12
            else
                return v8
            end
        end
        local v13 = getv13()
        local v14 = (v3 .. v13)
        return labelled_15(v0, v1, v6, v14)
    end
end

function closure9(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 = (table.unpack or unpack)(capt)
    return function(v17)
        local v18 = (v16) ~= nil
        local getv20 = function()
            if v18 then
                local v19 = (v17) ~= nil
                return v19
            else
                return false
            end
        end
        local v20 = getv20()
        if v20 then
            local v21 = v5 ~= nil and v5.l0
            local v22 = v21 == 0
            local getv24 = function()
                if v22 then
                    local v23 = (v15):isMonster()
                    return v23
                else
                    return false
                end
            end
            local v24 = getv24()
            if v24 then
                local v25 = v16.x
                local v26 = v16.y
                local v27 = v16.z
                local v28 = (v15):getId()
                local v29 = format_real_11(v28)
                local v30 = ("monster " .. v29)
                local v31 = (v30 .. " moved to ")
                local v32 = format_real_11(v25)
                local v33 = (v31 .. v32)
                local v34 = (v33 .. ",")
                local v35 = format_real_11(v26)
                local v36 = (v34 .. v35)
                local v37 = (v36 .. " @login+")
                local v38 = g_clock.millis()
                local v39 = v8 ~= nil and v8.l0
                local v40 = spiral_wrap_signed((v38 - v39), 32)
                local v41 = format_real_11(v40)
                local v42 = (v37 .. v41)
                local v43 = ("[tibia-probe] " .. v42)
                return write_log_line_9(v43)
            else
                local v44 = v5 ~= nil and v5.l0
                local v45 = v44 > 0
                if v45 then
                    local v46 = (v15):isLocalPlayer()
                    local getv55 = function()
                        if v46 then
                            local v47 = Us2_Knight()
                            return Us3_Some(v47)
                        else
                            local v49 = g_game.getAttackingCreature()
                            local v50 = (v49) == (v15)
                            if v50 then
                                local v51 = Us2_Target()
                                return Us3_Some(v51)
                            else
                                return Us3_None()
                            end
                        end
                    end
                    local v55 = getv55()
                    if v55 ~= nil and v55.tag == "Us3_None" then
                        return nil
                    elseif v55 ~= nil and v55.tag == "Us3_Some" then
                        local v56 = v55._1
                        
                        
                        local getv57 = function()
                            if v56 ~= nil and v56.tag == "Us2_Knight" then
                                return true
                            else
                                return false
                            end
                        end
                        local v57 = getv57()
                        local getv67 = function()
                            if v57 then
                                local v58 = "_"
                                local v59 = ""
                                local v60 = "Knight"
                                local v61 = v59 == "" or v60:sub(1, #v59) == v59 
                                local getv63 = function()
                                    if v61 then
                                        local v62 = string.sub(v60, 1, 6)
                                        return v62
                                    else
                                        return v60
                                    end
                                end
                                local v63 = getv63()
                                local v64 = 0
                                return labelled_15(v58, v63, v64, v59)
                            else
                                local v66 = ""
                                return v66
                            end
                        end
                        local v67 = getv67()
                        local getv68 = function()
                            if v56 ~= nil and v56.tag == "Us2_Target" then
                                return true
                            else
                                return false
                            end
                        end
                        local v68 = getv68()
                        local getv77 = function()
                            if v68 then
                                local v69 = "_"
                                local v70 = ""
                                local v71 = "Target"
                                local v72 = v70 == "" or v71:sub(1, #v70) == v70 
                                local getv74 = function()
                                    if v72 then
                                        local v73 = string.sub(v71, 1, 6)
                                        return v73
                                    else
                                        return v71
                                    end
                                end
                                local v74 = getv74()
                                local v75 = 0
                                return labelled_15(v69, v74, v75, v70)
                            else
                                return v67
                            end
                        end
                        local v77 = getv77()
                        local v78 = v16.x
                        local v79 = v16.y
                        local v80 = v16.z
                        local v81 = (v77 .. " moved to ")
                        local v82 = format_real_11(v78)
                        local v83 = (v81 .. v82)
                        local v84 = (v83 .. ",")
                        local v85 = format_real_11(v79)
                        local v86 = (v84 .. v85)
                        local v87 = (v86 .. " @t+")
                        local v88 = g_clock.millis()
                        local v89 = v5 ~= nil and v5.l0
                        local v90 = spiral_wrap_signed((v88 - v89), 32)
                        local v91 = format_real_11(v90)
                        local v92 = (v87 .. v91)
                        local v93 = ("[tibia-probe] " .. v92)
                        return write_log_line_9(v93)
                    end
                else
                end
            end
        else
        end
    end
end

function closure8(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 = (table.unpack or unpack)(capt)
    return function(v16)
        return closure9({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 })
    end
end

function closure7(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = (table.unpack or unpack)(capt)
    return function(v15)
        return closure8({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 })
    end
end

function on_position_change_16(v0)
    local v1 = function(c, n, o) (v0)(c)(n)(o) end
    connect(Creature, { onPositionChange = v1 })
    connect(LocalPlayer, { onPositionChange = v1 })
    return nil
end

function chasing_17(v0)
    local getv3 = function()
        if v0 then
            local v1 = ChaseOpponent
            return v1
        else
            local v2 = DontChase
            return v2
        end
    end
    local v3 = getv3()
    local v4 = g_game.getChaseMode()
    local v5 = v4 ~= v3
    if v5 then
        g_game.setChaseMode(v3)
        return nil
    else
    end
end

function parity_summary_19()
    local v0 = ArenaParity ~= nil
    if v0 then
        local v1 = ArenaParity.summary()
        return v1
    else
        local v2 = ""
        return v2
    end
end

function method21(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method21(v4, v1)
        local v6 = (v3):isDead()
        if v6 then
            return Uh0_Cons(v2, v3, v5)
        else
            return v5
        end
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method22(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method22(v4, v1)
        local v6 = (v3):isDead()
        local v7 = v6 == false
        if v7 then
            return Uh0_Cons(v2, v3, v5)
        else
            return v5
        end
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method23(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = spiral_wrap_signed((v1 + 1), 32)
        return method23(v4, v5)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function forget_dead_20(v0)
    local v1 = v0 ~= nil and v0.l0
    local v2 = Uh0_Nil()
    local v3 = method21(v1, v2)
    local v4 = v0 ~= nil and v0.l0
    local v5 = Uh0_Nil()
    local v6 = method22(v4, v5)
    v0.l0 = v6
    local v7 = 0
    return method23(v3, v7)
end

function positioned_monster_25(v0)
    local v1 = (v0):isMonster()
    if v1 then
        local v2 = (v0):getPosition() ~= nil
        return v2
    else
        return false
    end
end

function positions_from_24(v0, v1, v2)
    local v3 = #(v0)
    local v4 = v1 > v3
    if v4 then
        return v2
    else
        local v5 = spiral_wrap_signed((v1 + 1), 32)
        local v6 = (v0)[v1]
        local v7 = positioned_monster_25(v6)
        local getv24 = function()
            if v7 then
                local v8 = (v6):getPosition()
                local v9 = v8.x
                local v10 = v8.y
                local v11 = v8.z
                local v12 = format_real_11(v9)
                local v13 = ("" .. v12)
                local v14 = (v13 .. ",")
                local v15 = format_real_11(v10)
                local v16 = (v14 .. v15)
                local v17 = (v16 .. ",")
                local v18 = format_real_11(v11)
                local v19 = (v17 .. v18)
                local v20 = v2 == ""
                if v20 then
                    return v19
                else
                    local v21 = (v2 .. " ")
                    local v22 = (v21 .. v19)
                    return v22
                end
            else
                return v2
            end
        end
        local v24 = getv24()
        return positions_from_24(v0, v5, v24)
    end
end

function scan_sight_26(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21)
    local v22 = #(v18)
    local v23 = v20 > v22
    if v23 then
        return v21
    else
        local v24 = spiral_wrap_signed((v20 + 1), 32)
        local v25 = (v18)[v20]
        local v26 = live_monster_14(v25)
        local getv104 = function()
            if v26 then
                local v27 = (v25):getPosition()
                local v28 = v27.x
                local v29 = v27.y
                local v30 = v27.z
                local v31 = v28 > v15
                local getv34 = function()
                    if v31 then
                        local v32 = spiral_wrap_signed((v28 - v15), 32)
                        return v32
                    else
                        local v33 = spiral_wrap_signed((v15 - v28), 32)
                        return v33
                    end
                end
                local v34 = getv34()
                local v35 = v29 > v16
                local getv38 = function()
                    if v35 then
                        local v36 = spiral_wrap_signed((v29 - v16), 32)
                        return v36
                    else
                        local v37 = spiral_wrap_signed((v16 - v29), 32)
                        return v37
                    end
                end
                local v38 = getv38()
                local v39 = v34 > v38
                local getv40 = function()
                    if v39 then
                        return v34
                    else
                        return v38
                    end
                end
                local v40 = getv40()
                local getv101 = function()
                    if v21 ~= nil and v21.tag == "Us5_None" then
                        return true
                    elseif v21 ~= nil and v21.tag == "Us5_Some" then
                        local v41 = v21._1
                        local v42 = v21._2
                        local v43 = (v25) == (v19)
                        local v44 = (v25):getHealthPercent()
                        local v45 = (v18)[v41]
                        local v46 = (v45) == (v19)
                        local v47 = (v45):getHealthPercent()
                        if v4 ~= nil and v4.tag == "Us1_CurrentFirst" then
                            local v58 = v43 ~= v46
                            if v58 then
                                return v43
                            else
                                local v59 = v40 <= 1
                                local v60 = v42 <= 1
                                local v61 = v59 ~= v60
                                if v61 then
                                    return v59
                                else
                                    local v62 = v44 ~= v47
                                    if v62 then
                                        local v63 = v44 < v47
                                        return v63
                                    else
                                        local v64 = v40 < v42
                                        return v64
                                    end
                                end
                            end
                        elseif v4 ~= nil and v4.tag == "Us1_ReachFirst" then
                            local v48 = v40 <= 1
                            local v49 = v42 <= 1
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
                                        local v54 = v40 < v42
                                        return v54
                                    end
                                end
                            end
                        elseif v4 ~= nil and v4.tag == "Us1_Scored" then
                            local v68 = v4._1
                            local v69 = v4._2
                            local v70 = v4._3
                            local v71 = v4._4
                            local getv72 = function()
                                if v43 then
                                    return v68
                                else
                                    return 0
                                end
                            end
                            local v72 = getv72()
                            local v73 = v40 <= 1
                            local getv74 = function()
                                if v73 then
                                    return v69
                                else
                                    return 0
                                end
                            end
                            local v74 = getv74()
                            local v75 = spiral_wrap_signed((v72 + v74), 32)
                            local v76 = spiral_wrap_signed(spiral_mul_mod32(v70, v44), 32)
                            local v77 = (math.modf(v76 / 100))
                            local v78 = spiral_wrap_signed((v75 + v77), 32)
                            local v79 = spiral_wrap_signed(spiral_mul_mod32(v71, v40), 32)
                            local v80 = spiral_wrap_signed((v78 + v79), 32)
                            local getv81 = function()
                                if v46 then
                                    return v68
                                else
                                    return 0
                                end
                            end
                            local v81 = getv81()
                            local v82 = v42 <= 1
                            local getv83 = function()
                                if v82 then
                                    return v69
                                else
                                    return 0
                                end
                            end
                            local v83 = getv83()
                            local v84 = spiral_wrap_signed((v81 + v83), 32)
                            local v85 = spiral_wrap_signed(spiral_mul_mod32(v70, v47), 32)
                            local v86 = (math.modf(v85 / 100))
                            local v87 = spiral_wrap_signed((v84 + v86), 32)
                            local v88 = spiral_wrap_signed(spiral_mul_mod32(v71, v42), 32)
                            local v89 = spiral_wrap_signed((v87 + v88), 32)
                            local v90 = v80 ~= v89
                            if v90 then
                                local v91 = v80 > v89
                                return v91
                            else
                                local v92 = v44 ~= v47
                                if v92 then
                                    local v93 = v44 < v47
                                    return v93
                                else
                                    local v94 = v40 < v42
                                    return v94
                                end
                            end
                        end
                    end
                end
                local v101 = getv101()
                if v101 then
                    return Us5_Some(v20, v40)
                else
                    return v21
                end
            else
                return v21
            end
        end
        local v104 = getv104()
        return scan_sight_26(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v24, v104)
    end
end

function scan_threats_27(v0, v1, v2, v3, v4, v5, v6)
    local v7 = #(v3)
    local v8 = v4 > v7
    local getv52 = function()
        if v8 then
            return { [1]=v5, [2]=v6 }
        else
            local v9 = spiral_wrap_signed((v4 + 1), 32)
            local v10 = (v3)[v4]
            local v11 = live_monster_14(v10)
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
            local getv48 = function()
                if v27 then
                    local v28 = spiral_wrap_signed((v5 + 1), 32)
                    local getv45 = function()
                        if v6 ~= nil and v6.tag == "Us0_None" then
                            return true
                        elseif v6 ~= nil and v6.tag == "Us0_Some" then
                            local v29 = v6._1
                            local v30 = (v10):getPosition()
                            local v31 = v30.x
                            local v32 = v30.y
                            local v33 = v30.z
                            local v34 = spiral_wrap_signed(spiral_mul_mod32(v31, 100000), 32)
                            local v35 = spiral_wrap_signed((v34 + v32), 32)
                            local v36 = (v3)[v29]
                            local v37 = (v36):getPosition()
                            local v38 = v37.x
                            local v39 = v37.y
                            local v40 = v37.z
                            local v41 = spiral_wrap_signed(spiral_mul_mod32(v38, 100000), 32)
                            local v42 = spiral_wrap_signed((v41 + v39), 32)
                            local v43 = v35 < v42
                            return v43
                        end
                    end
                    local v45 = getv45()
                    local getv47 = function()
                        if v45 then
                            return Us0_Some(v4)
                        else
                            return v6
                        end
                    end
                    local v47 = getv47()
                    return { [1]=v28, [2]=v47 }
                else
                    return { [1]=v5, [2]=v6 }
                end
            end
            local v48, v49 = (table.unpack or unpack)(getv48())
            local v50, v51 = (table.unpack or unpack)(scan_threats_27(v0, v1, v2, v3, v9, v48, v49))
            return { [1]=v50, [2]=v51 }
        end
    end
    local v52, v53 = (table.unpack or unpack)(getv52())
    return { [1]=v52, [2]=v53 }
end

function fill_28(v0, v1)
    local v2 = v1 < 66
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_28(v0, v3)
    else
    end
end

function outputs_from_29(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    local v12 = v8 >= 6
    local getv73 = function()
        if v12 then
            local v13 = (math.modf(v9 / 256))
            local v14 = (math.modf(v10 / 256))
            local v15 = (math.modf(v11 / 256))
            local v16 = v13 > 0
            local v17 = v14 > 0
            local getv19 = function()
                if v17 then
                    local v18 = v14 >= v15
                    return v18
                else
                    return false
                end
            end
            local v19 = getv19()
            local v20 = v15 > 0
            local getv22 = function()
                if v20 then
                    local v21 = v15 > v14
                    return v21
                else
                    return false
                end
            end
            local v22 = getv22()
            return { [1]=v16, [2]=v19, [3]=v22 }
        else
            local v23 = spiral_wrap_signed(spiral_mul_mod32(v8, 8), 32)
            local v24 = (v0)[(v23)+1]
            local v25 = spiral_wrap_signed(spiral_mul_mod32(v24, v1), 32)
            local v26 = spiral_wrap_signed((v23 + 1), 32)
            local v27 = (v0)[(v26)+1]
            local v28 = spiral_wrap_signed(spiral_mul_mod32(v27, v2), 32)
            local v29 = spiral_wrap_signed((v25 + v28), 32)
            local v30 = spiral_wrap_signed((v23 + 2), 32)
            local v31 = (v0)[(v30)+1]
            local v32 = spiral_wrap_signed(spiral_mul_mod32(v31, v3), 32)
            local v33 = spiral_wrap_signed((v29 + v32), 32)
            local v34 = spiral_wrap_signed((v23 + 3), 32)
            local v35 = (v0)[(v34)+1]
            local v36 = spiral_wrap_signed(spiral_mul_mod32(v35, v4), 32)
            local v37 = spiral_wrap_signed((v33 + v36), 32)
            local v38 = spiral_wrap_signed((v23 + 4), 32)
            local v39 = (v0)[(v38)+1]
            local v40 = spiral_wrap_signed(spiral_mul_mod32(v39, v5), 32)
            local v41 = spiral_wrap_signed((v23 + 5), 32)
            local v42 = (v0)[(v41)+1]
            local v43 = spiral_wrap_signed(spiral_mul_mod32(v42, v6), 32)
            local v44 = spiral_wrap_signed((v40 + v43), 32)
            local v45 = spiral_wrap_signed((v23 + 6), 32)
            local v46 = (v0)[(v45)+1]
            local v47 = spiral_wrap_signed(spiral_mul_mod32(v46, v7), 32)
            local v48 = spiral_wrap_signed((v44 + v47), 32)
            local v49 = spiral_wrap_signed((v23 + 7), 32)
            local v50 = (v0)[(v49)+1]
            local v51 = spiral_wrap_signed(spiral_mul_mod32(v50, 256), 32)
            local v52 = spiral_wrap_signed((v48 + v51), 32)
            local v53 = spiral_wrap_signed((v37 + v52), 32)
            local v54 = (math.modf(v53 / 256))
            local v55 = v54 > 0
            local getv56 = function()
                if v55 then
                    return v54
                else
                    return 0
                end
            end
            local v56 = getv56()
            local v57 = spiral_wrap_signed((v8 + 1), 32)
            local v58 = spiral_wrap_signed((48 + v8), 32)
            local v59 = (v0)[(v58)+1]
            local v60 = spiral_wrap_signed(spiral_mul_mod32(v59, v56), 32)
            local v61 = spiral_wrap_signed((v9 + v60), 32)
            local v62 = spiral_wrap_signed((54 + v8), 32)
            local v63 = (v0)[(v62)+1]
            local v64 = spiral_wrap_signed(spiral_mul_mod32(v63, v56), 32)
            local v65 = spiral_wrap_signed((v10 + v64), 32)
            local v66 = spiral_wrap_signed((60 + v8), 32)
            local v67 = (v0)[(v66)+1]
            local v68 = spiral_wrap_signed(spiral_mul_mod32(v67, v56), 32)
            local v69 = spiral_wrap_signed((v11 + v68), 32)
            local v70, v71, v72 = (table.unpack or unpack)(outputs_from_29(v0, v1, v2, v3, v4, v5, v6, v7, v57, v61, v65, v69))
            return { [1]=v70, [2]=v71, [3]=v72 }
        end
    end
    local v73, v74, v75 = (table.unpack or unpack)(getv73())
    return { [1]=v73, [2]=v74, [3]=v75 }
end

function arena_protection_zone_dy35_36(v0)
    local v1 = v0 >= 7
    local getv3 = function()
        if v1 then
            local v2 = v0 <= 14
            return v2
        else
            return false
        end
    end
    local v3 = getv3()
    local getv7 = function()
        if v3 then
            return true
        else
            local v4 = v0 >= 21
            if v4 then
                local v5 = v0 <= 23
                return v5
            else
                return false
            end
        end
    end
    local v7 = getv7()
    local getv11 = function()
        if v7 then
            return true
        else
            local v8 = v0 >= 25
            if v8 then
                local v9 = v0 <= 27
                return v9
            else
                return false
            end
        end
    end
    local v11 = getv11()
    local getv15 = function()
        if v11 then
            return true
        else
            local v12 = v0 >= 29
            if v12 then
                local v13 = v0 <= 31
                return v13
            else
                return false
            end
        end
    end
    local v15 = getv15()
    if v15 then
        return true
    else
        local v16 = v0 >= 33
        if v16 then
            local v17 = v0 <= 40
            return v17
        else
            return false
        end
    end
end

function arena_protection_zone_dy36_37(v0)
    local v1 = v0 >= 7
    local getv3 = function()
        if v1 then
            local v2 = v0 <= 14
            return v2
        else
            return false
        end
    end
    local v3 = getv3()
    local getv7 = function()
        if v3 then
            return true
        else
            local v4 = v0 >= 21
            if v4 then
                local v5 = v0 <= 23
                return v5
            else
                return false
            end
        end
    end
    local v7 = getv7()
    local getv11 = function()
        if v7 then
            return true
        else
            local v8 = v0 >= 25
            if v8 then
                local v9 = v0 <= 27
                return v9
            else
                return false
            end
        end
    end
    local v11 = getv11()
    local getv15 = function()
        if v11 then
            return true
        else
            local v12 = v0 >= 29
            if v12 then
                local v13 = v0 <= 31
                return v13
            else
                return false
            end
        end
    end
    local v15 = getv15()
    if v15 then
        return true
    else
        local v16 = v0 >= 33
        if v16 then
            local v17 = v0 <= 40
            return v17
        else
            return false
        end
    end
end

function arena_protection_zone_11_44(v0, v1)
    local v2 = v1 == 5
    if v2 then
        local v3 = v0 >= 33
        if v3 then
            local v4 = v0 <= 40
            return v4
        else
            return false
        end
    else
        return false
    end
end

function arena_protection_zone_10_43(v0, v1)
    local v2 = v1 == 2
    if v2 then
        local v3 = v0 >= 33
        if v3 then
            local v4 = v0 <= 40
            return v4
        else
            return false
        end
    else
        local v6 = v1 == 3
        if v6 then
            local v7 = v0 >= 33
            if v7 then
                local v8 = v0 <= 40
                return v8
            else
                return false
            end
        else
            local v10 = v1 == 4
            if v10 then
                local v11 = v0 >= 33
                if v11 then
                    local v12 = v0 <= 40
                    return v12
                else
                    return false
                end
            else
                return arena_protection_zone_11_44(v0, v1)
            end
        end
    end
end

function arena_protection_zone_9_42(v0, v1)
    local v2 = v1 == 0
    if v2 then
        local v3 = v0 >= 7
        local getv5 = function()
            if v3 then
                local v4 = v0 <= 14
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            return true
        else
            local v6 = v0 >= 21
            if v6 then
                local v7 = v0 <= 40
                return v7
            else
                return false
            end
        end
    else
        local v10 = v1 == 1
        if v10 then
            local v11 = v0 >= 8
            local getv13 = function()
                if v11 then
                    local v12 = v0 <= 14
                    return v12
                else
                    return false
                end
            end
            local v13 = getv13()
            if v13 then
                return true
            else
                local v14 = v0 >= 33
                if v14 then
                    local v15 = v0 <= 40
                    return v15
                else
                    return false
                end
            end
        else
            return arena_protection_zone_10_43(v0, v1)
        end
    end
end

function arena_protection_zone_8_41(v0, v1)
    local v2 = v1 == -2
    if v2 then
        local v3 = v0 >= 7
        local getv5 = function()
            if v3 then
                local v4 = v0 <= 14
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            return true
        else
            local v6 = v0 >= 21
            if v6 then
                local v7 = v0 <= 40
                return v7
            else
                return false
            end
        end
    else
        local v10 = v1 == -1
        if v10 then
            local v11 = v0 >= 7
            local getv13 = function()
                if v11 then
                    local v12 = v0 <= 14
                    return v12
                else
                    return false
                end
            end
            local v13 = getv13()
            if v13 then
                return true
            else
                local v14 = v0 >= 21
                if v14 then
                    local v15 = v0 <= 40
                    return v15
                else
                    return false
                end
            end
        else
            return arena_protection_zone_9_42(v0, v1)
        end
    end
end

function arena_protection_zone_7_40(v0, v1)
    local v2 = v1 == -4
    if v2 then
        local v3 = v0 >= 7
        local getv5 = function()
            if v3 then
                local v4 = v0 <= 14
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            return true
        else
            local v6 = v0 >= 21
            if v6 then
                local v7 = v0 <= 40
                return v7
            else
                return false
            end
        end
    else
        local v10 = v1 == -3
        if v10 then
            local v11 = v0 >= 7
            local getv13 = function()
                if v11 then
                    local v12 = v0 <= 14
                    return v12
                else
                    return false
                end
            end
            local v13 = getv13()
            if v13 then
                return true
            else
                local v14 = v0 >= 21
                if v14 then
                    local v15 = v0 <= 40
                    return v15
                else
                    return false
                end
            end
        else
            return arena_protection_zone_8_41(v0, v1)
        end
    end
end

function arena_protection_zone_6_39(v0, v1)
    local v2 = v1 == -6
    if v2 then
        local v3 = v0 >= 7
        local getv5 = function()
            if v3 then
                local v4 = v0 <= 14
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            return true
        else
            local v6 = v0 >= 21
            if v6 then
                local v7 = v0 <= 40
                return v7
            else
                return false
            end
        end
    else
        local v10 = v1 == -5
        if v10 then
            local v11 = v0 >= 7
            local getv13 = function()
                if v11 then
                    local v12 = v0 <= 14
                    return v12
                else
                    return false
                end
            end
            local v13 = getv13()
            if v13 then
                return true
            else
                local v14 = v0 >= 21
                if v14 then
                    local v15 = v0 <= 40
                    return v15
                else
                    return false
                end
            end
        else
            return arena_protection_zone_7_40(v0, v1)
        end
    end
end

function arena_protection_zone_5_38(v0, v1)
    local v2 = v1 == -8
    if v2 then
        local v3 = v0 >= 7
        local getv5 = function()
            if v3 then
                local v4 = v0 <= 14
                return v4
            else
                return false
            end
        end
        local v5 = getv5()
        if v5 then
            return true
        else
            local v6 = v0 >= 21
            if v6 then
                local v7 = v0 <= 40
                return v7
            else
                return false
            end
        end
    else
        local v10 = v1 == -7
        if v10 then
            local v11 = v0 >= 7
            local getv13 = function()
                if v11 then
                    local v12 = v0 <= 14
                    return v12
                else
                    return false
                end
            end
            local v13 = getv13()
            if v13 then
                return true
            else
                local v14 = v0 >= 21
                if v14 then
                    local v15 = v0 <= 40
                    return v15
                else
                    return false
                end
            end
        else
            return arena_protection_zone_6_39(v0, v1)
        end
    end
end

function arena_protection_zone_4_35(v0, v1)
    local v2 = v1 == -10
    if v2 then
        return arena_protection_zone_dy35_36(v0)
    else
        local v4 = v1 == -9
        if v4 then
            return arena_protection_zone_dy36_37(v0)
        else
            return arena_protection_zone_5_38(v0, v1)
        end
    end
end

function arena_protection_zone_3_34(v0, v1)
    local v2 = v1 == -20
    if v2 then
        local v3 = v0 >= 38
        if v3 then
            local v4 = v0 <= 45
            return v4
        else
            return false
        end
    else
        local v6 = v1 == -19
        if v6 then
            local v7 = v0 >= 38
            if v7 then
                local v8 = v0 <= 45
                return v8
            else
                return false
            end
        else
            local v10 = v1 == -18
            if v10 then
                local v11 = v0 >= 38
                if v11 then
                    local v12 = v0 <= 45
                    return v12
                else
                    return false
                end
            else
                return arena_protection_zone_4_35(v0, v1)
            end
        end
    end
end

function arena_protection_zone_2_33(v0, v1)
    local v2 = v1 == -23
    if v2 then
        local v3 = v0 >= 41
        if v3 then
            local v4 = v0 <= 45
            return v4
        else
            return false
        end
    else
        local v6 = v1 == -22
        if v6 then
            local v7 = v0 >= 41
            if v7 then
                local v8 = v0 <= 45
                return v8
            else
                return false
            end
        else
            local v10 = v1 == -21
            if v10 then
                local v11 = v0 >= 38
                if v11 then
                    local v12 = v0 <= 45
                    return v12
                else
                    return false
                end
            else
                return arena_protection_zone_3_34(v0, v1)
            end
        end
    end
end

function arena_protection_zone_1_32(v0, v1)
    local v2 = v1 == -26
    if v2 then
        local v3 = v0 >= 41
        if v3 then
            local v4 = v0 <= 45
            return v4
        else
            return false
        end
    else
        local v6 = v1 == -25
        if v6 then
            local v7 = v0 >= 41
            if v7 then
                local v8 = v0 <= 45
                return v8
            else
                return false
            end
        else
            local v10 = v1 == -24
            if v10 then
                local v11 = v0 >= 41
                if v11 then
                    local v12 = v0 <= 45
                    return v12
                else
                    return false
                end
            else
                return arena_protection_zone_2_33(v0, v1)
            end
        end
    end
end

function arena_protection_zone_31(v0, v1)
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
                return arena_protection_zone_1_32(v0, v1)
            end
        end
    end
end

function walk_footing_47(v0)
    if v0 then
        return Us7_Ramp()
    else
        return Us7_Free()
    end
end

function footing_of_46(v0, v1, v2, v3)
    local v4 = v0 == false
    if v4 then
        return Us7_Unknown()
    else
        if v1 then
            return walk_footing_47(v2)
        else
            if v3 then
                return Us7_Occupied()
            else
                return Us7_Blocked()
            end
        end
    end
end

function footing_at_45(v0, v1, v2)
    local v3 = g_map.getTile({ x = v0, y = v1, z = v2 })
    local v4 = (v3) ~= nil
    if v4 then
        local v5 = true
        local v6 = (v3):isWalkable()
        local v7 = (v3):hasFloorChange()
        local v8 = (v3):isWalkable(true)
        return footing_of_46(v5, v6, v7, v8)
    else
        return Us7_Unknown()
    end
end

function diagonal_south_51(v0, v1)
    local v2 = v0 == 1
    local getv4 = function()
        if v2 then
            local v3 = v1 == 1
            return v3
        else
            return false
        end
    end
    local v4 = getv4()
    if v4 then
        local v5 = SouthEast
        local v6 = g_game.walk(v5) ~= false
        return v6
    else
        local v7 = v0 == -1
        local getv9 = function()
            if v7 then
                local v8 = v1 == 1
                return v8
            else
                return false
            end
        end
        local v9 = getv9()
        if v9 then
            local v10 = SouthWest
            local v11 = g_game.walk(v10) ~= false
            return v11
        else
            return false
        end
    end
end

function diagonal_step_50(v0, v1)
    local v2 = v0 == 1
    local getv4 = function()
        if v2 then
            local v3 = v1 == -1
            return v3
        else
            return false
        end
    end
    local v4 = getv4()
    if v4 then
        local v5 = NorthEast
        local v6 = g_game.walk(v5) ~= false
        return v6
    else
        local v7 = v0 == -1
        local getv9 = function()
            if v7 then
                local v8 = v1 == -1
                return v8
            else
                return false
            end
        end
        local v9 = getv9()
        if v9 then
            local v10 = NorthWest
            local v11 = g_game.walk(v10) ~= false
            return v11
        else
            return diagonal_south_51(v0, v1)
        end
    end
end

function south_or_west_step_49(v0, v1)
    local v2 = v0 == 0
    local getv4 = function()
        if v2 then
            local v3 = v1 == 1
            return v3
        else
            return false
        end
    end
    local v4 = getv4()
    if v4 then
        local v5 = South
        local v6 = g_game.walk(v5) ~= false
        return v6
    else
        local v7 = v0 == -1
        local getv9 = function()
            if v7 then
                local v8 = v1 == 0
                return v8
            else
                return false
            end
        end
        local v9 = getv9()
        if v9 then
            local v10 = West
            local v11 = g_game.walk(v10) ~= false
            return v11
        else
            return diagonal_step_50(v0, v1)
        end
    end
end

function step_48(v0, v1)
    local v2 = v0 == 0
    local getv4 = function()
        if v2 then
            local v3 = v1 == -1
            return v3
        else
            return false
        end
    end
    local v4 = getv4()
    if v4 then
        local v5 = North
        local v6 = g_game.walk(v5) ~= false
        return v6
    else
        local v7 = v0 == 1
        local getv9 = function()
            if v7 then
                local v8 = v1 == 0
                return v8
            else
                return false
            end
        end
        local v9 = getv9()
        if v9 then
            local v10 = East
            local v11 = g_game.walk(v10) ~= false
            return v11
        else
            return south_or_west_step_49(v0, v1)
        end
    end
end

function near_from_52(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
    local v27 = #(v21)
    local v28 = v25 > v27
    if v28 then
        return v26
    else
        local v29 = spiral_wrap_signed((v25 + 1), 32)
        local v30 = (v21)[v25]
        local v31 = live_monster_14(v30)
        local getv47 = function()
            if v31 then
                local v32 = (v30):getPosition()
                local v33 = v32.x
                local v34 = v32.y
                local v35 = v32.z
                local v36 = v33 > v15
                local getv39 = function()
                    if v36 then
                        local v37 = spiral_wrap_signed((v33 - v15), 32)
                        return v37
                    else
                        local v38 = spiral_wrap_signed((v15 - v33), 32)
                        return v38
                    end
                end
                local v39 = getv39()
                local v40 = v34 > v16
                local getv43 = function()
                    if v40 then
                        local v41 = spiral_wrap_signed((v34 - v16), 32)
                        return v41
                    else
                        local v42 = spiral_wrap_signed((v16 - v34), 32)
                        return v42
                    end
                end
                local v43 = getv43()
                local v44 = v39 > v43
                local getv45 = function()
                    if v44 then
                        return v39
                    else
                        return v43
                    end
                end
                local v45 = getv45()
                local v46 = v45 <= 2
                return v46
            else
                return false
            end
        end
        local v47 = getv47()
        local getv64 = function()
            if v47 then
                local v48 = (v30):getPosition()
                local v49 = v48.x
                local v50 = v48.y
                local v51 = v48.z
                local v52 = format_real_11(v49)
                local v53 = ("" .. v52)
                local v54 = (v53 .. ",")
                local v55 = format_real_11(v50)
                local v56 = (v54 .. v55)
                local v57 = (v56 .. ",")
                local v58 = format_real_11(v51)
                local v59 = (v57 .. v58)
                local v60 = v26 == ""
                if v60 then
                    return v59
                else
                    local v61 = (v26 .. " ")
                    local v62 = (v61 .. v59)
                    return v62
                end
            else
                return v26
            end
        end
        local v64 = getv64()
        return near_from_52(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v29, v64)
    end
end

function attempt_from_30(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    local v26 = v25 >= 7
    if v26 then
        local v27 = Us6_Cornered()
        return { [1]=v27, [2]=0 }
    else
        local v28 = v25 == 0
        local getv53 = function()
            if v28 then
                return { [1]=v22, [2]=v23, [3]=true }
            else
                local v29 = v25 == 1
                local getv50 = function()
                    if v29 then
                        return { [1]=v22, [2]=0, [3]=true }
                    else
                        local v30 = v25 == 2
                        local getv47 = function()
                            if v30 then
                                return { [1]=0, [2]=v23, [3]=true }
                            else
                                local v31 = v25 <= 4
                                local getv44 = function()
                                    if v31 then
                                        local v32 = v25 == 3
                                        local getv35 = function()
                                            if v32 then
                                                local v33 = v22 == 0
                                                return { [1]=1, [2]=v23, [3]=v33 }
                                            else
                                                local v34 = v22 == 0
                                                return { [1]=-1, [2]=v23, [3]=v34 }
                                            end
                                        end
                                        local v35, v36, v37 = (table.unpack or unpack)(getv35())
                                        return { [1]=v35, [2]=v36, [3]=v37 }
                                    else
                                        local v38 = v25 == 5
                                        local getv41 = function()
                                            if v38 then
                                                local v39 = v23 == 0
                                                return { [1]=v22, [2]=1, [3]=v39 }
                                            else
                                                local v40 = v23 == 0
                                                return { [1]=v22, [2]=-1, [3]=v40 }
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
                return { [1]=v50, [2]=v51, [3]=v52 }
            end
        end
        local v53, v54, v55 = (table.unpack or unpack)(getv53())
        local getv59 = function()
            if v55 then
                local v56 = v53 ~= 0
                if v56 then
                    return true
                else
                    local v57 = v54 ~= 0
                    return v57
                end
            else
                return false
            end
        end
        local v59 = getv59()
        local getv69 = function()
            if v59 then
                local v60 = spiral_wrap_signed((v15 + v53), 32)
                local v61 = spiral_wrap_signed((v16 + v54), 32)
                local v62 = spiral_wrap_signed((v60 - 1933), 32)
                local v63 = spiral_wrap_signed((v61 - 1350), 32)
                local v64 = arena_protection_zone_31(v62, v63)
                local getv67 = function()
                    if v64 then
                        return Us7_Blocked()
                    else
                        return footing_at_45(v60, v61, v17)
                    end
                end
                local v67 = getv67()
                if v67 ~= nil and v67.tag == "Us7_Free" then
                    return true
                else
                    return false
                end
            else
                return false
            end
        end
        local v69 = getv69()
        if v69 then
            local v70 = step_48(v53, v54)
            if v70 then
                local v71 = g_clock.millis()
                local v72 = v6 ~= nil and v6.l0
                local v73 = spiral_wrap_signed((v71 - v72), 32)
                local v74 = format_real_11(v15)
                local v75 = ("" .. v74)
                local v76 = (v75 .. ",")
                local v77 = format_real_11(v16)
                local v78 = (v76 .. v77)
                local v79 = (v78 .. ",")
                local v80 = format_real_11(v17)
                local v81 = (v79 .. v80)
                local v82 = 1
                local v83 = ""
                local v84 = near_from_52(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v82, v83)
                local v85 = ("step away from " .. v81)
                local v86 = (v85 .. " by ")
                local v87 = format_real_11(v53)
                local v88 = (v86 .. v87)
                local v89 = (v88 .. ",")
                local v90 = format_real_11(v54)
                local v91 = (v89 .. v90)
                local v92 = (v91 .. " @t+")
                local v93 = format_real_11(v73)
                local v94 = (v92 .. v93)
                local v95 = (v94 .. " near ")
                local v96 = (v95 .. v84)
                local v97 = ("[tibia-probe] " .. v96)
                write_log_line_9(v97)
                local v98 = v53 ~= 0
                local getv100 = function()
                    if v98 then
                        local v99 = v54 ~= 0
                        return v99
                    else
                        return false
                    end
                end
                local v100 = getv100()
                local getv101 = function()
                    if v100 then
                        return 3
                    else
                        return 1
                    end
                end
                local v101 = getv101()
                local v102 = spiral_wrap_signed(spiral_mul_mod32(650, v101), 32)
                local v103 = spiral_wrap_signed((v24 + v102), 32)
                local v104 = Us6_Stepped()
                return { [1]=v104, [2]=v103 }
            else
                local v105 = Us6_Gated()
                return { [1]=v105, [2]=0 }
            end
        else
            local v108 = spiral_wrap_signed((v25 + 1), 32)
            return attempt_from_30(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v108)
        end
    end
end

function adjacent_from_53(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
    local v27 = #(v21)
    local v28 = v25 > v27
    if v28 then
        return v26
    else
        local v29 = spiral_wrap_signed((v25 + 1), 32)
        local v30 = (v21)[v25]
        local v31 = positioned_monster_25(v30)
        local getv47 = function()
            if v31 then
                local v32 = (v30):getPosition()
                local v33 = v32.x
                local v34 = v32.y
                local v35 = v32.z
                local v36 = v33 > v15
                local getv39 = function()
                    if v36 then
                        local v37 = spiral_wrap_signed((v33 - v15), 32)
                        return v37
                    else
                        local v38 = spiral_wrap_signed((v15 - v33), 32)
                        return v38
                    end
                end
                local v39 = getv39()
                local v40 = v34 > v16
                local getv43 = function()
                    if v40 then
                        local v41 = spiral_wrap_signed((v34 - v16), 32)
                        return v41
                    else
                        local v42 = spiral_wrap_signed((v16 - v34), 32)
                        return v42
                    end
                end
                local v43 = getv43()
                local v44 = v39 > v43
                local getv45 = function()
                    if v44 then
                        return v39
                    else
                        return v43
                    end
                end
                local v45 = getv45()
                local v46 = v45 <= 1
                return v46
            else
                return false
            end
        end
        local v47 = getv47()
        local getv64 = function()
            if v47 then
                local v48 = (v30):getPosition()
                local v49 = v48.x
                local v50 = v48.y
                local v51 = v48.z
                local v52 = format_real_11(v49)
                local v53 = ("" .. v52)
                local v54 = (v53 .. ",")
                local v55 = format_real_11(v50)
                local v56 = (v54 .. v55)
                local v57 = (v56 .. ",")
                local v58 = format_real_11(v51)
                local v59 = (v57 .. v58)
                local v60 = v26 == ""
                if v60 then
                    return v59
                else
                    local v61 = (v26 .. " ")
                    local v62 = (v61 .. v59)
                    return v62
                end
            else
                return v26
            end
        end
        local v64 = getv64()
        return adjacent_from_53(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v29, v64)
    end
end

function rejected_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
    local v27 = v25 >= 7
    if v27 then
        return v26
    else
        local v28 = v25 == 0
        local getv53 = function()
            if v28 then
                return { [1]=v22, [2]=v23, [3]=true }
            else
                local v29 = v25 == 1
                local getv50 = function()
                    if v29 then
                        return { [1]=v22, [2]=0, [3]=true }
                    else
                        local v30 = v25 == 2
                        local getv47 = function()
                            if v30 then
                                return { [1]=0, [2]=v23, [3]=true }
                            else
                                local v31 = v25 <= 4
                                local getv44 = function()
                                    if v31 then
                                        local v32 = v25 == 3
                                        local getv35 = function()
                                            if v32 then
                                                local v33 = v22 == 0
                                                return { [1]=1, [2]=v23, [3]=v33 }
                                            else
                                                local v34 = v22 == 0
                                                return { [1]=-1, [2]=v23, [3]=v34 }
                                            end
                                        end
                                        local v35, v36, v37 = (table.unpack or unpack)(getv35())
                                        return { [1]=v35, [2]=v36, [3]=v37 }
                                    else
                                        local v38 = v25 == 5
                                        local getv41 = function()
                                            if v38 then
                                                local v39 = v23 == 0
                                                return { [1]=v22, [2]=1, [3]=v39 }
                                            else
                                                local v40 = v23 == 0
                                                return { [1]=v22, [2]=-1, [3]=v40 }
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
                return { [1]=v50, [2]=v51, [3]=v52 }
            end
        end
        local v53, v54, v55 = (table.unpack or unpack)(getv53())
        local v56 = spiral_wrap_signed((v25 + 1), 32)
        local getv60 = function()
            if v55 then
                local v57 = v53 ~= 0
                if v57 then
                    return true
                else
                    local v58 = v54 ~= 0
                    return v58
                end
            else
                return false
            end
        end
        local v60 = getv60()
        local getv90 = function()
            if v60 then
                local v61 = spiral_wrap_signed((v15 + v53), 32)
                local v62 = spiral_wrap_signed((v16 + v54), 32)
                local v63 = spiral_wrap_signed((v61 - 1933), 32)
                local v64 = spiral_wrap_signed((v62 - 1350), 32)
                local v65 = arena_protection_zone_31(v63, v64)
                local getv78 = function()
                    if v65 then
                        local v66 = "zone"
                        return v66
                    else
                        local v67 = footing_at_45(v61, v62, v17)
                        if v67 ~= nil and v67.tag == "Us7_Blocked" then
                            local v71 = "blocked"
                            return v71
                        elseif v67 ~= nil and v67.tag == "Us7_Free" then
                            local v68 = "walk"
                            return v68
                        elseif v67 ~= nil and v67.tag == "Us7_Occupied" then
                            local v70 = "creature"
                            return v70
                        elseif v67 ~= nil and v67.tag == "Us7_Ramp" then
                            local v69 = "walk"
                            return v69
                        elseif v67 ~= nil and v67.tag == "Us7_Unknown" then
                            local v72 = "none"
                            return v72
                        end
                    end
                end
                local v78 = getv78()
                local v79 = format_real_11(v53)
                local v80 = ("" .. v79)
                local v81 = (v80 .. ",")
                local v82 = format_real_11(v54)
                local v83 = (v81 .. v82)
                local v84 = (v83 .. ":")
                local v85 = (v84 .. v78)
                local v86 = v26 == ""
                if v86 then
                    return v85
                else
                    local v87 = (v26 .. " ")
                    local v88 = (v87 .. v85)
                    return v88
                end
            else
                return v26
            end
        end
        local v90 = getv90()
        return rejected_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v56, v90)
    end
end

function method56(v0, v1, v2)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v3 = v1._1
        local v4 = v1._2
        local v5 = v1._3
        local v6 = method56(v0, v5, v2)
        local v7 = v3 ~= v0
        if v7 then
            return Uh0_Cons(v3, v4, v6)
        else
            return v6
        end
    elseif v1 ~= nil and v1.tag == "Uh0_Nil" then
        return v2
    end
end

function remember_55(v0, v1)
    local v2 = (v1):getId()
    local v3 = v0 ~= nil and v0.l0
    local v4 = Uh0_Nil()
    local v5 = method56(v2, v3, v4)
    local v6 = Uh0_Cons(v2, v1, v5)
    v0.l0 = v6
    return nil
end

function monster_lines_58(v0, v1, v2)
    local v3 = v1 < 1
    if v3 then
        return v2
    else
        local v4 = (v0)[v1]
        local v5 = spiral_wrap_signed((v1 - 1), 32)
        local v6 = live_monster_14(v4)
        local getv24 = function()
            if v6 then
                local v7 = (v4):getPosition()
                local v8 = v7.x
                local v9 = v7.y
                local v10 = v7.z
                local v11 = (v4):getName()
                local v12 = (v11 .. " ")
                local v13 = (v4):getHealthPercent()
                local v14 = format_real_11(v13)
                local v15 = (v12 .. v14)
                local v16 = (v15 .. "%")
                local v17 = (v16 .. " ")
                local v18 = format_real_11(v8)
                local v19 = (v17 .. v18)
                local v20 = (v19 .. ",")
                local v21 = format_real_11(v9)
                local v22 = (v20 .. v21)
                return Uh1_Cons(v22, v2)
            else
                return v2
            end
        end
        local v24 = getv24()
        return monster_lines_58(v0, v5, v24)
    end
end

function method59(v0, v1, v2)
    local getv12 = function()
        if v0 ~= nil and v0.tag == "Uh1_Cons" then
            local v3 = v0._1
            local v4 = v0._2
            local v5, v6 = (table.unpack or unpack)(method59(v4, v1, v2))
            local v7 = (v3 .. v6)
            local v8 = (v7 .. v5)
            local v9 = "; "
            return { [1]=v8, [2]=v9 }
        else
            local getv10 = function()
                if v0 ~= nil and v0.tag == "Uh1_Nil" then
                    return { [1]=v1, [2]=v2 }
                end
            end
            local v10, v11 = (table.unpack or unpack)(getv10())
            return { [1]=v10, [2]=v11 }
        end
    end
    local v12, v13 = (table.unpack or unpack)(getv12())
    return { [1]=v12, [2]=v13 }
end

function monsters_described_57(v0, v1, v2)
    local v3 = g_map.getSpectators({ x = v0, y = v1, z = v2 }, false)
    local v4 = #(v3)
    local v5 = Uh1_Nil()
    local v6 = monster_lines_58(v3, v4, v5)
    if v6 ~= nil and v6.tag == "Uh1_Nil" then
        local v7 = "none"
        return v7
    else
        local v8 = ""
        local v9, v10 = (table.unpack or unpack)(method59(v6, v8, v8))
        return v9
    end
end

function attacking_described_60()
    local v0 = g_game.getAttackingCreature()
    local v1 = (v0) ~= nil
    if v1 then
        local v2 = (v0):getName()
        local v3 = (v2 .. " ")
        local v4 = (v0):getHealthPercent()
        local v5 = format_real_11(v4)
        local v6 = (v3 .. v5)
        local v7 = (v6 .. "%")
        local v8 = (v7 .. " at ")
        local v9 = (v0):getPosition()
        local v10 = v9.x
        local v11 = v9.y
        local v12 = v9.z
        local v13 = format_real_11(v10)
        local v14 = ("" .. v13)
        local v15 = (v14 .. ",")
        local v16 = format_real_11(v11)
        local v17 = (v15 .. v16)
        local v18 = (v17 .. ",")
        local v19 = format_real_11(v12)
        local v20 = (v18 .. v19)
        local v21 = (v8 .. v20)
        return v21
    else
        local v22 = "nothing"
        return v22
    end
end

function player_zone_61()
    local v0 = g_game.getLocalPlayer()
    local v1 = (v0).isInProtectionZone ~= nil
    if v1 then
        local v2 = (v0):isInProtectionZone()
        if v2 then
            local v3 = "true"
            return v3
        else
            local v4 = "false"
            return v4
        end
    else
        local v6 = "?"
        return v6
    end
end

function closure12(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 = (table.unpack or unpack)(capt)
    return function(dom)
        return ticked_18(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v17, v18, v19, v20, v21, v22, v23, v24, v25, v15, v16)
    end
end

function ticked_18(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    local v26 = player_present_12()
    local v27 = v26 == false
    local getv854 = function()
        if v27 then
            local v28 = parity_summary_19()
            local v29 = v28 ~= ""
            if v29 then
                local v30 = ("[tibia-probe] " .. v28)
                write_log_line_9(v30)
            else
            end
            local v31 = "[tibia-probe] finish: offline"
            write_log_line_9(v31)
            local v32 = g_game.isOnline()
            if v32 then
                g_game.safeLogout()
            else
            end
            local v33 = closure3(nil)
            scheduleEvent(v33, 2000)
            return Us4_None()
        else
            local v35 = g_clock.millis()
            local v36 = g_game.getLocalPlayer():getHealth()
            local v37 = spiral_wrap_signed((v15 + 1), 32)
            local v38 = v36 < v23
            local getv39 = function()
                if v38 then
                    return v36
                else
                    return v23
                end
            end
            local v39 = getv39()
            local v40 = v36 <= 0
            if v40 then
                local v41 = g_game.getLocalPlayer():getHealth()
                local v42 = g_game.getLocalPlayer():getExperience()
                local v43 = spiral_wrap_signed((v42 - v5), 32)
                local v44 = format_real_11(v37)
                local v45 = ("ticks " .. v44)
                local v46 = (v45 .. " heals ")
                local v47 = format_real_11(v16)
                local v48 = (v46 .. v47)
                local v49 = (v48 .. " strikes ")
                local v50 = format_real_11(v17)
                local v51 = (v49 .. v50)
                local v52 = (v51 .. " holds ")
                local v53 = format_real_11(v18)
                local v54 = (v52 .. v53)
                local v55 = format_real_11(v20)
                local v56 = (" retreats " .. v55)
                local v57 = (v56 .. " cornered ")
                local v58 = format_real_11(v21)
                local v59 = (v57 .. v58)
                local v60 = (v59 .. " gated ")
                local v61 = format_real_11(v22)
                local v62 = (v60 .. v61)
                local v63 = (v62 .. " kills ")
                local v64 = format_real_11(v19)
                local v65 = (v63 .. v64)
                local v66 = (v54 .. v65)
                local v67 = format_real_11(v41)
                local v68 = (" health " .. v67)
                local v69 = (v68 .. " lowest ")
                local v70 = format_real_11(v39)
                local v71 = (v69 .. v70)
                local v72 = (v71 .. " experience +")
                local v73 = format_real_11(v43)
                local v74 = (v72 .. v73)
                local v75 = (v66 .. v74)
                local v76 = ("dead: " .. v75)
                local v77 = ("[tibia-probe] " .. v76)
                write_log_line_9(v77)
                local v78 = parity_summary_19()
                local v79 = v78 ~= ""
                if v79 then
                    local v80 = ("[tibia-probe] " .. v78)
                    write_log_line_9(v80)
                else
                end
                local v81 = "[tibia-probe] finish: death"
                write_log_line_9(v81)
                local v82 = g_game.isOnline()
                if v82 then
                    g_game.safeLogout()
                else
                end
                local v83 = closure3(nil)
                scheduleEvent(v83, 2000)
                return Us4_None()
            else
                local v85 = forget_dead_20(v8)
                local v86 = spiral_wrap_signed((v19 + v85), 32)
                local v87 = g_game.getLocalPlayer():getPosition()
                local v88 = v87.x
                local v89 = v87.y
                local v90 = v87.z
                local v91 = g_map.getSpectators({ x = v88, y = v89, z = v90 }, false)
                if v10 then
                    local v92 = v13 ~= nil and v13.l0
                    local v93 = v92 < 0
                    if v93 then
                        local v94 = format_real_11(v88)
                        local v95 = ("" .. v94)
                        local v96 = (v95 .. ",")
                        local v97 = format_real_11(v89)
                        local v98 = (v96 .. v97)
                        local v99 = (v98 .. ",")
                        local v100 = format_real_11(v90)
                        local v101 = (v99 .. v100)
                        local v102 = ("start positions: knight " .. v101)
                        local v103 = (v102 .. " monsters ")
                        local v104 = 1
                        local v105 = ""
                        local v106 = positions_from_24(v91, v104, v105)
                        local v107 = (v103 .. v106)
                        local v108 = ("[tibia-probe] " .. v107)
                        write_log_line_9(v108)
                    else
                        local v109 = spiral_wrap_signed((v35 - v92), 32)
                        local v110 = 1
                        local v111 = 0
                        local v112 = adjacent_from_13(v88, v89, v90, v91, v110, v111)
                        local v113 = v11 ~= nil and v11.l0
                        local v114 = spiral_wrap_signed(spiral_mul_mod32(v112, v109), 32)
                        local v115 = spiral_wrap_signed((v113 + v114), 32)
                        v11.l0 = v115
                        local v116 = v112 > 3
                        local getv117 = function()
                            if v116 then
                                return 3
                            else
                                return v112
                            end
                        end
                        local v117 = getv117()
                        local v118 = (v14)[(v117)+1]
                        local v119 = spiral_wrap_signed((v118 + v109), 32)
                        v14[(v117)+1] = v119
                    end
                    v13.l0 = v35
                else
                end
                local v120 = g_game.getAttackingCreature()
                local v121 = 1
                local v122 = Us5_None()
                local v123 = scan_sight_26(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v91, v120, v121, v122)
                local v124 = 1
                local v125 = 0
                local v126 = Us0_None()
                local v127, v128 = (table.unpack or unpack)(scan_threats_27(v88, v89, v90, v91, v124, v125, v126))
                local v129 = spiral_wrap_signed((v35 - v24), 32)
                local v130 = v129 >= 1000
                local v131 = v127 > 0
                local getv133 = function()
                    if v131 then
                        local v132 = v35 >= v25
                        return v132
                    else
                        return false
                    end
                end
                local v133 = getv133()
                local getv136 = function()
                    if v133 then
                        local v134 = g_game.getLocalPlayer():isWalking()
                        local v135 = v134 == false
                        return v135
                    else
                        return false
                    end
                end
                local v136 = getv136()
                local v137 = v3 > 0
                local getv768 = function()
                    if v137 then
                        local v138 = g_game.getLocalPlayer():getMaxHealth()
                        local v139 = spiral_wrap_signed((v0 - 1), 32)
                        local v140 = spiral_wrap_signed(spiral_mul_mod32(v139, 256), 32)
                        local v141 = (math.modf(v140 / v138))
                        local v142 = spiral_wrap_signed((v141 + 1), 32)
                        local v143 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(66)
                        local v144 = 0
                        fill_28(v143, v144)
                        v143[(0)+1] = -256
                        v143[(7)+1] = v142
                        v143[(48)+1] = 256
                        v143[(15)+1] = 256
                        v143[(55)+1] = 256
                        v143[(17)+1] = 256
                        v143[(21)+1] = -256
                        local v145 = spiral_wrap_signed((v3 - 1), 32)
                        local v146 = spiral_wrap_signed(spiral_mul_mod32(v145, 85), 32)
                        local v147 = spiral_wrap_signed(-(v146), 32)
                        v143[(23)+1] = v147
                        v143[(62)+1] = 1024
                        local v148 = spiral_wrap_signed(spiral_mul_mod32(v36, 256), 32)
                        local v149 = (math.modf(v148 / v138))
                        local getv155 = function()
                            if v123 ~= nil and v123.tag == "Us5_None" then
                                return 0
                            elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                local v150 = v123._1
                                local v151 = v123._2
                                local v152 = (v91)[v150]
                                local v153 = (v152):getHealthPercent()
                                return v153
                            end
                        end
                        local v155 = getv155()
                        local v156 = spiral_wrap_signed(spiral_mul_mod32(v155, 256), 32)
                        local v157 = (math.modf(v156 / 100))
                        local getv161 = function()
                            if v123 ~= nil and v123.tag == "Us5_None" then
                                return 0
                            elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                local v158 = v123._1
                                local v159 = v123._2
                                return v159
                            end
                        end
                        local v161 = getv161()
                        local v162 = v9 ~= nil and v9.l0
                        local v163 = spiral_wrap_signed((v35 - v162), 32)
                        local v164 = v163 >= 2000
                        local getv165 = function()
                            if v130 then
                                return 256
                            else
                                return 0
                            end
                        end
                        local v165 = getv165()
                        local getv166 = function()
                            if v164 then
                                return 256
                            else
                                return 0
                            end
                        end
                        local v166 = getv166()
                        local v167 = spiral_wrap_signed(spiral_mul_mod32(v127, 85), 32)
                        local v168 = v161 > 7
                        local getv169 = function()
                            if v168 then
                                return 7
                            else
                                return v161
                            end
                        end
                        local v169 = getv169()
                        local v170 = spiral_wrap_signed(spiral_mul_mod32(v169, 32), 32)
                        local v171 = 0
                        local v172 = 0
                        local v173 = 0
                        local v174 = 0
                        local v175 = 0
                        local v176, v177, v178 = (table.unpack or unpack)(outputs_from_29(v143, v149, v167, v157, v170, v165, v166, v171, v172, v173, v174, v175))
                        local getv179 = function()
                            if v176 then
                                return 1
                            else
                                return 0
                            end
                        end
                        local v179 = getv179()
                        local getv180 = function()
                            if v177 then
                                return 2
                            else
                                return 0
                            end
                        end
                        local v180 = getv180()
                        local v181 = spiral_wrap_signed((v179 + v180), 32)
                        local getv182 = function()
                            if v178 then
                                return 4
                            else
                                return 0
                            end
                        end
                        local v182 = getv182()
                        local v183 = spiral_wrap_signed((v181 + v182), 32)
                        local v184 = math.fmod(v183, 2)
                        local v185 = v184 == 1
                        local v186 = (v185) and (v130)
                        local getv206 = function()
                            if v186 then
                                local v187 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                                local getv190 = function()
                                    if v187 then
                                        local v188 = "heal (potion) at health "
                                        return v188
                                    else
                                        local v189 = "heal dropped by the action gate at health "
                                        return v189
                                    end
                                end
                                local v190 = getv190()
                                local v191 = format_real_11(v36)
                                local v192 = (v190 .. v191)
                                local v193 = ("[tibia-probe] " .. v192)
                                write_log_line_9(v193)
                                if v187 then
                                    local v194 = spiral_wrap_signed((v16 + 1), 32)
                                    return { [1]=v37, [2]=v194, [3]=v17, [4]=v18, [5]=v86, [6]=v20, [7]=v21, [8]=v22, [9]=v39, [10]=v35, [11]=v25 }
                                else
                                    return { [1]=v37, [2]=v16, [3]=v17, [4]=v18, [5]=v86, [6]=v20, [7]=v21, [8]=v22, [9]=v39, [10]=v24, [11]=v25 }
                                end
                            else
                                return { [1]=v37, [2]=v16, [3]=v17, [4]=v18, [5]=v86, [6]=v20, [7]=v21, [8]=v22, [9]=v39, [10]=v24, [11]=v25 }
                            end
                        end
                        local v206, v207, v208, v209, v210, v211, v212, v213, v214, v215, v216 = (table.unpack or unpack)(getv206())
                        local v217 = (math.modf(v183 / 4))
                        local v218 = math.fmod(v217, 2)
                        local v219 = v218 == 1
                        local v220 = (v219) and (v136)
                        local getv340 = function()
                            if v220 then
                                if v128 ~= nil and v128.tag == "Us0_None" then
                                    return { [1]=false, [2]=v206, [3]=v207, [4]=v208, [5]=v209, [6]=v210, [7]=v211, [8]=v212, [9]=v213, [10]=v214, [11]=v215, [12]=v216 }
                                elseif v128 ~= nil and v128.tag == "Us0_Some" then
                                    local v221 = v128._1
                                    local v222 = (v91)[v221]
                                    local v223 = (v222):getPosition()
                                    local v224 = v223.x
                                    local v225 = v223.y
                                    local v226 = v223.z
                                    local v227 = false
                                    chasing_17(v227)
                                    local v228 = spiral_wrap_signed((v88 - v224), 32)
                                    local v229 = v228 > 0
                                    local getv232 = function()
                                        if v229 then
                                            return 1
                                        else
                                            local v230 = v228 < 0
                                            if v230 then
                                                return -1
                                            else
                                                return 0
                                            end
                                        end
                                    end
                                    local v232 = getv232()
                                    local v233 = spiral_wrap_signed((v89 - v225), 32)
                                    local v234 = v233 > 0
                                    local getv237 = function()
                                        if v234 then
                                            return 1
                                        else
                                            local v235 = v233 < 0
                                            if v235 then
                                                return -1
                                            else
                                                return 0
                                            end
                                        end
                                    end
                                    local v237 = getv237()
                                    local v238 = g_clock.millis()
                                    local v239 = 0
                                    local v240, v241 = (table.unpack or unpack)(attempt_from_30(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v224, v225, v226, v91, v232, v237, v238, v239))
                                    local getv242 = function()
                                        if v240 ~= nil and v240.tag == "Us6_Cornered" then
                                            return true
                                        else
                                            return false
                                        end
                                    end
                                    local v242 = getv242()
                                    local getv246 = function()
                                        if v242 then
                                            local v243 = spiral_wrap_signed((v212 + 1), 32)
                                            local v244 = math.fmod(v243, 50)
                                            local v245 = v244 == 1
                                            return v245
                                        else
                                            return false
                                        end
                                    end
                                    local v246 = getv246()
                                    if v246 then
                                        local v247 = format_real_11(v88)
                                        local v248 = ("" .. v247)
                                        local v249 = (v248 .. ",")
                                        local v250 = format_real_11(v89)
                                        local v251 = (v249 .. v250)
                                        local v252 = (v251 .. ",")
                                        local v253 = format_real_11(v90)
                                        local v254 = (v252 .. v253)
                                        local v255 = ("cornered at " .. v254)
                                        local v256 = (v255 .. " threat ")
                                        local v257 = format_real_11(v224)
                                        local v258 = ("" .. v257)
                                        local v259 = (v258 .. ",")
                                        local v260 = format_real_11(v225)
                                        local v261 = (v259 .. v260)
                                        local v262 = (v261 .. ",")
                                        local v263 = format_real_11(v226)
                                        local v264 = (v262 .. v263)
                                        local v265 = (v256 .. v264)
                                        local v266 = 1
                                        local v267 = ""
                                        local v268 = adjacent_from_53(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v224, v225, v226, v91, v232, v237, v238, v266, v267)
                                        local v269 = 0
                                        local v270 = rejected_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v224, v225, v226, v91, v232, v237, v238, v269, v267)
                                        local v271 = (v265 .. " adjacent [")
                                        local v272 = (v271 .. v268)
                                        local v273 = (v272 .. "] candidates [")
                                        local v274 = (v273 .. v270)
                                        local v275 = (v274 .. "]")
                                        local v276 = ("[tibia-probe] " .. v275)
                                        write_log_line_9(v276)
                                    else
                                    end
                                    if v240 ~= nil and v240.tag == "Us6_Cornered" then
                                        local v279 = spiral_wrap_signed((v212 + 1), 32)
                                        return { [1]=false, [2]=v206, [3]=v207, [4]=v208, [5]=v209, [6]=v210, [7]=v211, [8]=v279, [9]=v213, [10]=v214, [11]=v215, [12]=v216 }
                                    elseif v240 ~= nil and v240.tag == "Us6_Gated" then
                                        local v278 = spiral_wrap_signed((v213 + 1), 32)
                                        return { [1]=false, [2]=v206, [3]=v207, [4]=v208, [5]=v209, [6]=v210, [7]=v211, [8]=v212, [9]=v278, [10]=v214, [11]=v215, [12]=v216 }
                                    elseif v240 ~= nil and v240.tag == "Us6_Stepped" then
                                        local v277 = spiral_wrap_signed((v211 + 1), 32)
                                        return { [1]=true, [2]=v206, [3]=v207, [4]=v208, [5]=v209, [6]=v210, [7]=v277, [8]=v212, [9]=v213, [10]=v214, [11]=v215, [12]=v241 }
                                    end
                                end
                            else
                                return { [1]=false, [2]=v206, [3]=v207, [4]=v208, [5]=v209, [6]=v210, [7]=v211, [8]=v212, [9]=v213, [10]=v214, [11]=v215, [12]=v216 }
                            end
                        end
                        local v340, v341, v342, v343, v344, v345, v346, v347, v348, v349, v350, v351 = (table.unpack or unpack)(getv340())
                        if v340 then
                            return { [1]=v341, [2]=v342, [3]=v343, [4]=v344, [5]=v345, [6]=v346, [7]=v347, [8]=v348, [9]=v349, [10]=v350, [11]=v351 }
                        else
                            local getv360 = function()
                                if v123 ~= nil and v123.tag == "Us5_None" then
                                    return Us8_NoTarget()
                                elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                    local v352 = v123._1
                                    local v353 = v123._2
                                    local v354 = v353 <= 1
                                    if v354 then
                                        return Us8_InReach()
                                    else
                                        return Us8_OutOfReach()
                                    end
                                end
                            end
                            local v360 = getv360()
                            local v361 = (math.modf(v183 / 2))
                            local v362 = math.fmod(v361, 2)
                            local v363 = v362 == 1
                            local getv366 = function()
                                if v363 then
                                    local getv364 = function()
                                        if v360 ~= nil and v360.tag == "Us8_NoTarget" then
                                            return true
                                        else
                                            return false
                                        end
                                    end
                                    local v364 = getv364()
                                    local v365 = v364 ~= true
                                    return v365
                                else
                                    return false
                                end
                            end
                            local v366 = getv366()
                            if v366 then
                                local getv367 = function()
                                    if v360 ~= nil and v360.tag == "Us8_OutOfReach" then
                                        return true
                                    else
                                        return false
                                    end
                                end
                                local v367 = getv367()
                                local v368 = g_game.getChaseMode() == ChaseOpponent
                                local v369 = v368 ~= v367
                                if v369 then
                                    local getv372 = function()
                                        if v367 then
                                            local v370 = "on"
                                            return v370
                                        else
                                            local v371 = "off"
                                            return v371
                                        end
                                    end
                                    local v372 = getv372()
                                    local v373 = g_clock.millis()
                                    local v374 = v6 ~= nil and v6.l0
                                    local v375 = spiral_wrap_signed((v373 - v374), 32)
                                    local v376 = ("chase " .. v372)
                                    local v377 = (v376 .. " @t+")
                                    local v378 = format_real_11(v375)
                                    local v379 = (v377 .. v378)
                                    local v380 = ("[tibia-probe] " .. v379)
                                    write_log_line_9(v380)
                                else
                                end
                                chasing_17(v367)
                                if v123 ~= nil and v123.tag == "Us5_None" then
                                elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                    local v381 = v123._1
                                    local v382 = v123._2
                                    local v383 = (v91)[v381]
                                    local v384 = g_game.getAttackingCreature()
                                    local v385 = (v384) == (v383)
                                    local v386 = v385 == false
                                    if v386 then
                                        g_game.attack(v383)
                                        remember_55(v8, v383)
                                        local getv389 = function()
                                            if v367 then
                                                local v387 = "approach"
                                                return v387
                                            else
                                                local v388 = "strike"
                                                return v388
                                            end
                                        end
                                        local v389 = getv389()
                                        local v390 = (v383):getName()
                                        local v391 = (v389 .. " ")
                                        local v392 = (v391 .. v390)
                                        local v393 = (v383):getPosition()
                                        local v394 = v393.x
                                        local v395 = v393.y
                                        local v396 = v393.z
                                        local v397 = format_real_11(v394)
                                        local v398 = ("" .. v397)
                                        local v399 = (v398 .. ",")
                                        local v400 = format_real_11(v395)
                                        local v401 = (v399 .. v400)
                                        local v402 = (v401 .. ",")
                                        local v403 = format_real_11(v396)
                                        local v404 = (v402 .. v403)
                                        local v405 = (" at " .. v404)
                                        local v406 = (v405 .. " from ")
                                        local v407 = format_real_11(v88)
                                        local v408 = ("" .. v407)
                                        local v409 = (v408 .. ",")
                                        local v410 = format_real_11(v89)
                                        local v411 = (v409 .. v410)
                                        local v412 = (v411 .. ",")
                                        local v413 = format_real_11(v90)
                                        local v414 = (v412 .. v413)
                                        local v415 = (v406 .. v414)
                                        local v416 = (v392 .. v415)
                                        local v417 = g_clock.millis()
                                        local v418 = v6 ~= nil and v6.l0
                                        local v419 = spiral_wrap_signed((v417 - v418), 32)
                                        local v420 = (v416 .. " health ")
                                        local v421 = format_real_11(v36)
                                        local v422 = (v420 .. v421)
                                        local v423 = (v422 .. " @t+")
                                        local v424 = format_real_11(v419)
                                        local v425 = (v423 .. v424)
                                        local v426 = ("[tibia-probe] " .. v425)
                                        write_log_line_9(v426)
                                    else
                                    end
                                end
                                local v427 = spiral_wrap_signed((v343 + 1), 32)
                                return { [1]=v341, [2]=v342, [3]=v427, [4]=v344, [5]=v345, [6]=v346, [7]=v347, [8]=v348, [9]=v349, [10]=v350, [11]=v351 }
                            else
                                local v428 = g_game.isAttacking()
                                local getv439 = function()
                                    if v428 then
                                        local getv437 = function()
                                            if v123 ~= nil and v123.tag == "Us5_None" then
                                                return Us8_NoTarget()
                                            elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                                local v429 = v123._1
                                                local v430 = v123._2
                                                local v431 = v430 <= 1
                                                if v431 then
                                                    return Us8_InReach()
                                                else
                                                    return Us8_OutOfReach()
                                                end
                                            end
                                        end
                                        local v437 = getv437()
                                        if v437 ~= nil and v437.tag == "Us8_InReach" then
                                            return true
                                        else
                                            return false
                                        end
                                    else
                                        return false
                                    end
                                end
                                local v439 = getv439()
                                if v439 then
                                    g_game.cancelAttack()
                                    local v440 = format_real_11(v36)
                                    local v441 = ("hold at health " .. v440)
                                    local v442 = ("[tibia-probe] " .. v441)
                                    write_log_line_9(v442)
                                else
                                end
                                local v443 = spiral_wrap_signed((v344 + 1), 32)
                                return { [1]=v341, [2]=v342, [3]=v343, [4]=v443, [5]=v345, [6]=v346, [7]=v347, [8]=v348, [9]=v349, [10]=v350, [11]=v351 }
                            end
                        end
                    else
                        local getv476 = function()
                            if v130 then
                                local v475 = v36 < v0
                                return v475
                            else
                                return false
                            end
                        end
                        local v476 = getv476()
                        local getv496 = function()
                            if v476 then
                                local v477 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                                local getv480 = function()
                                    if v477 then
                                        local v478 = "heal (potion) at health "
                                        return v478
                                    else
                                        local v479 = "heal dropped by the action gate at health "
                                        return v479
                                    end
                                end
                                local v480 = getv480()
                                local v481 = format_real_11(v36)
                                local v482 = (v480 .. v481)
                                local v483 = ("[tibia-probe] " .. v482)
                                write_log_line_9(v483)
                                if v477 then
                                    local v484 = spiral_wrap_signed((v16 + 1), 32)
                                    return { [1]=v37, [2]=v484, [3]=v17, [4]=v18, [5]=v86, [6]=v20, [7]=v21, [8]=v22, [9]=v39, [10]=v35, [11]=v25 }
                                else
                                    return { [1]=v37, [2]=v16, [3]=v17, [4]=v18, [5]=v86, [6]=v20, [7]=v21, [8]=v22, [9]=v39, [10]=v24, [11]=v25 }
                                end
                            else
                                return { [1]=v37, [2]=v16, [3]=v17, [4]=v18, [5]=v86, [6]=v20, [7]=v21, [8]=v22, [9]=v39, [10]=v24, [11]=v25 }
                            end
                        end
                        local v496, v497, v498, v499, v500, v501, v502, v503, v504, v505, v506 = (table.unpack or unpack)(getv496())
                        local v507 = v2 > 0
                        local getv509 = function()
                            if v507 then
                                local v508 = v127 >= v2
                                return v508
                            else
                                return false
                            end
                        end
                        local v509 = getv509()
                        local v510 = (v509) and (v136)
                        local getv630 = function()
                            if v510 then
                                if v128 ~= nil and v128.tag == "Us0_None" then
                                    return { [1]=false, [2]=v496, [3]=v497, [4]=v498, [5]=v499, [6]=v500, [7]=v501, [8]=v502, [9]=v503, [10]=v504, [11]=v505, [12]=v506 }
                                elseif v128 ~= nil and v128.tag == "Us0_Some" then
                                    local v511 = v128._1
                                    local v512 = (v91)[v511]
                                    local v513 = (v512):getPosition()
                                    local v514 = v513.x
                                    local v515 = v513.y
                                    local v516 = v513.z
                                    local v517 = false
                                    chasing_17(v517)
                                    local v518 = spiral_wrap_signed((v88 - v514), 32)
                                    local v519 = v518 > 0
                                    local getv522 = function()
                                        if v519 then
                                            return 1
                                        else
                                            local v520 = v518 < 0
                                            if v520 then
                                                return -1
                                            else
                                                return 0
                                            end
                                        end
                                    end
                                    local v522 = getv522()
                                    local v523 = spiral_wrap_signed((v89 - v515), 32)
                                    local v524 = v523 > 0
                                    local getv527 = function()
                                        if v524 then
                                            return 1
                                        else
                                            local v525 = v523 < 0
                                            if v525 then
                                                return -1
                                            else
                                                return 0
                                            end
                                        end
                                    end
                                    local v527 = getv527()
                                    local v528 = g_clock.millis()
                                    local v529 = 0
                                    local v530, v531 = (table.unpack or unpack)(attempt_from_30(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v514, v515, v516, v91, v522, v527, v528, v529))
                                    local getv532 = function()
                                        if v530 ~= nil and v530.tag == "Us6_Cornered" then
                                            return true
                                        else
                                            return false
                                        end
                                    end
                                    local v532 = getv532()
                                    local getv536 = function()
                                        if v532 then
                                            local v533 = spiral_wrap_signed((v502 + 1), 32)
                                            local v534 = math.fmod(v533, 50)
                                            local v535 = v534 == 1
                                            return v535
                                        else
                                            return false
                                        end
                                    end
                                    local v536 = getv536()
                                    if v536 then
                                        local v537 = format_real_11(v88)
                                        local v538 = ("" .. v537)
                                        local v539 = (v538 .. ",")
                                        local v540 = format_real_11(v89)
                                        local v541 = (v539 .. v540)
                                        local v542 = (v541 .. ",")
                                        local v543 = format_real_11(v90)
                                        local v544 = (v542 .. v543)
                                        local v545 = ("cornered at " .. v544)
                                        local v546 = (v545 .. " threat ")
                                        local v547 = format_real_11(v514)
                                        local v548 = ("" .. v547)
                                        local v549 = (v548 .. ",")
                                        local v550 = format_real_11(v515)
                                        local v551 = (v549 .. v550)
                                        local v552 = (v551 .. ",")
                                        local v553 = format_real_11(v516)
                                        local v554 = (v552 .. v553)
                                        local v555 = (v546 .. v554)
                                        local v556 = 1
                                        local v557 = ""
                                        local v558 = adjacent_from_53(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v514, v515, v516, v91, v522, v527, v528, v556, v557)
                                        local v559 = 0
                                        local v560 = rejected_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v88, v89, v90, v514, v515, v516, v91, v522, v527, v528, v559, v557)
                                        local v561 = (v555 .. " adjacent [")
                                        local v562 = (v561 .. v558)
                                        local v563 = (v562 .. "] candidates [")
                                        local v564 = (v563 .. v560)
                                        local v565 = (v564 .. "]")
                                        local v566 = ("[tibia-probe] " .. v565)
                                        write_log_line_9(v566)
                                    else
                                    end
                                    if v530 ~= nil and v530.tag == "Us6_Cornered" then
                                        local v569 = spiral_wrap_signed((v502 + 1), 32)
                                        return { [1]=false, [2]=v496, [3]=v497, [4]=v498, [5]=v499, [6]=v500, [7]=v501, [8]=v569, [9]=v503, [10]=v504, [11]=v505, [12]=v506 }
                                    elseif v530 ~= nil and v530.tag == "Us6_Gated" then
                                        local v568 = spiral_wrap_signed((v503 + 1), 32)
                                        return { [1]=false, [2]=v496, [3]=v497, [4]=v498, [5]=v499, [6]=v500, [7]=v501, [8]=v502, [9]=v568, [10]=v504, [11]=v505, [12]=v506 }
                                    elseif v530 ~= nil and v530.tag == "Us6_Stepped" then
                                        local v567 = spiral_wrap_signed((v501 + 1), 32)
                                        return { [1]=true, [2]=v496, [3]=v497, [4]=v498, [5]=v499, [6]=v500, [7]=v567, [8]=v502, [9]=v503, [10]=v504, [11]=v505, [12]=v531 }
                                    end
                                end
                            else
                                return { [1]=false, [2]=v496, [3]=v497, [4]=v498, [5]=v499, [6]=v500, [7]=v501, [8]=v502, [9]=v503, [10]=v504, [11]=v505, [12]=v506 }
                            end
                        end
                        local v630, v631, v632, v633, v634, v635, v636, v637, v638, v639, v640, v641 = (table.unpack or unpack)(getv630())
                        if v630 then
                            return { [1]=v631, [2]=v632, [3]=v633, [4]=v634, [5]=v635, [6]=v636, [7]=v637, [8]=v638, [9]=v639, [10]=v640, [11]=v641 }
                        else
                            local getv650 = function()
                                if v123 ~= nil and v123.tag == "Us5_None" then
                                    return Us8_NoTarget()
                                elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                    local v642 = v123._1
                                    local v643 = v123._2
                                    local v644 = v643 <= 1
                                    if v644 then
                                        return Us8_InReach()
                                    else
                                        return Us8_OutOfReach()
                                    end
                                end
                            end
                            local v650 = getv650()
                            local getv662 = function()
                                if v650 ~= nil and v650.tag == "Us8_InReach" then
                                    local v651 = v36 >= v1
                                    if v651 then
                                        return Us9_Strike()
                                    else
                                        return Us9_Hold()
                                    end
                                elseif v650 ~= nil and v650.tag == "Us8_NoTarget" then
                                    return Us9_Hold()
                                elseif v650 ~= nil and v650.tag == "Us8_OutOfReach" then
                                    local v655 = v36 >= v1
                                    if v655 then
                                        return Us9_Approach()
                                    else
                                        return Us9_Hold()
                                    end
                                end
                            end
                            local v662 = getv662()
                            local getv665 = function()
                                if v662 ~= nil and v662.tag == "Us9_Approach" then
                                    return 2
                                elseif v662 ~= nil and v662.tag == "Us9_Hold" then
                                    return 0
                                elseif v662 ~= nil and v662.tag == "Us9_Strike" then
                                    return 1
                                end
                            end
                            local v665 = getv665()
                            local v666 = v665 == 1
                            local getv668 = function()
                                if v666 then
                                    return true
                                else
                                    local v667 = v665 == 2
                                    return v667
                                end
                            end
                            local v668 = getv668()
                            if v668 then
                                local v669 = v665 == 2
                                local v670 = g_game.getChaseMode() == ChaseOpponent
                                local v671 = v670 ~= v669
                                if v671 then
                                    local getv674 = function()
                                        if v669 then
                                            local v672 = "on"
                                            return v672
                                        else
                                            local v673 = "off"
                                            return v673
                                        end
                                    end
                                    local v674 = getv674()
                                    local v675 = g_clock.millis()
                                    local v676 = v6 ~= nil and v6.l0
                                    local v677 = spiral_wrap_signed((v675 - v676), 32)
                                    local v678 = ("chase " .. v674)
                                    local v679 = (v678 .. " @t+")
                                    local v680 = format_real_11(v677)
                                    local v681 = (v679 .. v680)
                                    local v682 = ("[tibia-probe] " .. v681)
                                    write_log_line_9(v682)
                                else
                                end
                                chasing_17(v669)
                                if v123 ~= nil and v123.tag == "Us5_None" then
                                elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                    local v683 = v123._1
                                    local v684 = v123._2
                                    local v685 = (v91)[v683]
                                    local v686 = g_game.getAttackingCreature()
                                    local v687 = (v686) == (v685)
                                    local v688 = v687 == false
                                    if v688 then
                                        g_game.attack(v685)
                                        remember_55(v8, v685)
                                        local getv691 = function()
                                            if v669 then
                                                local v689 = "approach"
                                                return v689
                                            else
                                                local v690 = "strike"
                                                return v690
                                            end
                                        end
                                        local v691 = getv691()
                                        local v692 = (v685):getName()
                                        local v693 = (v691 .. " ")
                                        local v694 = (v693 .. v692)
                                        local v695 = (v685):getPosition()
                                        local v696 = v695.x
                                        local v697 = v695.y
                                        local v698 = v695.z
                                        local v699 = format_real_11(v696)
                                        local v700 = ("" .. v699)
                                        local v701 = (v700 .. ",")
                                        local v702 = format_real_11(v697)
                                        local v703 = (v701 .. v702)
                                        local v704 = (v703 .. ",")
                                        local v705 = format_real_11(v698)
                                        local v706 = (v704 .. v705)
                                        local v707 = (" at " .. v706)
                                        local v708 = (v707 .. " from ")
                                        local v709 = format_real_11(v88)
                                        local v710 = ("" .. v709)
                                        local v711 = (v710 .. ",")
                                        local v712 = format_real_11(v89)
                                        local v713 = (v711 .. v712)
                                        local v714 = (v713 .. ",")
                                        local v715 = format_real_11(v90)
                                        local v716 = (v714 .. v715)
                                        local v717 = (v708 .. v716)
                                        local v718 = (v694 .. v717)
                                        local v719 = g_clock.millis()
                                        local v720 = v6 ~= nil and v6.l0
                                        local v721 = spiral_wrap_signed((v719 - v720), 32)
                                        local v722 = (v718 .. " health ")
                                        local v723 = format_real_11(v36)
                                        local v724 = (v722 .. v723)
                                        local v725 = (v724 .. " @t+")
                                        local v726 = format_real_11(v721)
                                        local v727 = (v725 .. v726)
                                        local v728 = ("[tibia-probe] " .. v727)
                                        write_log_line_9(v728)
                                    else
                                    end
                                end
                                local v729 = spiral_wrap_signed((v633 + 1), 32)
                                return { [1]=v631, [2]=v632, [3]=v729, [4]=v634, [5]=v635, [6]=v636, [7]=v637, [8]=v638, [9]=v639, [10]=v640, [11]=v641 }
                            else
                                local v730 = g_game.isAttacking()
                                local getv741 = function()
                                    if v730 then
                                        local getv739 = function()
                                            if v123 ~= nil and v123.tag == "Us5_None" then
                                                return Us8_NoTarget()
                                            elseif v123 ~= nil and v123.tag == "Us5_Some" then
                                                local v731 = v123._1
                                                local v732 = v123._2
                                                local v733 = v732 <= 1
                                                if v733 then
                                                    return Us8_InReach()
                                                else
                                                    return Us8_OutOfReach()
                                                end
                                            end
                                        end
                                        local v739 = getv739()
                                        if v739 ~= nil and v739.tag == "Us8_InReach" then
                                            return true
                                        else
                                            return false
                                        end
                                    else
                                        return false
                                    end
                                end
                                local v741 = getv741()
                                if v741 then
                                    g_game.cancelAttack()
                                    local v742 = format_real_11(v36)
                                    local v743 = ("hold at health " .. v742)
                                    local v744 = ("[tibia-probe] " .. v743)
                                    write_log_line_9(v744)
                                else
                                end
                                local v745 = spiral_wrap_signed((v634 + 1), 32)
                                return { [1]=v631, [2]=v632, [3]=v633, [4]=v745, [5]=v635, [6]=v636, [7]=v637, [8]=v638, [9]=v639, [10]=v640, [11]=v641 }
                            end
                        end
                    end
                end
                local v768, v769, v770, v771, v772, v773, v774, v775, v776, v777, v778 = (table.unpack or unpack)(getv768())
                local v779 = math.fmod(v768, 10)
                local v780 = v779 == 0
                if v780 then
                    local v781 = g_game.getLocalPlayer():getPosition()
                    local v782 = v781.x
                    local v783 = v781.y
                    local v784 = v781.z
                    local v785 = format_real_11(v782)
                    local v786 = ("seen at " .. v785)
                    local v787 = (v786 .. ",")
                    local v788 = format_real_11(v783)
                    local v789 = (v787 .. v788)
                    local v790 = (v789 .. ": ")
                    local v791 = monsters_described_57(v782, v783, v784)
                    local v792 = (v790 .. v791)
                    local v793 = ("[tibia-probe] " .. v792)
                    write_log_line_9(v793)
                else
                end
                local v794 = math.fmod(v768, 100)
                local v795 = v794 == 0
                if v795 then
                    local v796 = attacking_described_60()
                    local v797 = g_game.getLocalPlayer():getPosition()
                    local v798 = v797.x
                    local v799 = v797.y
                    local v800 = v797.z
                    local v801 = format_real_11(v798)
                    local v802 = ("" .. v801)
                    local v803 = (v802 .. ",")
                    local v804 = format_real_11(v799)
                    local v805 = (v803 .. v804)
                    local v806 = (v805 .. ",")
                    local v807 = format_real_11(v800)
                    local v808 = (v806 .. v807)
                    local v809 = player_zone_61()
                    local v810 = (" attacking " .. v796)
                    local v811 = (v810 .. " player at ")
                    local v812 = (v811 .. v808)
                    local v813 = (v812 .. " pz ")
                    local v814 = (v813 .. v809)
                    local v815 = g_game.getLocalPlayer():getHealth()
                    local v816 = g_game.getLocalPlayer():getExperience()
                    local v817 = spiral_wrap_signed((v816 - v5), 32)
                    local v818 = format_real_11(v768)
                    local v819 = ("ticks " .. v818)
                    local v820 = (v819 .. " heals ")
                    local v821 = format_real_11(v769)
                    local v822 = (v820 .. v821)
                    local v823 = (v822 .. " strikes ")
                    local v824 = format_real_11(v770)
                    local v825 = (v823 .. v824)
                    local v826 = (v825 .. " holds ")
                    local v827 = format_real_11(v771)
                    local v828 = (v826 .. v827)
                    local v829 = format_real_11(v773)
                    local v830 = (" retreats " .. v829)
                    local v831 = (v830 .. " cornered ")
                    local v832 = format_real_11(v774)
                    local v833 = (v831 .. v832)
                    local v834 = (v833 .. " gated ")
                    local v835 = format_real_11(v775)
                    local v836 = (v834 .. v835)
                    local v837 = (v836 .. " kills ")
                    local v838 = format_real_11(v772)
                    local v839 = (v837 .. v838)
                    local v840 = (v828 .. v839)
                    local v841 = format_real_11(v815)
                    local v842 = (" health " .. v841)
                    local v843 = (v842 .. " lowest ")
                    local v844 = format_real_11(v776)
                    local v845 = (v843 .. v844)
                    local v846 = (v845 .. " experience +")
                    local v847 = format_real_11(v817)
                    local v848 = (v846 .. v847)
                    local v849 = (v840 .. v848)
                    local v850 = (v849 .. v814)
                    local v851 = ("[tibia-probe] " .. v850)
                    write_log_line_9(v851)
                else
                end
                return Us4_Some(v768, v769, v770, v771, v772, v773, v774, v775, v776, v777, v778)
            end
        end
    end
    local v854 = getv854()
    if v854 ~= nil and v854.tag == "Us4_None" then
        return nil
    elseif v854 ~= nil and v854.tag == "Us4_Some" then
        local v855 = v854._1
        local v856 = v854._2
        local v857 = v854._3
        local v858 = v854._4
        local v859 = v854._5
        local v860 = v854._6
        local v861 = v854._7
        local v862 = v854._8
        local v863 = v854._9
        local v864 = v854._10
        local v865 = v854._11
        local v866 = g_clock.millis()
        local v867 = v6 ~= nil and v6.l0
        local v868 = spiral_wrap_signed((v866 - v867), 32)
        local v869 = "TIBIA_ARENA_RUN_MS"
        local v870 = 150000
        local v871 = env_i32_0(v869, v870)
        local v872 = v868 > v871
        if v872 then
            local v873 = g_game.getLocalPlayer():getHealth()
            local v874 = g_game.getLocalPlayer():getExperience()
            local v875 = spiral_wrap_signed((v874 - v5), 32)
            local v876 = format_real_11(v855)
            local v877 = ("ticks " .. v876)
            local v878 = (v877 .. " heals ")
            local v879 = format_real_11(v856)
            local v880 = (v878 .. v879)
            local v881 = (v880 .. " strikes ")
            local v882 = format_real_11(v857)
            local v883 = (v881 .. v882)
            local v884 = (v883 .. " holds ")
            local v885 = format_real_11(v858)
            local v886 = (v884 .. v885)
            local v887 = format_real_11(v860)
            local v888 = (" retreats " .. v887)
            local v889 = (v888 .. " cornered ")
            local v890 = format_real_11(v861)
            local v891 = (v889 .. v890)
            local v892 = (v891 .. " gated ")
            local v893 = format_real_11(v862)
            local v894 = (v892 .. v893)
            local v895 = (v894 .. " kills ")
            local v896 = format_real_11(v859)
            local v897 = (v895 .. v896)
            local v898 = (v886 .. v897)
            local v899 = format_real_11(v873)
            local v900 = (" health " .. v899)
            local v901 = (v900 .. " lowest ")
            local v902 = format_real_11(v863)
            local v903 = (v901 .. v902)
            local v904 = (v903 .. " experience +")
            local v905 = format_real_11(v875)
            local v906 = (v904 .. v905)
            local v907 = (v898 .. v906)
            local v908 = ("end: " .. v907)
            local v909 = ("[tibia-probe] " .. v908)
            write_log_line_9(v909)
            local v910 = parity_summary_19()
            local v911 = v910 ~= ""
            if v911 then
                local v912 = ("[tibia-probe] " .. v910)
                write_log_line_9(v912)
            else
            end
            local v913 = "[tibia-probe] finish: run complete"
            write_log_line_9(v913)
            local v914 = g_game.isOnline()
            if v914 then
                g_game.safeLogout()
            else
            end
            local v915 = closure3(nil)
            scheduleEvent(v915, 2000)
            return nil
        else
            local v916 = g_game.getLocalPlayer():getExperience()
            local v917 = spiral_wrap_signed((v916 - v5), 32)
            local v918 = v917 >= v7
            if v918 then
                local v919 = g_clock.millis()
                local v920 = v6 ~= nil and v6.l0
                local v921 = spiral_wrap_signed((v919 - v920), 32)
                local v922 = format_real_11(v921)
                local v923 = ("cleared at " .. v922)
                local v924 = (v923 .. " ms")
                local v925 = ("[tibia-probe] " .. v924)
                write_log_line_9(v925)
                local v926 = g_game.getLocalPlayer():getHealth()
                local v927 = g_game.getLocalPlayer():getExperience()
                local v928 = spiral_wrap_signed((v927 - v5), 32)
                local v929 = format_real_11(v855)
                local v930 = ("ticks " .. v929)
                local v931 = (v930 .. " heals ")
                local v932 = format_real_11(v856)
                local v933 = (v931 .. v932)
                local v934 = (v933 .. " strikes ")
                local v935 = format_real_11(v857)
                local v936 = (v934 .. v935)
                local v937 = (v936 .. " holds ")
                local v938 = format_real_11(v858)
                local v939 = (v937 .. v938)
                local v940 = format_real_11(v860)
                local v941 = (" retreats " .. v940)
                local v942 = (v941 .. " cornered ")
                local v943 = format_real_11(v861)
                local v944 = (v942 .. v943)
                local v945 = (v944 .. " gated ")
                local v946 = format_real_11(v862)
                local v947 = (v945 .. v946)
                local v948 = (v947 .. " kills ")
                local v949 = format_real_11(v859)
                local v950 = (v948 .. v949)
                local v951 = (v939 .. v950)
                local v952 = format_real_11(v926)
                local v953 = (" health " .. v952)
                local v954 = (v953 .. " lowest ")
                local v955 = format_real_11(v863)
                local v956 = (v954 .. v955)
                local v957 = (v956 .. " experience +")
                local v958 = format_real_11(v928)
                local v959 = (v957 .. v958)
                local v960 = (v951 .. v959)
                local v961 = ("cleared: " .. v960)
                local v962 = ("[tibia-probe] " .. v961)
                write_log_line_9(v962)
                if v10 then
                    local v963 = v11 ~= nil and v11.l0
                    local v964 = v12 ~= nil and v12.l0
                    local v965 = format_real_11(v963)
                    local v966 = ("adjacency: " .. v965)
                    local v967 = (v966 .. " monster-ms adjacent, ")
                    local v968 = format_real_11(v964)
                    local v969 = (v967 .. v968)
                    local v970 = (v969 .. " landed hits, ")
                    local v971 = v964
                    local v972 = (v971 * 1000.0)
                    local v973 = v963 > 1
                    local getv974 = function()
                        if v973 then
                            return v963
                        else
                            return 1
                        end
                    end
                    local v974 = getv974()
                    local v975 = v974
                    local v976 = v972 / v975
                    local v977 = string.format("%." .. 3 .. "f", v976)
                    local v978 = (v970 .. v977)
                    local v979 = (v978 .. " landed hits per adjacent monster-second")
                    local v980 = ("[tibia-probe] " .. v979)
                    write_log_line_9(v980)
                    local v981 = (v14)[(0)+1]
                    local v982 = (v14)[(1)+1]
                    local v983 = (v14)[(2)+1]
                    local v984 = (v14)[(3)+1]
                    local v985 = format_real_11(v981)
                    local v986 = ("adjacent time by count: 0 " .. v985)
                    local v987 = (v986 .. " 1 ")
                    local v988 = format_real_11(v982)
                    local v989 = (v987 .. v988)
                    local v990 = (v989 .. " 2 ")
                    local v991 = format_real_11(v983)
                    local v992 = (v990 .. v991)
                    local v993 = (v992 .. " 3 ")
                    local v994 = format_real_11(v984)
                    local v995 = (v993 .. v994)
                    local v996 = (v995 .. " ms")
                    local v997 = ("[tibia-probe] " .. v996)
                    write_log_line_9(v997)
                else
                end
                local v998 = parity_summary_19()
                local v999 = v998 ~= ""
                if v999 then
                    local v1000 = ("[tibia-probe] " .. v998)
                    write_log_line_9(v1000)
                else
                end
                local v1001 = "[tibia-probe] finish: cleared"
                write_log_line_9(v1001)
                local v1002 = g_game.isOnline()
                if v1002 then
                    g_game.safeLogout()
                else
                end
                local v1003 = closure3(nil)
                scheduleEvent(v1003, 2000)
                return nil
            else
                local v1004 = closure12({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v864, v865, v855, v856, v857, v858, v859, v860, v861, v862, v863 })
                scheduleEvent(v1004, 100)
                return nil
            end
        end
    end
end

function closure11(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 = (table.unpack or unpack)(capt)
    return function(dom)
        local v16 = g_game.getLocalPlayer():getPosition()
        local v17 = v16.x
        local v18 = v16.y
        local v19 = v16.z
        local v20 = format_real_11(v17)
        local v21 = ("" .. v20)
        local v22 = (v21 .. ",")
        local v23 = format_real_11(v18)
        local v24 = (v22 .. v23)
        local v25 = (v24 .. ",")
        local v26 = format_real_11(v19)
        local v27 = (v25 .. v26)
        local v28 = ("policy starts at " .. v27)
        local v29 = format_real_11(v0)
        local v30 = (" thresholds heal<" .. v29)
        local v31 = (v30 .. " strike>=")
        local v32 = format_real_11(v1)
        local v33 = (v31 .. v32)
        local v34 = (v33 .. " kite at ")
        local v35 = format_real_11(v3)
        local v36 = (v34 .. v35)
        local v37 = (v36 .. " retreat at ")
        local v38 = format_real_11(v2)
        local v39 = (v37 .. v38)
        local v40 = (v28 .. v39)
        local v41 = "TIBIA_ARENA_TARGETING"
        local v42 = "current"
        local v43 = env_text_4(v41, v42)
        local v44 = os.time()
        local v45 = (v40 .. " targeting ")
        local v46 = (v45 .. v43)
        local v47 = (v46 .. " wall ")
        local v48 = format_real_11(v44)
        local v49 = (v47 .. v48)
        local v50 = ("[tibia-probe] " .. v49)
        write_log_line_9(v50)
        local v51 = g_clock.millis()
        v5.l0 = v51
        local v52 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v53 = 90
        local v54 = env_i32_0(v52, v53)
        local v55 = 0
        local v56 = 0
        local v57 = 0
        local v58 = 0
        local v59 = 0
        local v60 = 0
        local v61 = 0
        local v62 = 0
        local v63 = 999
        local v64 = -1000
        local v65 = 0
        return ticked_18(v0, v1, v2, v3, v4, v15, v5, v54, v9, v6, v10, v11, v12, v13, v14, v55, v56, v57, v58, v59, v60, v61, v62, v63, v64, v65)
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = (table.unpack or unpack)(capt)
    return function(dom)
        local v15 = g_game.getLocalPlayer():getExperience()
        local v16 = false
        chasing_17(v16)
        g_game.setFightMode(FightBalanced)
        local v17 = closure11({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 })
        scheduleEvent(v17, 1000)
        return nil
    end
end

function closure6(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = (table.unpack or unpack)(capt)
    return function(dom)
        local v15 = g_game.getLocalPlayer():getName()
        local v16 = g_game.getLocalPlayer():getHealth()
        local v17 = g_game.getLocalPlayer():getMana()
        local v18 = ("in game as " .. v15)
        local v19 = (v18 .. " health ")
        local v20 = format_real_11(v16)
        local v21 = (v19 .. v20)
        local v22 = (v21 .. " mana ")
        local v23 = format_real_11(v17)
        local v24 = (v22 .. v23)
        local v25 = ("[tibia-probe] " .. v24)
        write_log_line_9(v25)
        local v26 = g_clock.millis()
        v8.l0 = v26
        local v27 = closure7({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 })
        on_position_change_16(v27)
        local v28 = closure10({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 })
        scheduleEvent(v28, 1500)
        return nil
    end
end

function closure13(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_7(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31)
    end
end

function poll_7(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31)
    local v32 = v0 == ""
    local getv34 = function()
        if v32 then
            return true
        else
            return file_exists_8(v0)
        end
    end
    local v34 = getv34()
    if v34 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v35 = typed_c2(nil)
        local v36 = function(message) (v35)(message) end
        local v37 = typed_c4({ v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 })
        local v38 = function(mode, text) (v37)(mode)(text) end
        local v39 = closure6({ v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31 })
        connect(g_game, { onGameStart = v39, onLoginError = v36, onTextMessage = v38 })
        local v40 = "@god"
        local v41 = "@god\ngod"
        g_game.loginWorld(v40, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v41)
        return nil
    else
        local v42 = closure13({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31 })
        scheduleEvent(v42, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30 = (table.unpack or unpack)(capt)
    return function(dom)
        local v31 = "TIBIA_LOGIN_GATE"
        local v32 = ""
        local v33 = env_text_4(v31, v32)
        return poll_7(v33, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30)
    end
end

function closure14(capt)
    return function(dom)
        local v0 = parity_summary_19()
        local v1 = v0 ~= ""
        if v1 then
            local v2 = ("[tibia-probe] " .. v0)
            write_log_line_9(v2)
        else
        end
        local v3 = "[tibia-probe] finish: timeout"
        write_log_line_9(v3)
        local v4 = g_game.isOnline()
        if v4 then
            g_game.safeLogout()
        else
        end
        local v5 = closure3(nil)
        scheduleEvent(v5, 2000)
        return nil
    end
end

local v0 = "TIBIA_ARENA_HEAL_BELOW"
local v1 = 120
local v2 = env_i32_0(v0, v1)
local v3 = "TIBIA_ARENA_STRIKE_ABOVE"
local v4 = 40
local v5 = env_i32_0(v3, v4)
local v6 = "TIBIA_ARENA_RETREAT_AT"
local v7 = 0
local v8 = env_i32_0(v6, v7)
local v9 = "TIBIA_ARENA_KITE_AT"
local v10 = 0
local v11 = env_i32_0(v9, v10)
local v12 = "TIBIA_ARENA_TARGETING"
local v13 = get_environment_variable_1(v12)
local v14 = v13 == "reach"
local getv17 = function()
    if v14 then
        local v15 = Us1_ReachFirst()
        return { [1]=v2, [2]=v5, [3]=v8, [4]=v11, [5]=v15 }
    else
        local v16 = Us1_CurrentFirst()
        return { [1]=v2, [2]=v5, [3]=v8, [4]=v11, [5]=v16 }
    end
end
local v17, v18, v19, v20, v21 = (table.unpack or unpack)(getv17())
local v22 = { __tag = "Mut0", l0 = 0 }
local v23 = { __tag = "Mut0", l0 = -2000 }
local v24 = { __tag = "Mut0", l0 = 0 }
local v25 = { __tag = "Mut0", l0 = 0 }
local v26 = Uh0_Nil()
local v27 = { __tag = "Mut1", l0 = v26 }
local v28 = "TIBIA_ARENA_ADJACENCY"
local v29 = get_environment_variable_1(v28)
local v30 = v29 == "1"
local v31 = { __tag = "Mut0", l0 = 0 }
local v32 = { __tag = "Mut0", l0 = 0 }
local v33 = { __tag = "Mut0", l0 = -1 }
local v34 = { 0, 0, 0, 0 }
local v35 = "TIBIA_ARENA_RUN_MS"
local v36 = 150000
local v37 = env_i32_0(v35, v36)
local v38 = spiral_wrap_signed((v37 + 50000), 32)
local v39 = "TIBIA_ARENA_CHARACTER"
local v40 = "Knight Sample"
local v41 = env_text_4(v39, v40)
local v42 = (v41 .. "_1511")
disable_client_bot_5(v42)
local v43 = env_text_4(v39, v40)
local v44 = "TIBIA_PROBE_HIDDEN"
local v45 = get_environment_variable_1(v44)
local v46 = v45 == "1"
if v46 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_6()
local v47 = closure0(nil)
scheduleEvent(v47, 200)
scheduleEvent(v47, 1000)
local v48 = closure1({ v43, v17, v18, v19, v20, v21, v22, v23, v24, v25, v27, v30, v31, v32, v33, v34, v17, v18, v19, v20, v21, v22, v23, v24, v25, v27, v30, v31, v32, v33, v34 })
scheduleEvent(v48, 3000)
local v49 = closure14(nil)
scheduleEvent(v49, v38)
return 0
