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
local Us0_Some, Us0_None, Mut0, Uh0_Cons, Mut1, Mut2, Us1_Some, Us1_None, Us2_Stepped, Us2_Gated, Us2_Cornered, Us3_Free, Us3_Ramp, Us3_Occupied, Us3_Blocked, Us3_Unknown, Us4_InReach, Us4_OutOfReach, Us4_NoTarget, Us5_Strike, Us5_Approach, Us5_Hold, Uh1_Cons, get_environment_variable_1, method2, method3, env_i32_0, env_text_4, disable_client_bot_5, mute_6, closure0, file_exists_8, log_flush_10, write_log_line_9, closure3, typed_c2, format_real_11, player_present_12, live_monster_14, adjacent_from_13, closure5, typed_c4, closure9, closure8, closure7, on_position_change_15, chasing_16, parity_summary_18, method20, method21, method22, forget_dead_19, positioned_monster_24, positions_from_23, scan_sight_25, scan_threats_26, fill_27, fill_28, fill_29, sum_31, activate_30, output_sum_32, arena_protection_zone_dy35_39, arena_protection_zone_dy36_40, arena_protection_zone_11_47, arena_protection_zone_10_46, arena_protection_zone_9_45, arena_protection_zone_8_44, arena_protection_zone_7_43, arena_protection_zone_6_42, arena_protection_zone_5_41, arena_protection_zone_4_38, arena_protection_zone_3_37, arena_protection_zone_2_36, arena_protection_zone_1_35, arena_protection_zone_34, footing_of_49, footing_at_48, diagonal_south_53, diagonal_step_52, south_or_west_step_51, step_50, near_from_54, attempt_from_33, adjacent_from_55, rejected_from_56, method58, remember_57, monster_lines_60, method61, monsters_described_59, attacking_described_62, player_zone_63, closure12, ticked_17, closure11, closure10, closure6, closure13, poll_7, closure1, closure14
function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1, v2) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1,  _3 = v2 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

function Us1_Some(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) return { tag = "Us1_Some",  _1 = v0,  _2 = v1,  _3 = v2,  _4 = v3,  _5 = v4,  _6 = v5,  _7 = v6,  _8 = v7,  _9 = v8,  _10 = v9,  _11 = v10 } end
function Us1_None() return { tag = "Us1_None" } end

function Us2_Stepped() return { tag = "Us2_Stepped" } end
function Us2_Gated() return { tag = "Us2_Gated" } end
function Us2_Cornered() return { tag = "Us2_Cornered" } end

function Us3_Free() return { tag = "Us3_Free" } end
function Us3_Ramp() return { tag = "Us3_Ramp" } end
function Us3_Occupied() return { tag = "Us3_Occupied" } end
function Us3_Blocked() return { tag = "Us3_Blocked" } end
function Us3_Unknown() return { tag = "Us3_Unknown" } end

function Us4_InReach() return { tag = "Us4_InReach" } end
function Us4_OutOfReach() return { tag = "Us4_OutOfReach" } end
function Us4_NoTarget() return { tag = "Us4_NoTarget" } end

function Us5_Strike() return { tag = "Us5_Strike" } end
function Us5_Approach() return { tag = "Us5_Approach" } end
function Us5_Hold() return { tag = "Us5_Hold" } end

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
    local v1 = "\n"
    local v2 = v0 .. v1 
    g_resources.writeFileContents("/tibia-probe.log", v2)
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
        local v2 = "game login error: "
        local v3 = v2 .. v1 
        local v4 = "[tibia-probe] "
        local v5 = v4 .. v3 
        write_log_line_9(v5)
        local v6 = "finish: "
        local v7 = "game login error"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        write_log_line_9(v9)
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

function format_real_11(v0)
    local v1 = ""
    local v2 = { __tag = "Mut2", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
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
        local v25 = "server text ["
        local v26 = v25 .. v17 
        local v27 = "]: "
        local v28 = v26 .. v27 
        local v29 = v28 .. v18 
        local v30 = " @t+"
        local v31 = v29 .. v30 
        local v32 = format_real_11(v24)
        local v33 = v31 .. v32 
        local v34 = "[tibia-probe] "
        local v35 = v34 .. v33 
        write_log_line_9(v35)
        local v36 = g_game.getLocalPlayer():getSkillLevel(Skill.Shielding)
        local v37 = v7 ~= nil and v7.l0
        local v38 = v36 ~= v37
        if v38 then
            v7.l0 = v36
            local v39 = format_real_11(v36)
            local v40 = "shield skill "
            local v41 = v40 .. v39 
            local v42 = v41 .. v30 
            local v43 = format_real_11(v24)
            local v44 = v42 .. v43 
            local v45 = v34 .. v44 
            write_log_line_9(v45)
        else
        end
        local getv48 = function()
            if v10 then
                local v46 = "due to an attack"
                local v47 = string.find(v18, v46, 1, true) ~= nil 
                return v47
            else
                return false
            end
        end
        local v48 = getv48()
        if v48 then
            local v49 = v12 ~= nil and v12.l0
            local v50 = spiral_wrap_signed((v49 + 1), 32)
            v12.l0 = v50
            local v51 = player_present_12()
            if v51 then
                local v52 = g_game.getLocalPlayer():getPosition()
                local v53 = v52.x
                local v54 = v52.y
                local v55 = v52.z
                local v56 = g_map.getSpectators({ x = v53, y = v54, z = v55 }, false)
                local v57 = 1
                local v58 = 0
                local v59 = adjacent_from_13(v53, v54, v55, v56, v57, v58)
                local v60 = format_real_11(v24)
                local v61 = "hit at "
                local v62 = v61 .. v60 
                local v63 = " ms with "
                local v64 = v62 .. v63 
                local v65 = format_real_11(v59)
                local v66 = v64 .. v65 
                local v67 = " adjacent"
                local v68 = v66 .. v67 
                local v69 = v34 .. v68 
                return write_log_line_9(v69)
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
                local v30 = "monster "
                local v31 = v30 .. v29 
                local v32 = " moved to "
                local v33 = v31 .. v32 
                local v34 = format_real_11(v25)
                local v35 = v33 .. v34 
                local v36 = ","
                local v37 = v35 .. v36 
                local v38 = format_real_11(v26)
                local v39 = v37 .. v38 
                local v40 = " @login+"
                local v41 = v39 .. v40 
                local v42 = g_clock.millis()
                local v43 = v8 ~= nil and v8.l0
                local v44 = spiral_wrap_signed((v42 - v43), 32)
                local v45 = format_real_11(v44)
                local v46 = v41 .. v45 
                local v47 = "[tibia-probe] "
                local v48 = v47 .. v46 
                return write_log_line_9(v48)
            else
                local v49 = v5 ~= nil and v5.l0
                local v50 = v49 > 0
                if v50 then
                    local v51 = (v15):isLocalPlayer()
                    local getv58 = function()
                        if v51 then
                            local v52 = "knight"
                            return v52
                        else
                            local v53 = g_game.getAttackingCreature()
                            local v54 = (v53) == (v15)
                            if v54 then
                                local v55 = "target"
                                return v55
                            else
                                local v56 = ""
                                return v56
                            end
                        end
                    end
                    local v58 = getv58()
                    local v59 = v58 ~= ""
                    if v59 then
                        local v60 = v16.x
                        local v61 = v16.y
                        local v62 = v16.z
                        local v63 = " moved to "
                        local v64 = v58 .. v63 
                        local v65 = format_real_11(v60)
                        local v66 = v64 .. v65 
                        local v67 = ","
                        local v68 = v66 .. v67 
                        local v69 = format_real_11(v61)
                        local v70 = v68 .. v69 
                        local v71 = " @t+"
                        local v72 = v70 .. v71 
                        local v73 = g_clock.millis()
                        local v74 = v5 ~= nil and v5.l0
                        local v75 = spiral_wrap_signed((v73 - v74), 32)
                        local v76 = format_real_11(v75)
                        local v77 = v72 .. v76 
                        local v78 = "[tibia-probe] "
                        local v79 = v78 .. v77 
                        return write_log_line_9(v79)
                    else
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

function on_position_change_15(v0)
    local v1 = function(c, n, o) (v0)(c)(n)(o) end
    connect(Creature, { onPositionChange = v1 })
    connect(LocalPlayer, { onPositionChange = v1 })
    return nil
end

function chasing_16(v0)
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

function parity_summary_18()
    local v0 = ArenaParity ~= nil
    if v0 then
        local v1 = ArenaParity.summary()
        return v1
    else
        local v2 = ""
        return v2
    end
end

function method20(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method20(v4, v1)
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

function method21(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method21(v4, v1)
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

function method22(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = spiral_wrap_signed((v1 + 1), 32)
        return method22(v4, v5)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function forget_dead_19(v0)
    local v1 = v0 ~= nil and v0.l0
    local v2 = Uh0_Nil()
    local v3 = method20(v1, v2)
    local v4 = v0 ~= nil and v0.l0
    local v5 = Uh0_Nil()
    local v6 = method21(v4, v5)
    v0.l0 = v6
    local v7 = 0
    return method22(v3, v7)
end

function positioned_monster_24(v0)
    local v1 = (v0):isMonster()
    if v1 then
        local v2 = (v0):getPosition() ~= nil
        return v2
    else
        return false
    end
end

function positions_from_23(v0, v1, v2)
    local v3 = #(v0)
    local v4 = v1 > v3
    if v4 then
        return v2
    else
        local v5 = spiral_wrap_signed((v1 + 1), 32)
        local v6 = (v0)[v1]
        local v7 = positioned_monster_24(v6)
        local getv27 = function()
            if v7 then
                local v8 = (v6):getPosition()
                local v9 = v8.x
                local v10 = v8.y
                local v11 = v8.z
                local v12 = format_real_11(v9)
                local v13 = ""
                local v14 = v13 .. v12 
                local v15 = ","
                local v16 = v14 .. v15 
                local v17 = format_real_11(v10)
                local v18 = v16 .. v17 
                local v19 = v18 .. v15 
                local v20 = format_real_11(v11)
                local v21 = v19 .. v20 
                local v22 = v2 == ""
                if v22 then
                    return v21
                else
                    local v23 = " "
                    local v24 = v2 .. v23 
                    local v25 = v24 .. v21 
                    return v25
                end
            else
                return v2
            end
        end
        local v27 = getv27()
        return positions_from_23(v0, v5, v27)
    end
end

function scan_sight_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23)
    local v24 = #(v18)
    local v25 = v20 > v24
    local getv80 = function()
        if v25 then
            return { [1]=v21, [2]=v22, [3]=v23 }
        else
            local v26 = spiral_wrap_signed((v20 + 1), 32)
            local v27 = (v18)[v20]
            local v28 = live_monster_14(v27)
            local getv74 = function()
                if v28 then
                    local v29 = (v27):getPosition()
                    local v30 = v29.x
                    local v31 = v29.y
                    local v32 = v29.z
                    local v33 = v30 > v15
                    local getv36 = function()
                        if v33 then
                            local v34 = spiral_wrap_signed((v30 - v15), 32)
                            return v34
                        else
                            local v35 = spiral_wrap_signed((v15 - v30), 32)
                            return v35
                        end
                    end
                    local v36 = getv36()
                    local v37 = v31 > v16
                    local getv40 = function()
                        if v37 then
                            local v38 = spiral_wrap_signed((v31 - v16), 32)
                            return v38
                        else
                            local v39 = spiral_wrap_signed((v16 - v31), 32)
                            return v39
                        end
                    end
                    local v40 = getv40()
                    local v41 = v36 > v40
                    local getv42 = function()
                        if v41 then
                            return v36
                        else
                            return v40
                        end
                    end
                    local v42 = getv42()
                    local v43 = v21 == false
                    local getv70 = function()
                        if v43 then
                            return true
                        else
                            local v44 = (v27) == (v19)
                            local v45 = (v27):getHealthPercent()
                            local v46 = (v18)[v22]
                            local v47 = (v46) == (v19)
                            local v48 = (v46):getHealthPercent()
                            if v4 then
                                local v49 = v42 <= 1
                                local v50 = v23 <= 1
                                local v51 = v49 ~= v50
                                if v51 then
                                    return v49
                                else
                                    local v52 = v44 ~= v47
                                    if v52 then
                                        return v44
                                    else
                                        local v53 = v45 ~= v48
                                        if v53 then
                                            local v54 = v45 < v48
                                            return v54
                                        else
                                            local v55 = v42 < v23
                                            return v55
                                        end
                                    end
                                end
                            else
                                local v59 = v44 ~= v47
                                if v59 then
                                    return v44
                                else
                                    local v60 = v42 <= 1
                                    local v61 = v23 <= 1
                                    local v62 = v60 ~= v61
                                    if v62 then
                                        return v60
                                    else
                                        local v63 = v45 ~= v48
                                        if v63 then
                                            local v64 = v45 < v48
                                            return v64
                                        else
                                            local v65 = v42 < v23
                                            return v65
                                        end
                                    end
                                end
                            end
                        end
                    end
                    local v70 = getv70()
                    local getv71 = function()
                        if v70 then
                            return { [1]=true, [2]=v20, [3]=v42 }
                        else
                            return { [1]=v21, [2]=v22, [3]=v23 }
                        end
                    end
                    local v71, v72, v73 = (table.unpack or unpack)(getv71())
                    return { [1]=v71, [2]=v72, [3]=v73 }
                else
                    return { [1]=v21, [2]=v22, [3]=v23 }
                end
            end
            local v74, v75, v76 = (table.unpack or unpack)(getv74())
            local v77, v78, v79 = (table.unpack or unpack)(scan_sight_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v26, v74, v75, v76))
            return { [1]=v77, [2]=v78, [3]=v79 }
        end
    end
    local v80, v81, v82 = (table.unpack or unpack)(getv80())
    return { [1]=v80, [2]=v81, [3]=v82 }
end

function scan_threats_26(v0, v1, v2, v3, v4, v5, v6, v7)
    local v8 = #(v3)
    local v9 = v4 > v8
    local getv53 = function()
        if v9 then
            return { [1]=v5, [2]=v6, [3]=v7 }
        else
            local v10 = spiral_wrap_signed((v4 + 1), 32)
            local v11 = (v3)[v4]
            local v12 = live_monster_14(v11)
            local getv28 = function()
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
                    local v27 = v26 <= 1
                    return v27
                else
                    return false
                end
            end
            local v28 = getv28()
            local getv47 = function()
                if v28 then
                    local v29 = spiral_wrap_signed((v5 + 1), 32)
                    local v30 = v6 == false
                    local getv45 = function()
                        if v30 then
                            return true
                        else
                            local v31 = (v11):getPosition()
                            local v32 = v31.x
                            local v33 = v31.y
                            local v34 = v31.z
                            local v35 = spiral_wrap_signed(spiral_mul_mod32(v32, 100000), 32)
                            local v36 = spiral_wrap_signed((v35 + v33), 32)
                            local v37 = (v3)[v7]
                            local v38 = (v37):getPosition()
                            local v39 = v38.x
                            local v40 = v38.y
                            local v41 = v38.z
                            local v42 = spiral_wrap_signed(spiral_mul_mod32(v39, 100000), 32)
                            local v43 = spiral_wrap_signed((v42 + v40), 32)
                            local v44 = v36 < v43
                            return v44
                        end
                    end
                    local v45 = getv45()
                    local getv46 = function()
                        if v45 then
                            return v4
                        else
                            return v7
                        end
                    end
                    local v46 = getv46()
                    return { [1]=v29, [2]=true, [3]=v46 }
                else
                    return { [1]=v5, [2]=v6, [3]=v7 }
                end
            end
            local v47, v48, v49 = (table.unpack or unpack)(getv47())
            local v50, v51, v52 = (table.unpack or unpack)(scan_threats_26(v0, v1, v2, v3, v10, v47, v48, v49))
            return { [1]=v50, [2]=v51, [3]=v52 }
        end
    end
    local v53, v54, v55 = (table.unpack or unpack)(getv53())
    return { [1]=v53, [2]=v54, [3]=v55 }
end

function fill_27(v0, v1)
    local v2 = v1 < 66
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_27(v0, v3)
    else
    end
end

function fill_28(v0, v1)
    local v2 = v1 < 8
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_28(v0, v3)
    else
    end
end

function fill_29(v0, v1)
    local v2 = v1 < 6
    if v2 then
        v0[(v1)+1] = 0
        local v3 = spiral_wrap_signed((v1 + 1), 32)
        return fill_29(v0, v3)
    else
    end
end

function sum_31(v0, v1, v2, v3, v4)
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
        return sum_31(v0, v1, v2, v6, v12)
    end
end

function activate_30(v0, v1, v2, v3)
    local v4 = v3 < 6
    if v4 then
        local v5 = 0
        local v6 = 0
        local v7 = sum_31(v0, v1, v3, v5, v6)
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
        return activate_30(v0, v1, v2, v11)
    else
    end
end

function output_sum_32(v0, v1, v2, v3, v4)
    local v5 = v3 >= 6
    if v5 then
        return v4
    else
        local v6 = spiral_wrap_signed((v3 + 1), 32)
        local v7 = spiral_wrap_signed(spiral_mul_mod32(v2, 6), 32)
        local v8 = spiral_wrap_signed((48 + v7), 32)
        local v9 = spiral_wrap_signed((v8 + v3), 32)
        local v10 = (v0)[(v9)+1]
        local v11 = (v1)[(v3)+1]
        local v12 = spiral_wrap_signed(spiral_mul_mod32(v10, v11), 32)
        local v13 = spiral_wrap_signed((v4 + v12), 32)
        return output_sum_32(v0, v1, v2, v6, v13)
    end
end

function arena_protection_zone_dy35_39(v0)
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

function arena_protection_zone_dy36_40(v0)
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

function arena_protection_zone_11_47(v0, v1)
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

function arena_protection_zone_10_46(v0, v1)
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
                return arena_protection_zone_11_47(v0, v1)
            end
        end
    end
end

function arena_protection_zone_9_45(v0, v1)
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
            return arena_protection_zone_10_46(v0, v1)
        end
    end
end

function arena_protection_zone_8_44(v0, v1)
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
            return arena_protection_zone_9_45(v0, v1)
        end
    end
end

function arena_protection_zone_7_43(v0, v1)
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
            return arena_protection_zone_8_44(v0, v1)
        end
    end
end

function arena_protection_zone_6_42(v0, v1)
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
            return arena_protection_zone_7_43(v0, v1)
        end
    end
end

function arena_protection_zone_5_41(v0, v1)
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
            return arena_protection_zone_6_42(v0, v1)
        end
    end
end

function arena_protection_zone_4_38(v0, v1)
    local v2 = v1 == -10
    if v2 then
        return arena_protection_zone_dy35_39(v0)
    else
        local v4 = v1 == -9
        if v4 then
            return arena_protection_zone_dy36_40(v0)
        else
            return arena_protection_zone_5_41(v0, v1)
        end
    end
end

function arena_protection_zone_3_37(v0, v1)
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
                return arena_protection_zone_4_38(v0, v1)
            end
        end
    end
end

function arena_protection_zone_2_36(v0, v1)
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
                return arena_protection_zone_3_37(v0, v1)
            end
        end
    end
end

function arena_protection_zone_1_35(v0, v1)
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
                return arena_protection_zone_2_36(v0, v1)
            end
        end
    end
end

function arena_protection_zone_34(v0, v1)
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
                return arena_protection_zone_1_35(v0, v1)
            end
        end
    end
end

function footing_of_49(v0, v1, v2, v3)
    local v4 = v0 == false
    if v4 then
        return Us3_Unknown()
    else
        local getv7 = function()
            if v1 then
                local v6 = v2 == false
                return v6
            else
                return false
            end
        end
        local v7 = getv7()
        if v7 then
            return Us3_Free()
        else
            if v1 then
                return Us3_Ramp()
            else
                if v3 then
                    return Us3_Occupied()
                else
                    return Us3_Blocked()
                end
            end
        end
    end
end

function footing_at_48(v0, v1, v2)
    local v3 = g_map.getTile({ x = v0, y = v1, z = v2 })
    local v4 = (v3) ~= nil
    if v4 then
        local v5 = true
        local v6 = (v3):isWalkable()
        local v7 = (v3):hasFloorChange()
        local v8 = (v3):isWalkable(true)
        return footing_of_49(v5, v6, v7, v8)
    else
        return Us3_Unknown()
    end
end

function diagonal_south_53(v0, v1)
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

function diagonal_step_52(v0, v1)
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
            return diagonal_south_53(v0, v1)
        end
    end
end

function south_or_west_step_51(v0, v1)
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
            return diagonal_step_52(v0, v1)
        end
    end
end

function step_50(v0, v1)
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
            return south_or_west_step_51(v0, v1)
        end
    end
end

function near_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
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
        local getv67 = function()
            if v47 then
                local v48 = (v30):getPosition()
                local v49 = v48.x
                local v50 = v48.y
                local v51 = v48.z
                local v52 = format_real_11(v49)
                local v53 = ""
                local v54 = v53 .. v52 
                local v55 = ","
                local v56 = v54 .. v55 
                local v57 = format_real_11(v50)
                local v58 = v56 .. v57 
                local v59 = v58 .. v55 
                local v60 = format_real_11(v51)
                local v61 = v59 .. v60 
                local v62 = v26 == ""
                if v62 then
                    return v61
                else
                    local v63 = " "
                    local v64 = v26 .. v63 
                    local v65 = v64 .. v61 
                    return v65
                end
            else
                return v26
            end
        end
        local v67 = getv67()
        return near_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v29, v67)
    end
end

function attempt_from_33(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    local v26 = v25 >= 7
    if v26 then
        local v27 = Us2_Cornered()
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
                local v64 = arena_protection_zone_34(v62, v63)
                local getv67 = function()
                    if v64 then
                        return Us3_Blocked()
                    else
                        return footing_at_48(v60, v61, v17)
                    end
                end
                local v67 = getv67()
                if v67 ~= nil and v67.tag == "Us3_Free" then
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
            local v70 = step_50(v53, v54)
            if v70 then
                local v71 = g_clock.millis()
                local v72 = v6 ~= nil and v6.l0
                local v73 = spiral_wrap_signed((v71 - v72), 32)
                local v74 = format_real_11(v15)
                local v75 = ""
                local v76 = v75 .. v74 
                local v77 = ","
                local v78 = v76 .. v77 
                local v79 = format_real_11(v16)
                local v80 = v78 .. v79 
                local v81 = v80 .. v77 
                local v82 = format_real_11(v17)
                local v83 = v81 .. v82 
                local v84 = 1
                local v85 = near_from_54(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v84, v75)
                local v86 = "step away from "
                local v87 = v86 .. v83 
                local v88 = " by "
                local v89 = v87 .. v88 
                local v90 = format_real_11(v53)
                local v91 = v89 .. v90 
                local v92 = v91 .. v77 
                local v93 = format_real_11(v54)
                local v94 = v92 .. v93 
                local v95 = " @t+"
                local v96 = v94 .. v95 
                local v97 = format_real_11(v73)
                local v98 = v96 .. v97 
                local v99 = " near "
                local v100 = v98 .. v99 
                local v101 = v100 .. v85 
                local v102 = "[tibia-probe] "
                local v103 = v102 .. v101 
                write_log_line_9(v103)
                local v104 = v53 ~= 0
                local getv106 = function()
                    if v104 then
                        local v105 = v54 ~= 0
                        return v105
                    else
                        return false
                    end
                end
                local v106 = getv106()
                local getv107 = function()
                    if v106 then
                        return 3
                    else
                        return 1
                    end
                end
                local v107 = getv107()
                local v108 = spiral_wrap_signed(spiral_mul_mod32(650, v107), 32)
                local v109 = spiral_wrap_signed((v24 + v108), 32)
                local v110 = Us2_Stepped()
                return { [1]=v110, [2]=v109 }
            else
                local v111 = Us2_Gated()
                return { [1]=v111, [2]=0 }
            end
        else
            local v114 = spiral_wrap_signed((v25 + 1), 32)
            return attempt_from_33(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v114)
        end
    end
end

function adjacent_from_55(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
    local v27 = #(v21)
    local v28 = v25 > v27
    if v28 then
        return v26
    else
        local v29 = spiral_wrap_signed((v25 + 1), 32)
        local v30 = (v21)[v25]
        local v31 = positioned_monster_24(v30)
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
        local getv67 = function()
            if v47 then
                local v48 = (v30):getPosition()
                local v49 = v48.x
                local v50 = v48.y
                local v51 = v48.z
                local v52 = format_real_11(v49)
                local v53 = ""
                local v54 = v53 .. v52 
                local v55 = ","
                local v56 = v54 .. v55 
                local v57 = format_real_11(v50)
                local v58 = v56 .. v57 
                local v59 = v58 .. v55 
                local v60 = format_real_11(v51)
                local v61 = v59 .. v60 
                local v62 = v26 == ""
                if v62 then
                    return v61
                else
                    local v63 = " "
                    local v64 = v26 .. v63 
                    local v65 = v64 .. v61 
                    return v65
                end
            else
                return v26
            end
        end
        local v67 = getv67()
        return adjacent_from_55(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v29, v67)
    end
end

function rejected_from_56(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
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
        local getv94 = function()
            if v60 then
                local v61 = spiral_wrap_signed((v15 + v53), 32)
                local v62 = spiral_wrap_signed((v16 + v54), 32)
                local v63 = spiral_wrap_signed((v61 - 1933), 32)
                local v64 = spiral_wrap_signed((v62 - 1350), 32)
                local v65 = arena_protection_zone_34(v63, v64)
                local getv78 = function()
                    if v65 then
                        local v66 = "zone"
                        return v66
                    else
                        local v67 = footing_at_48(v61, v62, v17)
                        if v67 ~= nil and v67.tag == "Us3_Blocked" then
                            local v71 = "blocked"
                            return v71
                        elseif v67 ~= nil and v67.tag == "Us3_Free" then
                            local v68 = "walk"
                            return v68
                        elseif v67 ~= nil and v67.tag == "Us3_Occupied" then
                            local v70 = "creature"
                            return v70
                        elseif v67 ~= nil and v67.tag == "Us3_Ramp" then
                            local v69 = "walk"
                            return v69
                        elseif v67 ~= nil and v67.tag == "Us3_Unknown" then
                            local v72 = "none"
                            return v72
                        end
                    end
                end
                local v78 = getv78()
                local v79 = format_real_11(v53)
                local v80 = ""
                local v81 = v80 .. v79 
                local v82 = ","
                local v83 = v81 .. v82 
                local v84 = format_real_11(v54)
                local v85 = v83 .. v84 
                local v86 = ":"
                local v87 = v85 .. v86 
                local v88 = v87 .. v78 
                local v89 = v26 == ""
                if v89 then
                    return v88
                else
                    local v90 = " "
                    local v91 = v26 .. v90 
                    local v92 = v91 .. v88 
                    return v92
                end
            else
                return v26
            end
        end
        local v94 = getv94()
        return rejected_from_56(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v56, v94)
    end
end

function method58(v0, v1, v2)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v3 = v1._1
        local v4 = v1._2
        local v5 = v1._3
        local v6 = method58(v0, v5, v2)
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

function remember_57(v0, v1)
    local v2 = (v1):getId()
    local v3 = v0 ~= nil and v0.l0
    local v4 = Uh0_Nil()
    local v5 = method58(v2, v3, v4)
    local v6 = Uh0_Cons(v2, v1, v5)
    v0.l0 = v6
    return nil
end

function monster_lines_60(v0, v1, v2)
    local v3 = v1 < 1
    if v3 then
        return v2
    else
        local v4 = (v0)[v1]
        local v5 = spiral_wrap_signed((v1 - 1), 32)
        local v6 = live_monster_14(v4)
        local getv27 = function()
            if v6 then
                local v7 = (v4):getPosition()
                local v8 = v7.x
                local v9 = v7.y
                local v10 = v7.z
                local v11 = (v4):getName()
                local v12 = " "
                local v13 = v11 .. v12 
                local v14 = (v4):getHealthPercent()
                local v15 = format_real_11(v14)
                local v16 = v13 .. v15 
                local v17 = "%"
                local v18 = v16 .. v17 
                local v19 = v18 .. v12 
                local v20 = format_real_11(v8)
                local v21 = v19 .. v20 
                local v22 = ","
                local v23 = v21 .. v22 
                local v24 = format_real_11(v9)
                local v25 = v23 .. v24 
                return Uh1_Cons(v25, v2)
            else
                return v2
            end
        end
        local v27 = getv27()
        return monster_lines_60(v0, v5, v27)
    end
end

function method61(v0, v1, v2)
    local getv12 = function()
        if v0 ~= nil and v0.tag == "Uh1_Cons" then
            local v3 = v0._1
            local v4 = v0._2
            local v5, v6 = (table.unpack or unpack)(method61(v4, v1, v2))
            local v7 = v3 .. v6 
            local v8 = v7 .. v5 
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

function monsters_described_59(v0, v1, v2)
    local v3 = g_map.getSpectators({ x = v0, y = v1, z = v2 }, false)
    local v4 = #(v3)
    local v5 = Uh1_Nil()
    local v6 = monster_lines_60(v3, v4, v5)
    if v6 ~= nil and v6.tag == "Uh1_Nil" then
        local v7 = "none"
        return v7
    else
        local v8 = ""
        local v9, v10 = (table.unpack or unpack)(method61(v6, v8, v8))
        return v9
    end
end

function attacking_described_62()
    local v0 = g_game.getAttackingCreature()
    local v1 = (v0) ~= nil
    if v1 then
        local v2 = (v0):getName()
        local v3 = " "
        local v4 = v2 .. v3 
        local v5 = (v0):getHealthPercent()
        local v6 = format_real_11(v5)
        local v7 = v4 .. v6 
        local v8 = "%"
        local v9 = v7 .. v8 
        local v10 = " at "
        local v11 = v9 .. v10 
        local v12 = (v0):getPosition()
        local v13 = v12.x
        local v14 = v12.y
        local v15 = v12.z
        local v16 = format_real_11(v13)
        local v17 = ""
        local v18 = v17 .. v16 
        local v19 = ","
        local v20 = v18 .. v19 
        local v21 = format_real_11(v14)
        local v22 = v20 .. v21 
        local v23 = v22 .. v19 
        local v24 = format_real_11(v15)
        local v25 = v23 .. v24 
        local v26 = v11 .. v25 
        return v26
    else
        local v27 = "nothing"
        return v27
    end
end

function player_zone_63()
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
        return ticked_17(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v17, v18, v19, v20, v21, v22, v23, v24, v25, v15, v16)
    end
end

function ticked_17(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    local v26 = player_present_12()
    local v27 = v26 == false
    local getv897 = function()
        if v27 then
            local v28 = parity_summary_18()
            local v29 = v28 ~= ""
            if v29 then
                local v30 = "[tibia-probe] "
                local v31 = v30 .. v28 
                write_log_line_9(v31)
            else
            end
            local v32 = "finish: "
            local v33 = "offline"
            local v34 = v32 .. v33 
            local v35 = "[tibia-probe] "
            local v36 = v35 .. v34 
            write_log_line_9(v36)
            local v37 = g_game.isOnline()
            if v37 then
                g_game.safeLogout()
            else
            end
            local v38 = closure3(nil)
            scheduleEvent(v38, 2000)
            return Us1_None()
        else
            local v40 = g_clock.millis()
            local v41 = g_game.getLocalPlayer():getHealth()
            local v42 = spiral_wrap_signed((v15 + 1), 32)
            local v43 = v41 < v23
            local getv44 = function()
                if v43 then
                    return v41
                else
                    return v23
                end
            end
            local v44 = getv44()
            local v45 = v41 <= 0
            if v45 then
                local v46 = g_game.getLocalPlayer():getHealth()
                local v47 = g_game.getLocalPlayer():getExperience()
                local v48 = spiral_wrap_signed((v47 - v5), 32)
                local v49 = format_real_11(v42)
                local v50 = "ticks "
                local v51 = v50 .. v49 
                local v52 = " heals "
                local v53 = v51 .. v52 
                local v54 = format_real_11(v16)
                local v55 = v53 .. v54 
                local v56 = " strikes "
                local v57 = v55 .. v56 
                local v58 = format_real_11(v17)
                local v59 = v57 .. v58 
                local v60 = " holds "
                local v61 = v59 .. v60 
                local v62 = format_real_11(v18)
                local v63 = v61 .. v62 
                local v64 = format_real_11(v20)
                local v65 = " retreats "
                local v66 = v65 .. v64 
                local v67 = " cornered "
                local v68 = v66 .. v67 
                local v69 = format_real_11(v21)
                local v70 = v68 .. v69 
                local v71 = " gated "
                local v72 = v70 .. v71 
                local v73 = format_real_11(v22)
                local v74 = v72 .. v73 
                local v75 = " kills "
                local v76 = v74 .. v75 
                local v77 = format_real_11(v19)
                local v78 = v76 .. v77 
                local v79 = v63 .. v78 
                local v80 = format_real_11(v46)
                local v81 = " health "
                local v82 = v81 .. v80 
                local v83 = " lowest "
                local v84 = v82 .. v83 
                local v85 = format_real_11(v44)
                local v86 = v84 .. v85 
                local v87 = " experience +"
                local v88 = v86 .. v87 
                local v89 = format_real_11(v48)
                local v90 = v88 .. v89 
                local v91 = v79 .. v90 
                local v92 = "dead: "
                local v93 = v92 .. v91 
                local v94 = "[tibia-probe] "
                local v95 = v94 .. v93 
                write_log_line_9(v95)
                local v96 = parity_summary_18()
                local v97 = v96 ~= ""
                if v97 then
                    local v98 = v94 .. v96 
                    write_log_line_9(v98)
                else
                end
                local v99 = "finish: "
                local v100 = "death"
                local v101 = v99 .. v100 
                local v102 = v94 .. v101 
                write_log_line_9(v102)
                local v103 = g_game.isOnline()
                if v103 then
                    g_game.safeLogout()
                else
                end
                local v104 = closure3(nil)
                scheduleEvent(v104, 2000)
                return Us1_None()
            else
                local v106 = forget_dead_19(v8)
                local v107 = spiral_wrap_signed((v19 + v106), 32)
                local v108 = g_game.getLocalPlayer():getPosition()
                local v109 = v108.x
                local v110 = v108.y
                local v111 = v108.z
                local v112 = g_map.getSpectators({ x = v109, y = v110, z = v111 }, false)
                if v10 then
                    local v113 = v13 ~= nil and v13.l0
                    local v114 = v113 < 0
                    if v114 then
                        local v115 = format_real_11(v109)
                        local v116 = ""
                        local v117 = v116 .. v115 
                        local v118 = ","
                        local v119 = v117 .. v118 
                        local v120 = format_real_11(v110)
                        local v121 = v119 .. v120 
                        local v122 = v121 .. v118 
                        local v123 = format_real_11(v111)
                        local v124 = v122 .. v123 
                        local v125 = "start positions: knight "
                        local v126 = v125 .. v124 
                        local v127 = " monsters "
                        local v128 = v126 .. v127 
                        local v129 = 1
                        local v130 = positions_from_23(v112, v129, v116)
                        local v131 = v128 .. v130 
                        local v132 = "[tibia-probe] "
                        local v133 = v132 .. v131 
                        write_log_line_9(v133)
                    else
                        local v134 = spiral_wrap_signed((v40 - v113), 32)
                        local v135 = 1
                        local v136 = 0
                        local v137 = adjacent_from_13(v109, v110, v111, v112, v135, v136)
                        local v138 = v11 ~= nil and v11.l0
                        local v139 = spiral_wrap_signed(spiral_mul_mod32(v137, v134), 32)
                        local v140 = spiral_wrap_signed((v138 + v139), 32)
                        v11.l0 = v140
                        local v141 = v137 > 3
                        local getv142 = function()
                            if v141 then
                                return 3
                            else
                                return v137
                            end
                        end
                        local v142 = getv142()
                        local v143 = (v14)[(v142)+1]
                        local v144 = spiral_wrap_signed((v143 + v134), 32)
                        v14[(v142)+1] = v144
                    end
                    v13.l0 = v40
                else
                end
                local v145 = g_game.getAttackingCreature()
                local v146 = 1
                local v147 = false
                local v148 = 0
                local v149 = 999
                local v150, v151, v152 = (table.unpack or unpack)(scan_sight_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v112, v145, v146, v147, v148, v149))
                local v153 = 1
                local v154 = 0
                local v155 = false
                local v156 = 0
                local v157, v158, v159 = (table.unpack or unpack)(scan_threats_26(v109, v110, v111, v112, v153, v154, v155, v156))
                local v160 = spiral_wrap_signed((v40 - v24), 32)
                local v161 = v160 >= 1000
                local getv163 = function()
                    if v158 then
                        local v162 = v40 >= v25
                        return v162
                    else
                        return false
                    end
                end
                local v163 = getv163()
                local getv166 = function()
                    if v163 then
                        local v164 = g_game.getLocalPlayer():isWalking()
                        local v165 = v164 == false
                        return v165
                    else
                        return false
                    end
                end
                local v166 = getv166()
                local v167 = v3 > 0
                local getv790 = function()
                    if v167 then
                        local v168 = g_game.getLocalPlayer():getMaxHealth()
                        local v169 = spiral_wrap_signed((v0 - 1), 32)
                        local v170 = spiral_wrap_signed(spiral_mul_mod32(v169, 256), 32)
                        local v171 = (math.modf(v170 / v168))
                        local v172 = spiral_wrap_signed((v171 + 1), 32)
                        local v173 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(66)
                        local v174 = 0
                        fill_27(v173, v174)
                        v173[(0)+1] = -256
                        v173[(7)+1] = v172
                        v173[(48)+1] = 256
                        v173[(15)+1] = 256
                        v173[(55)+1] = 256
                        v173[(17)+1] = 256
                        v173[(21)+1] = -256
                        local v175 = spiral_wrap_signed((v3 - 1), 32)
                        local v176 = spiral_wrap_signed(spiral_mul_mod32(v175, 85), 32)
                        local v177 = spiral_wrap_signed(-(v176), 32)
                        v173[(23)+1] = v177
                        v173[(62)+1] = 1024
                        local v178 = spiral_wrap_signed(spiral_mul_mod32(v41, 256), 32)
                        local v179 = (math.modf(v178 / v168))
                        local getv182 = function()
                            if v150 then
                                local v180 = (v112)[v151]
                                local v181 = (v180):getHealthPercent()
                                return v181
                            else
                                return 0
                            end
                        end
                        local v182 = getv182()
                        local v183 = spiral_wrap_signed(spiral_mul_mod32(v182, 256), 32)
                        local v184 = (math.modf(v183 / 100))
                        local getv185 = function()
                            if v150 then
                                return v152
                            else
                                return 0
                            end
                        end
                        local v185 = getv185()
                        local v186 = v9 ~= nil and v9.l0
                        local v187 = spiral_wrap_signed((v40 - v186), 32)
                        local v188 = v187 >= 2000
                        local v189 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(8)
                        local v190 = 0
                        fill_28(v189, v190)
                        v189[(7)+1] = 256
                        v189[(0)+1] = v179
                        local v191 = spiral_wrap_signed(spiral_mul_mod32(v157, 85), 32)
                        v189[(1)+1] = v191
                        local getv192 = function()
                            if v161 then
                                return 256
                            else
                                return 0
                            end
                        end
                        local v192 = getv192()
                        v189[(4)+1] = v192
                        local getv193 = function()
                            if v188 then
                                return 256
                            else
                                return 0
                            end
                        end
                        local v193 = getv193()
                        v189[(5)+1] = v193
                        v189[(2)+1] = v184
                        local v194 = v185 > 7
                        local getv195 = function()
                            if v194 then
                                return 7
                            else
                                return v185
                            end
                        end
                        local v195 = getv195()
                        local v196 = spiral_wrap_signed(spiral_mul_mod32(v195, 32), 32)
                        v189[(3)+1] = v196
                        v189[(6)+1] = 0
                        local v197 = (function(n) local t = {} for i = 1, n do t[i] = 0 end return t end)(6)
                        local v198 = 0
                        fill_29(v197, v198)
                        local v199 = 0
                        activate_30(v173, v189, v197, v199)
                        local v200 = 0
                        local v201 = 0
                        local v202 = 0
                        local v203 = output_sum_32(v173, v197, v200, v201, v202)
                        local v204 = (math.modf(v203 / 256))
                        local v205 = 1
                        local v206 = 0
                        local v207 = 0
                        local v208 = output_sum_32(v173, v197, v205, v206, v207)
                        local v209 = (math.modf(v208 / 256))
                        local v210 = 2
                        local v211 = 0
                        local v212 = 0
                        local v213 = output_sum_32(v173, v197, v210, v211, v212)
                        local v214 = (math.modf(v213 / 256))
                        local v215 = v204 > 0
                        local v216 = v209 > 0
                        local getv218 = function()
                            if v216 then
                                local v217 = v209 >= v214
                                return v217
                            else
                                return false
                            end
                        end
                        local v218 = getv218()
                        local v219 = v214 > 0
                        local getv221 = function()
                            if v219 then
                                local v220 = v214 > v209
                                return v220
                            else
                                return false
                            end
                        end
                        local v221 = getv221()
                        local getv222 = function()
                            if v215 then
                                return 1
                            else
                                return 0
                            end
                        end
                        local v222 = getv222()
                        local getv223 = function()
                            if v218 then
                                return 2
                            else
                                return 0
                            end
                        end
                        local v223 = getv223()
                        local v224 = spiral_wrap_signed((v222 + v223), 32)
                        local getv225 = function()
                            if v221 then
                                return 4
                            else
                                return 0
                            end
                        end
                        local v225 = getv225()
                        local v226 = spiral_wrap_signed((v224 + v225), 32)
                        local v227 = math.fmod(v226, 2)
                        local v228 = v227 == 1
                        local v229 = (v228) and (v161)
                        local getv250 = function()
                            if v229 then
                                local v230 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                                local getv233 = function()
                                    if v230 then
                                        local v231 = "heal (potion) at health "
                                        return v231
                                    else
                                        local v232 = "heal dropped by the action gate at health "
                                        return v232
                                    end
                                end
                                local v233 = getv233()
                                local v234 = format_real_11(v41)
                                local v235 = v233 .. v234 
                                local v236 = "[tibia-probe] "
                                local v237 = v236 .. v235 
                                write_log_line_9(v237)
                                if v230 then
                                    local v238 = spiral_wrap_signed((v16 + 1), 32)
                                    return { [1]=v42, [2]=v238, [3]=v17, [4]=v18, [5]=v107, [6]=v20, [7]=v21, [8]=v22, [9]=v44, [10]=v40, [11]=v25 }
                                else
                                    return { [1]=v42, [2]=v16, [3]=v17, [4]=v18, [5]=v107, [6]=v20, [7]=v21, [8]=v22, [9]=v44, [10]=v24, [11]=v25 }
                                end
                            else
                                return { [1]=v42, [2]=v16, [3]=v17, [4]=v18, [5]=v107, [6]=v20, [7]=v21, [8]=v22, [9]=v44, [10]=v24, [11]=v25 }
                            end
                        end
                        local v250, v251, v252, v253, v254, v255, v256, v257, v258, v259, v260 = (table.unpack or unpack)(getv250())
                        local v261 = (math.modf(v226 / 4))
                        local v262 = math.fmod(v261, 2)
                        local v263 = v262 == 1
                        local v264 = (v263) and (v166)
                        local getv366 = function()
                            if v264 then
                                local v265 = (v112)[v159]
                                local v266 = (v265):getPosition()
                                local v267 = v266.x
                                local v268 = v266.y
                                local v269 = v266.z
                                local v270 = false
                                chasing_16(v270)
                                local v271 = spiral_wrap_signed((v109 - v267), 32)
                                local v272 = v271 > 0
                                local getv275 = function()
                                    if v272 then
                                        return 1
                                    else
                                        local v273 = v271 < 0
                                        if v273 then
                                            return -1
                                        else
                                            return 0
                                        end
                                    end
                                end
                                local v275 = getv275()
                                local v276 = spiral_wrap_signed((v110 - v268), 32)
                                local v277 = v276 > 0
                                local getv280 = function()
                                    if v277 then
                                        return 1
                                    else
                                        local v278 = v276 < 0
                                        if v278 then
                                            return -1
                                        else
                                            return 0
                                        end
                                    end
                                end
                                local v280 = getv280()
                                local v281 = g_clock.millis()
                                local v282 = 0
                                local v283, v284 = (table.unpack or unpack)(attempt_from_33(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v267, v268, v269, v112, v275, v280, v281, v282))
                                local getv285 = function()
                                    if v283 ~= nil and v283.tag == "Us2_Cornered" then
                                        return true
                                    else
                                        return false
                                    end
                                end
                                local v285 = getv285()
                                local getv289 = function()
                                    if v285 then
                                        local v286 = spiral_wrap_signed((v256 + 1), 32)
                                        local v287 = math.fmod(v286, 50)
                                        local v288 = v287 == 1
                                        return v288
                                    else
                                        return false
                                    end
                                end
                                local v289 = getv289()
                                if v289 then
                                    local v290 = format_real_11(v109)
                                    local v291 = ""
                                    local v292 = v291 .. v290 
                                    local v293 = ","
                                    local v294 = v292 .. v293 
                                    local v295 = format_real_11(v110)
                                    local v296 = v294 .. v295 
                                    local v297 = v296 .. v293 
                                    local v298 = format_real_11(v111)
                                    local v299 = v297 .. v298 
                                    local v300 = "cornered at "
                                    local v301 = v300 .. v299 
                                    local v302 = " threat "
                                    local v303 = v301 .. v302 
                                    local v304 = format_real_11(v267)
                                    local v305 = v291 .. v304 
                                    local v306 = v305 .. v293 
                                    local v307 = format_real_11(v268)
                                    local v308 = v306 .. v307 
                                    local v309 = v308 .. v293 
                                    local v310 = format_real_11(v269)
                                    local v311 = v309 .. v310 
                                    local v312 = v303 .. v311 
                                    local v313 = 1
                                    local v314 = adjacent_from_55(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v267, v268, v269, v112, v275, v280, v281, v313, v291)
                                    local v315 = 0
                                    local v316 = rejected_from_56(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v267, v268, v269, v112, v275, v280, v281, v315, v291)
                                    local v317 = " adjacent ["
                                    local v318 = v312 .. v317 
                                    local v319 = v318 .. v314 
                                    local v320 = "] candidates ["
                                    local v321 = v319 .. v320 
                                    local v322 = v321 .. v316 
                                    local v323 = "]"
                                    local v324 = v322 .. v323 
                                    local v325 = "[tibia-probe] "
                                    local v326 = v325 .. v324 
                                    write_log_line_9(v326)
                                else
                                end
                                if v283 ~= nil and v283.tag == "Us2_Cornered" then
                                    local v329 = spiral_wrap_signed((v256 + 1), 32)
                                    return { [1]=false, [2]=v250, [3]=v251, [4]=v252, [5]=v253, [6]=v254, [7]=v255, [8]=v329, [9]=v257, [10]=v258, [11]=v259, [12]=v260 }
                                elseif v283 ~= nil and v283.tag == "Us2_Gated" then
                                    local v328 = spiral_wrap_signed((v257 + 1), 32)
                                    return { [1]=false, [2]=v250, [3]=v251, [4]=v252, [5]=v253, [6]=v254, [7]=v255, [8]=v256, [9]=v328, [10]=v258, [11]=v259, [12]=v260 }
                                elseif v283 ~= nil and v283.tag == "Us2_Stepped" then
                                    local v327 = spiral_wrap_signed((v255 + 1), 32)
                                    return { [1]=true, [2]=v250, [3]=v251, [4]=v252, [5]=v253, [6]=v254, [7]=v327, [8]=v256, [9]=v257, [10]=v258, [11]=v259, [12]=v284 }
                                end
                            else
                                return { [1]=false, [2]=v250, [3]=v251, [4]=v252, [5]=v253, [6]=v254, [7]=v255, [8]=v256, [9]=v257, [10]=v258, [11]=v259, [12]=v260 }
                            end
                        end
                        local v366, v367, v368, v369, v370, v371, v372, v373, v374, v375, v376, v377 = (table.unpack or unpack)(getv366())
                        if v366 then
                            return { [1]=v367, [2]=v368, [3]=v369, [4]=v370, [5]=v371, [6]=v372, [7]=v373, [8]=v374, [9]=v375, [10]=v376, [11]=v377 }
                        else
                            local v378 = (math.modf(v226 / 2))
                            local v379 = math.fmod(v378, 2)
                            local v380 = v379 == 1
                            local v381 = (v380) and (v150)
                            if v381 then
                                local v382 = v150 == false
                                local getv385 = function()
                                    if v382 then
                                        return 0
                                    else
                                        local v383 = v152 <= 1
                                        if v383 then
                                            return 1
                                        else
                                            return 2
                                        end
                                    end
                                end
                                local v385 = getv385()
                                local v386 = v385 == 2
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
                                    local v393 = v6 ~= nil and v6.l0
                                    local v394 = spiral_wrap_signed((v392 - v393), 32)
                                    local v395 = "chase "
                                    local v396 = v395 .. v391 
                                    local v397 = " @t+"
                                    local v398 = v396 .. v397 
                                    local v399 = format_real_11(v394)
                                    local v400 = v398 .. v399 
                                    local v401 = "[tibia-probe] "
                                    local v402 = v401 .. v400 
                                    write_log_line_9(v402)
                                else
                                end
                                chasing_16(v386)
                                local v403 = (v112)[v151]
                                local v404 = g_game.getAttackingCreature()
                                local v405 = (v404) == (v403)
                                local v406 = v405 == false
                                if v406 then
                                    g_game.attack(v403)
                                    remember_57(v8, v403)
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
                                    local v411 = " "
                                    local v412 = v409 .. v411 
                                    local v413 = v412 .. v410 
                                    local v414 = (v403):getPosition()
                                    local v415 = v414.x
                                    local v416 = v414.y
                                    local v417 = v414.z
                                    local v418 = format_real_11(v415)
                                    local v419 = ""
                                    local v420 = v419 .. v418 
                                    local v421 = ","
                                    local v422 = v420 .. v421 
                                    local v423 = format_real_11(v416)
                                    local v424 = v422 .. v423 
                                    local v425 = v424 .. v421 
                                    local v426 = format_real_11(v417)
                                    local v427 = v425 .. v426 
                                    local v428 = " at "
                                    local v429 = v428 .. v427 
                                    local v430 = " from "
                                    local v431 = v429 .. v430 
                                    local v432 = format_real_11(v109)
                                    local v433 = v419 .. v432 
                                    local v434 = v433 .. v421 
                                    local v435 = format_real_11(v110)
                                    local v436 = v434 .. v435 
                                    local v437 = v436 .. v421 
                                    local v438 = format_real_11(v111)
                                    local v439 = v437 .. v438 
                                    local v440 = v431 .. v439 
                                    local v441 = v413 .. v440 
                                    local v442 = g_clock.millis()
                                    local v443 = v6 ~= nil and v6.l0
                                    local v444 = spiral_wrap_signed((v442 - v443), 32)
                                    local v445 = " health "
                                    local v446 = v441 .. v445 
                                    local v447 = format_real_11(v41)
                                    local v448 = v446 .. v447 
                                    local v449 = " @t+"
                                    local v450 = v448 .. v449 
                                    local v451 = format_real_11(v444)
                                    local v452 = v450 .. v451 
                                    local v453 = "[tibia-probe] "
                                    local v454 = v453 .. v452 
                                    write_log_line_9(v454)
                                else
                                end
                                local v455 = spiral_wrap_signed((v369 + 1), 32)
                                return { [1]=v367, [2]=v368, [3]=v455, [4]=v370, [5]=v371, [6]=v372, [7]=v373, [8]=v374, [9]=v375, [10]=v376, [11]=v377 }
                            else
                                local v456 = g_game.isAttacking()
                                local getv462 = function()
                                    if v456 then
                                        local v457 = v150 == false
                                        local getv460 = function()
                                            if v457 then
                                                return 0
                                            else
                                                local v458 = v152 <= 1
                                                if v458 then
                                                    return 1
                                                else
                                                    return 2
                                                end
                                            end
                                        end
                                        local v460 = getv460()
                                        local v461 = v460 == 1
                                        return v461
                                    else
                                        return false
                                    end
                                end
                                local v462 = getv462()
                                if v462 then
                                    g_game.cancelAttack()
                                    local v463 = format_real_11(v41)
                                    local v464 = "hold at health "
                                    local v465 = v464 .. v463 
                                    local v466 = "[tibia-probe] "
                                    local v467 = v466 .. v465 
                                    write_log_line_9(v467)
                                else
                                end
                                local v468 = spiral_wrap_signed((v370 + 1), 32)
                                return { [1]=v367, [2]=v368, [3]=v369, [4]=v468, [5]=v371, [6]=v372, [7]=v373, [8]=v374, [9]=v375, [10]=v376, [11]=v377 }
                            end
                        end
                    else
                        local v491 = v150 == false
                        local getv506 = function()
                            if v161 then
                                local v505 = v41 < v0
                                return v505
                            else
                                return false
                            end
                        end
                        local v506 = getv506()
                        local getv527 = function()
                            if v506 then
                                local v507 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                                local getv510 = function()
                                    if v507 then
                                        local v508 = "heal (potion) at health "
                                        return v508
                                    else
                                        local v509 = "heal dropped by the action gate at health "
                                        return v509
                                    end
                                end
                                local v510 = getv510()
                                local v511 = format_real_11(v41)
                                local v512 = v510 .. v511 
                                local v513 = "[tibia-probe] "
                                local v514 = v513 .. v512 
                                write_log_line_9(v514)
                                if v507 then
                                    local v515 = spiral_wrap_signed((v16 + 1), 32)
                                    return { [1]=v42, [2]=v515, [3]=v17, [4]=v18, [5]=v107, [6]=v20, [7]=v21, [8]=v22, [9]=v44, [10]=v40, [11]=v25 }
                                else
                                    return { [1]=v42, [2]=v16, [3]=v17, [4]=v18, [5]=v107, [6]=v20, [7]=v21, [8]=v22, [9]=v44, [10]=v24, [11]=v25 }
                                end
                            else
                                return { [1]=v42, [2]=v16, [3]=v17, [4]=v18, [5]=v107, [6]=v20, [7]=v21, [8]=v22, [9]=v44, [10]=v24, [11]=v25 }
                            end
                        end
                        local v527, v528, v529, v530, v531, v532, v533, v534, v535, v536, v537 = (table.unpack or unpack)(getv527())
                        local v538 = v2 > 0
                        local getv540 = function()
                            if v538 then
                                local v539 = v157 >= v2
                                return v539
                            else
                                return false
                            end
                        end
                        local v540 = getv540()
                        local v541 = (v540) and (v166)
                        local getv643 = function()
                            if v541 then
                                local v542 = (v112)[v159]
                                local v543 = (v542):getPosition()
                                local v544 = v543.x
                                local v545 = v543.y
                                local v546 = v543.z
                                local v547 = false
                                chasing_16(v547)
                                local v548 = spiral_wrap_signed((v109 - v544), 32)
                                local v549 = v548 > 0
                                local getv552 = function()
                                    if v549 then
                                        return 1
                                    else
                                        local v550 = v548 < 0
                                        if v550 then
                                            return -1
                                        else
                                            return 0
                                        end
                                    end
                                end
                                local v552 = getv552()
                                local v553 = spiral_wrap_signed((v110 - v545), 32)
                                local v554 = v553 > 0
                                local getv557 = function()
                                    if v554 then
                                        return 1
                                    else
                                        local v555 = v553 < 0
                                        if v555 then
                                            return -1
                                        else
                                            return 0
                                        end
                                    end
                                end
                                local v557 = getv557()
                                local v558 = g_clock.millis()
                                local v559 = 0
                                local v560, v561 = (table.unpack or unpack)(attempt_from_33(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v544, v545, v546, v112, v552, v557, v558, v559))
                                local getv562 = function()
                                    if v560 ~= nil and v560.tag == "Us2_Cornered" then
                                        return true
                                    else
                                        return false
                                    end
                                end
                                local v562 = getv562()
                                local getv566 = function()
                                    if v562 then
                                        local v563 = spiral_wrap_signed((v533 + 1), 32)
                                        local v564 = math.fmod(v563, 50)
                                        local v565 = v564 == 1
                                        return v565
                                    else
                                        return false
                                    end
                                end
                                local v566 = getv566()
                                if v566 then
                                    local v567 = format_real_11(v109)
                                    local v568 = ""
                                    local v569 = v568 .. v567 
                                    local v570 = ","
                                    local v571 = v569 .. v570 
                                    local v572 = format_real_11(v110)
                                    local v573 = v571 .. v572 
                                    local v574 = v573 .. v570 
                                    local v575 = format_real_11(v111)
                                    local v576 = v574 .. v575 
                                    local v577 = "cornered at "
                                    local v578 = v577 .. v576 
                                    local v579 = " threat "
                                    local v580 = v578 .. v579 
                                    local v581 = format_real_11(v544)
                                    local v582 = v568 .. v581 
                                    local v583 = v582 .. v570 
                                    local v584 = format_real_11(v545)
                                    local v585 = v583 .. v584 
                                    local v586 = v585 .. v570 
                                    local v587 = format_real_11(v546)
                                    local v588 = v586 .. v587 
                                    local v589 = v580 .. v588 
                                    local v590 = 1
                                    local v591 = adjacent_from_55(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v544, v545, v546, v112, v552, v557, v558, v590, v568)
                                    local v592 = 0
                                    local v593 = rejected_from_56(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v109, v110, v111, v544, v545, v546, v112, v552, v557, v558, v592, v568)
                                    local v594 = " adjacent ["
                                    local v595 = v589 .. v594 
                                    local v596 = v595 .. v591 
                                    local v597 = "] candidates ["
                                    local v598 = v596 .. v597 
                                    local v599 = v598 .. v593 
                                    local v600 = "]"
                                    local v601 = v599 .. v600 
                                    local v602 = "[tibia-probe] "
                                    local v603 = v602 .. v601 
                                    write_log_line_9(v603)
                                else
                                end
                                if v560 ~= nil and v560.tag == "Us2_Cornered" then
                                    local v606 = spiral_wrap_signed((v533 + 1), 32)
                                    return { [1]=false, [2]=v527, [3]=v528, [4]=v529, [5]=v530, [6]=v531, [7]=v532, [8]=v606, [9]=v534, [10]=v535, [11]=v536, [12]=v537 }
                                elseif v560 ~= nil and v560.tag == "Us2_Gated" then
                                    local v605 = spiral_wrap_signed((v534 + 1), 32)
                                    return { [1]=false, [2]=v527, [3]=v528, [4]=v529, [5]=v530, [6]=v531, [7]=v532, [8]=v533, [9]=v605, [10]=v535, [11]=v536, [12]=v537 }
                                elseif v560 ~= nil and v560.tag == "Us2_Stepped" then
                                    local v604 = spiral_wrap_signed((v532 + 1), 32)
                                    return { [1]=true, [2]=v527, [3]=v528, [4]=v529, [5]=v530, [6]=v531, [7]=v604, [8]=v533, [9]=v534, [10]=v535, [11]=v536, [12]=v561 }
                                end
                            else
                                return { [1]=false, [2]=v527, [3]=v528, [4]=v529, [5]=v530, [6]=v531, [7]=v532, [8]=v533, [9]=v534, [10]=v535, [11]=v536, [12]=v537 }
                            end
                        end
                        local v643, v644, v645, v646, v647, v648, v649, v650, v651, v652, v653, v654 = (table.unpack or unpack)(getv643())
                        if v643 then
                            return { [1]=v644, [2]=v645, [3]=v646, [4]=v647, [5]=v648, [6]=v649, [7]=v650, [8]=v651, [9]=v652, [10]=v653, [11]=v654 }
                        else
                            local getv657 = function()
                                if v491 then
                                    return 0
                                else
                                    local v655 = v152 <= 1
                                    if v655 then
                                        return 1
                                    else
                                        return 2
                                    end
                                end
                            end
                            local v657 = getv657()
                            local v658 = v657 == 1
                            local getv667 = function()
                                if v658 then
                                    return Us4_InReach()
                                else
                                    local getv662 = function()
                                        if v491 then
                                            return 0
                                        else
                                            local v660 = v152 <= 1
                                            if v660 then
                                                return 1
                                            else
                                                return 2
                                            end
                                        end
                                    end
                                    local v662 = getv662()
                                    local v663 = v662 == 2
                                    if v663 then
                                        return Us4_OutOfReach()
                                    else
                                        return Us4_NoTarget()
                                    end
                                end
                            end
                            local v667 = getv667()
                            local getv679 = function()
                                if v667 ~= nil and v667.tag == "Us4_InReach" then
                                    local v668 = v41 >= v1
                                    if v668 then
                                        return Us5_Strike()
                                    else
                                        return Us5_Hold()
                                    end
                                elseif v667 ~= nil and v667.tag == "Us4_NoTarget" then
                                    return Us5_Hold()
                                elseif v667 ~= nil and v667.tag == "Us4_OutOfReach" then
                                    local v672 = v41 >= v1
                                    if v672 then
                                        return Us5_Approach()
                                    else
                                        return Us5_Hold()
                                    end
                                end
                            end
                            local v679 = getv679()
                            local getv682 = function()
                                if v679 ~= nil and v679.tag == "Us5_Approach" then
                                    return 2
                                elseif v679 ~= nil and v679.tag == "Us5_Hold" then
                                    return 0
                                elseif v679 ~= nil and v679.tag == "Us5_Strike" then
                                    return 1
                                end
                            end
                            local v682 = getv682()
                            local v683 = v682 == 1
                            local getv685 = function()
                                if v683 then
                                    return true
                                else
                                    local v684 = v682 == 2
                                    return v684
                                end
                            end
                            local v685 = getv685()
                            if v685 then
                                local v686 = v682 == 2
                                local v687 = g_game.getChaseMode() == ChaseOpponent
                                local v688 = v687 ~= v686
                                if v688 then
                                    local getv691 = function()
                                        if v686 then
                                            local v689 = "on"
                                            return v689
                                        else
                                            local v690 = "off"
                                            return v690
                                        end
                                    end
                                    local v691 = getv691()
                                    local v692 = g_clock.millis()
                                    local v693 = v6 ~= nil and v6.l0
                                    local v694 = spiral_wrap_signed((v692 - v693), 32)
                                    local v695 = "chase "
                                    local v696 = v695 .. v691 
                                    local v697 = " @t+"
                                    local v698 = v696 .. v697 
                                    local v699 = format_real_11(v694)
                                    local v700 = v698 .. v699 
                                    local v701 = "[tibia-probe] "
                                    local v702 = v701 .. v700 
                                    write_log_line_9(v702)
                                else
                                end
                                chasing_16(v686)
                                local v703 = (v112)[v151]
                                local v704 = g_game.getAttackingCreature()
                                local v705 = (v704) == (v703)
                                local v706 = v705 == false
                                if v706 then
                                    g_game.attack(v703)
                                    remember_57(v8, v703)
                                    local getv709 = function()
                                        if v686 then
                                            local v707 = "approach"
                                            return v707
                                        else
                                            local v708 = "strike"
                                            return v708
                                        end
                                    end
                                    local v709 = getv709()
                                    local v710 = (v703):getName()
                                    local v711 = " "
                                    local v712 = v709 .. v711 
                                    local v713 = v712 .. v710 
                                    local v714 = (v703):getPosition()
                                    local v715 = v714.x
                                    local v716 = v714.y
                                    local v717 = v714.z
                                    local v718 = format_real_11(v715)
                                    local v719 = ""
                                    local v720 = v719 .. v718 
                                    local v721 = ","
                                    local v722 = v720 .. v721 
                                    local v723 = format_real_11(v716)
                                    local v724 = v722 .. v723 
                                    local v725 = v724 .. v721 
                                    local v726 = format_real_11(v717)
                                    local v727 = v725 .. v726 
                                    local v728 = " at "
                                    local v729 = v728 .. v727 
                                    local v730 = " from "
                                    local v731 = v729 .. v730 
                                    local v732 = format_real_11(v109)
                                    local v733 = v719 .. v732 
                                    local v734 = v733 .. v721 
                                    local v735 = format_real_11(v110)
                                    local v736 = v734 .. v735 
                                    local v737 = v736 .. v721 
                                    local v738 = format_real_11(v111)
                                    local v739 = v737 .. v738 
                                    local v740 = v731 .. v739 
                                    local v741 = v713 .. v740 
                                    local v742 = g_clock.millis()
                                    local v743 = v6 ~= nil and v6.l0
                                    local v744 = spiral_wrap_signed((v742 - v743), 32)
                                    local v745 = " health "
                                    local v746 = v741 .. v745 
                                    local v747 = format_real_11(v41)
                                    local v748 = v746 .. v747 
                                    local v749 = " @t+"
                                    local v750 = v748 .. v749 
                                    local v751 = format_real_11(v744)
                                    local v752 = v750 .. v751 
                                    local v753 = "[tibia-probe] "
                                    local v754 = v753 .. v752 
                                    write_log_line_9(v754)
                                else
                                end
                                local v755 = spiral_wrap_signed((v646 + 1), 32)
                                return { [1]=v644, [2]=v645, [3]=v755, [4]=v647, [5]=v648, [6]=v649, [7]=v650, [8]=v651, [9]=v652, [10]=v653, [11]=v654 }
                            else
                                local v756 = g_game.isAttacking()
                                local getv761 = function()
                                    if v756 then
                                        local getv759 = function()
                                            if v491 then
                                                return 0
                                            else
                                                local v757 = v152 <= 1
                                                if v757 then
                                                    return 1
                                                else
                                                    return 2
                                                end
                                            end
                                        end
                                        local v759 = getv759()
                                        local v760 = v759 == 1
                                        return v760
                                    else
                                        return false
                                    end
                                end
                                local v761 = getv761()
                                if v761 then
                                    g_game.cancelAttack()
                                    local v762 = format_real_11(v41)
                                    local v763 = "hold at health "
                                    local v764 = v763 .. v762 
                                    local v765 = "[tibia-probe] "
                                    local v766 = v765 .. v764 
                                    write_log_line_9(v766)
                                else
                                end
                                local v767 = spiral_wrap_signed((v647 + 1), 32)
                                return { [1]=v644, [2]=v645, [3]=v646, [4]=v767, [5]=v648, [6]=v649, [7]=v650, [8]=v651, [9]=v652, [10]=v653, [11]=v654 }
                            end
                        end
                    end
                end
                local v790, v791, v792, v793, v794, v795, v796, v797, v798, v799, v800 = (table.unpack or unpack)(getv790())
                local v801 = math.fmod(v790, 10)
                local v802 = v801 == 0
                if v802 then
                    local v803 = g_game.getLocalPlayer():getPosition()
                    local v804 = v803.x
                    local v805 = v803.y
                    local v806 = v803.z
                    local v807 = format_real_11(v804)
                    local v808 = "seen at "
                    local v809 = v808 .. v807 
                    local v810 = ","
                    local v811 = v809 .. v810 
                    local v812 = format_real_11(v805)
                    local v813 = v811 .. v812 
                    local v814 = ": "
                    local v815 = v813 .. v814 
                    local v816 = monsters_described_59(v804, v805, v806)
                    local v817 = v815 .. v816 
                    local v818 = "[tibia-probe] "
                    local v819 = v818 .. v817 
                    write_log_line_9(v819)
                else
                end
                local v820 = math.fmod(v790, 100)
                local v821 = v820 == 0
                if v821 then
                    local v822 = attacking_described_62()
                    local v823 = g_game.getLocalPlayer():getPosition()
                    local v824 = v823.x
                    local v825 = v823.y
                    local v826 = v823.z
                    local v827 = format_real_11(v824)
                    local v828 = ""
                    local v829 = v828 .. v827 
                    local v830 = ","
                    local v831 = v829 .. v830 
                    local v832 = format_real_11(v825)
                    local v833 = v831 .. v832 
                    local v834 = v833 .. v830 
                    local v835 = format_real_11(v826)
                    local v836 = v834 .. v835 
                    local v837 = player_zone_63()
                    local v838 = " attacking "
                    local v839 = v838 .. v822 
                    local v840 = " player at "
                    local v841 = v839 .. v840 
                    local v842 = v841 .. v836 
                    local v843 = " pz "
                    local v844 = v842 .. v843 
                    local v845 = v844 .. v837 
                    local v846 = g_game.getLocalPlayer():getHealth()
                    local v847 = g_game.getLocalPlayer():getExperience()
                    local v848 = spiral_wrap_signed((v847 - v5), 32)
                    local v849 = format_real_11(v790)
                    local v850 = "ticks "
                    local v851 = v850 .. v849 
                    local v852 = " heals "
                    local v853 = v851 .. v852 
                    local v854 = format_real_11(v791)
                    local v855 = v853 .. v854 
                    local v856 = " strikes "
                    local v857 = v855 .. v856 
                    local v858 = format_real_11(v792)
                    local v859 = v857 .. v858 
                    local v860 = " holds "
                    local v861 = v859 .. v860 
                    local v862 = format_real_11(v793)
                    local v863 = v861 .. v862 
                    local v864 = format_real_11(v795)
                    local v865 = " retreats "
                    local v866 = v865 .. v864 
                    local v867 = " cornered "
                    local v868 = v866 .. v867 
                    local v869 = format_real_11(v796)
                    local v870 = v868 .. v869 
                    local v871 = " gated "
                    local v872 = v870 .. v871 
                    local v873 = format_real_11(v797)
                    local v874 = v872 .. v873 
                    local v875 = " kills "
                    local v876 = v874 .. v875 
                    local v877 = format_real_11(v794)
                    local v878 = v876 .. v877 
                    local v879 = v863 .. v878 
                    local v880 = format_real_11(v846)
                    local v881 = " health "
                    local v882 = v881 .. v880 
                    local v883 = " lowest "
                    local v884 = v882 .. v883 
                    local v885 = format_real_11(v798)
                    local v886 = v884 .. v885 
                    local v887 = " experience +"
                    local v888 = v886 .. v887 
                    local v889 = format_real_11(v848)
                    local v890 = v888 .. v889 
                    local v891 = v879 .. v890 
                    local v892 = v891 .. v845 
                    local v893 = "[tibia-probe] "
                    local v894 = v893 .. v892 
                    write_log_line_9(v894)
                else
                end
                return Us1_Some(v790, v791, v792, v793, v794, v795, v796, v797, v798, v799, v800)
            end
        end
    end
    local v897 = getv897()
    if v897 ~= nil and v897.tag == "Us1_None" then
        return nil
    elseif v897 ~= nil and v897.tag == "Us1_Some" then
        local v898 = v897._1
        local v899 = v897._2
        local v900 = v897._3
        local v901 = v897._4
        local v902 = v897._5
        local v903 = v897._6
        local v904 = v897._7
        local v905 = v897._8
        local v906 = v897._9
        local v907 = v897._10
        local v908 = v897._11
        local v909 = g_clock.millis()
        local v910 = v6 ~= nil and v6.l0
        local v911 = spiral_wrap_signed((v909 - v910), 32)
        local v912 = "TIBIA_ARENA_RUN_MS"
        local v913 = 150000
        local v914 = env_i32_0(v912, v913)
        local v915 = v911 > v914
        if v915 then
            local v916 = g_game.getLocalPlayer():getHealth()
            local v917 = g_game.getLocalPlayer():getExperience()
            local v918 = spiral_wrap_signed((v917 - v5), 32)
            local v919 = format_real_11(v898)
            local v920 = "ticks "
            local v921 = v920 .. v919 
            local v922 = " heals "
            local v923 = v921 .. v922 
            local v924 = format_real_11(v899)
            local v925 = v923 .. v924 
            local v926 = " strikes "
            local v927 = v925 .. v926 
            local v928 = format_real_11(v900)
            local v929 = v927 .. v928 
            local v930 = " holds "
            local v931 = v929 .. v930 
            local v932 = format_real_11(v901)
            local v933 = v931 .. v932 
            local v934 = format_real_11(v903)
            local v935 = " retreats "
            local v936 = v935 .. v934 
            local v937 = " cornered "
            local v938 = v936 .. v937 
            local v939 = format_real_11(v904)
            local v940 = v938 .. v939 
            local v941 = " gated "
            local v942 = v940 .. v941 
            local v943 = format_real_11(v905)
            local v944 = v942 .. v943 
            local v945 = " kills "
            local v946 = v944 .. v945 
            local v947 = format_real_11(v902)
            local v948 = v946 .. v947 
            local v949 = v933 .. v948 
            local v950 = format_real_11(v916)
            local v951 = " health "
            local v952 = v951 .. v950 
            local v953 = " lowest "
            local v954 = v952 .. v953 
            local v955 = format_real_11(v906)
            local v956 = v954 .. v955 
            local v957 = " experience +"
            local v958 = v956 .. v957 
            local v959 = format_real_11(v918)
            local v960 = v958 .. v959 
            local v961 = v949 .. v960 
            local v962 = "end: "
            local v963 = v962 .. v961 
            local v964 = "[tibia-probe] "
            local v965 = v964 .. v963 
            write_log_line_9(v965)
            local v966 = parity_summary_18()
            local v967 = v966 ~= ""
            if v967 then
                local v968 = v964 .. v966 
                write_log_line_9(v968)
            else
            end
            local v969 = "finish: "
            local v970 = "run complete"
            local v971 = v969 .. v970 
            local v972 = v964 .. v971 
            write_log_line_9(v972)
            local v973 = g_game.isOnline()
            if v973 then
                g_game.safeLogout()
            else
            end
            local v974 = closure3(nil)
            scheduleEvent(v974, 2000)
            return nil
        else
            local v975 = g_game.getLocalPlayer():getExperience()
            local v976 = spiral_wrap_signed((v975 - v5), 32)
            local v977 = v976 >= v7
            if v977 then
                local v978 = g_clock.millis()
                local v979 = v6 ~= nil and v6.l0
                local v980 = spiral_wrap_signed((v978 - v979), 32)
                local v981 = format_real_11(v980)
                local v982 = "cleared at "
                local v983 = v982 .. v981 
                local v984 = " ms"
                local v985 = v983 .. v984 
                local v986 = "[tibia-probe] "
                local v987 = v986 .. v985 
                write_log_line_9(v987)
                local v988 = g_game.getLocalPlayer():getHealth()
                local v989 = g_game.getLocalPlayer():getExperience()
                local v990 = spiral_wrap_signed((v989 - v5), 32)
                local v991 = format_real_11(v898)
                local v992 = "ticks "
                local v993 = v992 .. v991 
                local v994 = " heals "
                local v995 = v993 .. v994 
                local v996 = format_real_11(v899)
                local v997 = v995 .. v996 
                local v998 = " strikes "
                local v999 = v997 .. v998 
                local v1000 = format_real_11(v900)
                local v1001 = v999 .. v1000 
                local v1002 = " holds "
                local v1003 = v1001 .. v1002 
                local v1004 = format_real_11(v901)
                local v1005 = v1003 .. v1004 
                local v1006 = format_real_11(v903)
                local v1007 = " retreats "
                local v1008 = v1007 .. v1006 
                local v1009 = " cornered "
                local v1010 = v1008 .. v1009 
                local v1011 = format_real_11(v904)
                local v1012 = v1010 .. v1011 
                local v1013 = " gated "
                local v1014 = v1012 .. v1013 
                local v1015 = format_real_11(v905)
                local v1016 = v1014 .. v1015 
                local v1017 = " kills "
                local v1018 = v1016 .. v1017 
                local v1019 = format_real_11(v902)
                local v1020 = v1018 .. v1019 
                local v1021 = v1005 .. v1020 
                local v1022 = format_real_11(v988)
                local v1023 = " health "
                local v1024 = v1023 .. v1022 
                local v1025 = " lowest "
                local v1026 = v1024 .. v1025 
                local v1027 = format_real_11(v906)
                local v1028 = v1026 .. v1027 
                local v1029 = " experience +"
                local v1030 = v1028 .. v1029 
                local v1031 = format_real_11(v990)
                local v1032 = v1030 .. v1031 
                local v1033 = v1021 .. v1032 
                local v1034 = "cleared: "
                local v1035 = v1034 .. v1033 
                local v1036 = v986 .. v1035 
                write_log_line_9(v1036)
                if v10 then
                    local v1037 = v11 ~= nil and v11.l0
                    local v1038 = v12 ~= nil and v12.l0
                    local v1039 = format_real_11(v1037)
                    local v1040 = "adjacency: "
                    local v1041 = v1040 .. v1039 
                    local v1042 = " monster-ms adjacent, "
                    local v1043 = v1041 .. v1042 
                    local v1044 = format_real_11(v1038)
                    local v1045 = v1043 .. v1044 
                    local v1046 = " landed hits, "
                    local v1047 = v1045 .. v1046 
                    local v1048 = v1038
                    local v1049 = (v1048 * 1000.0)
                    local v1050 = v1037 > 1
                    local getv1051 = function()
                        if v1050 then
                            return v1037
                        else
                            return 1
                        end
                    end
                    local v1051 = getv1051()
                    local v1052 = v1051
                    local v1053 = v1049 / v1052
                    local v1054 = string.format("%." .. 3 .. "f", v1053)
                    local v1055 = v1047 .. v1054 
                    local v1056 = " landed hits per adjacent monster-second"
                    local v1057 = v1055 .. v1056 
                    local v1058 = v986 .. v1057 
                    write_log_line_9(v1058)
                    local v1059 = (v14)[(0)+1]
                    local v1060 = (v14)[(1)+1]
                    local v1061 = (v14)[(2)+1]
                    local v1062 = (v14)[(3)+1]
                    local v1063 = format_real_11(v1059)
                    local v1064 = "adjacent time by count: 0 "
                    local v1065 = v1064 .. v1063 
                    local v1066 = " 1 "
                    local v1067 = v1065 .. v1066 
                    local v1068 = format_real_11(v1060)
                    local v1069 = v1067 .. v1068 
                    local v1070 = " 2 "
                    local v1071 = v1069 .. v1070 
                    local v1072 = format_real_11(v1061)
                    local v1073 = v1071 .. v1072 
                    local v1074 = " 3 "
                    local v1075 = v1073 .. v1074 
                    local v1076 = format_real_11(v1062)
                    local v1077 = v1075 .. v1076 
                    local v1078 = v1077 .. v984 
                    local v1079 = v986 .. v1078 
                    write_log_line_9(v1079)
                else
                end
                local v1080 = parity_summary_18()
                local v1081 = v1080 ~= ""
                if v1081 then
                    local v1082 = v986 .. v1080 
                    write_log_line_9(v1082)
                else
                end
                local v1083 = "finish: "
                local v1084 = "cleared"
                local v1085 = v1083 .. v1084 
                local v1086 = v986 .. v1085 
                write_log_line_9(v1086)
                local v1087 = g_game.isOnline()
                if v1087 then
                    g_game.safeLogout()
                else
                end
                local v1088 = closure3(nil)
                scheduleEvent(v1088, 2000)
                return nil
            else
                local v1089 = closure12({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v907, v908, v898, v899, v900, v901, v902, v903, v904, v905, v906 })
                scheduleEvent(v1089, 100)
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
        local v21 = ""
        local v22 = v21 .. v20 
        local v23 = ","
        local v24 = v22 .. v23 
        local v25 = format_real_11(v18)
        local v26 = v24 .. v25 
        local v27 = v26 .. v23 
        local v28 = format_real_11(v19)
        local v29 = v27 .. v28 
        local v30 = "policy starts at "
        local v31 = v30 .. v29 
        local v32 = format_real_11(v0)
        local v33 = " thresholds heal<"
        local v34 = v33 .. v32 
        local v35 = " strike>="
        local v36 = v34 .. v35 
        local v37 = format_real_11(v1)
        local v38 = v36 .. v37 
        local v39 = " kite at "
        local v40 = v38 .. v39 
        local v41 = format_real_11(v3)
        local v42 = v40 .. v41 
        local v43 = " retreat at "
        local v44 = v42 .. v43 
        local v45 = format_real_11(v2)
        local v46 = v44 .. v45 
        local v47 = v31 .. v46 
        local v48 = "TIBIA_ARENA_TARGETING"
        local v49 = "current"
        local v50 = env_text_4(v48, v49)
        local v51 = os.time()
        local v52 = " targeting "
        local v53 = v47 .. v52 
        local v54 = v53 .. v50 
        local v55 = " wall "
        local v56 = v54 .. v55 
        local v57 = format_real_11(v51)
        local v58 = v56 .. v57 
        local v59 = "[tibia-probe] "
        local v60 = v59 .. v58 
        write_log_line_9(v60)
        local v61 = g_clock.millis()
        v5.l0 = v61
        local v62 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v63 = 90
        local v64 = env_i32_0(v62, v63)
        local v65 = 0
        local v66 = 0
        local v67 = 0
        local v68 = 0
        local v69 = 0
        local v70 = 0
        local v71 = 0
        local v72 = 0
        local v73 = 999
        local v74 = -1000
        local v75 = 0
        return ticked_17(v0, v1, v2, v3, v4, v15, v5, v64, v9, v6, v10, v11, v12, v13, v14, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75)
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = (table.unpack or unpack)(capt)
    return function(dom)
        local v15 = g_game.getLocalPlayer():getExperience()
        local v16 = false
        chasing_16(v16)
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
        local v18 = "in game as "
        local v19 = v18 .. v15 
        local v20 = " health "
        local v21 = v19 .. v20 
        local v22 = format_real_11(v16)
        local v23 = v21 .. v22 
        local v24 = " mana "
        local v25 = v23 .. v24 
        local v26 = format_real_11(v17)
        local v27 = v25 .. v26 
        local v28 = "[tibia-probe] "
        local v29 = v28 .. v27 
        write_log_line_9(v29)
        local v30 = g_clock.millis()
        v8.l0 = v30
        local v31 = closure7({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 })
        on_position_change_15(v31)
        local v32 = closure10({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 })
        scheduleEvent(v32, 1500)
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
        local v0 = parity_summary_18()
        local v1 = v0 ~= ""
        if v1 then
            local v2 = "[tibia-probe] "
            local v3 = v2 .. v0 
            write_log_line_9(v3)
        else
        end
        local v4 = "finish: "
        local v5 = "timeout"
        local v6 = v4 .. v5 
        local v7 = "[tibia-probe] "
        local v8 = v7 .. v6 
        write_log_line_9(v8)
        local v9 = g_game.isOnline()
        if v9 then
            g_game.safeLogout()
        else
        end
        local v10 = closure3(nil)
        scheduleEvent(v10, 2000)
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
local v15 = { __tag = "Mut0", l0 = 0 }
local v16 = { __tag = "Mut0", l0 = -2000 }
local v17 = { __tag = "Mut0", l0 = 0 }
local v18 = { __tag = "Mut0", l0 = 0 }
local v19 = Uh0_Nil()
local v20 = { __tag = "Mut1", l0 = v19 }
local v21 = "TIBIA_ARENA_ADJACENCY"
local v22 = get_environment_variable_1(v21)
local v23 = v22 == "1"
local v24 = { __tag = "Mut0", l0 = 0 }
local v25 = { __tag = "Mut0", l0 = 0 }
local v26 = { __tag = "Mut0", l0 = -1 }
local v27 = { 0, 0, 0, 0 }
local v28 = "TIBIA_ARENA_RUN_MS"
local v29 = 150000
local v30 = env_i32_0(v28, v29)
local v31 = spiral_wrap_signed((v30 + 50000), 32)
local v32 = "TIBIA_ARENA_CHARACTER"
local v33 = "Knight Sample"
local v34 = env_text_4(v32, v33)
local v35 = "_1511"
local v36 = v34 .. v35 
disable_client_bot_5(v36)
local v37 = env_text_4(v32, v33)
local v38 = "TIBIA_PROBE_HIDDEN"
local v39 = get_environment_variable_1(v38)
local v40 = v39 == "1"
if v40 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_6()
local v41 = closure0(nil)
scheduleEvent(v41, 200)
scheduleEvent(v41, 1000)
local v42 = closure1({ v37, v2, v5, v8, v11, v14, v15, v16, v17, v18, v20, v23, v24, v25, v26, v27, v2, v5, v8, v11, v14, v15, v16, v17, v18, v20, v23, v24, v25, v26, v27 })
scheduleEvent(v42, 3000)
local v43 = closure14(nil)
scheduleEvent(v43, v31)
return 0
