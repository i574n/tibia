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
local Mut0, Uh0_Cons, Mut1, Mut2, Us0_Some, Us0_None, Us1_Some, Us1_None, Us2_Drink, Us2_Engage, Us2_StepSomewhere, Us2_Stand, Us3_Some, Us3_None, get_environment_variable_1, env_text_0, disable_client_bot_2, mute_3, closure0, file_exists_5, log_flush_7, write_log_line_6, closure3, typed_c2, format_real_8, closure5, typed_c4, chasing_9, method11, method12, env_i32_10, player_present_14, parity_summary_15, method17, method18, method19, forget_dead_16, live_monster_21, scan_20, method23, remember_22, diagonal_south_27, diagonal_step_26, south_or_west_step_25, step_24, closure9, ticked_13, closure8, closure7, closure6, closure10, poll_4, closure1, closure11
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1, v2) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1,  _3 = v2 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

function Us1_Some(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) return { tag = "Us1_Some",  _1 = v0,  _2 = v1,  _3 = v2,  _4 = v3,  _5 = v4,  _6 = v5,  _7 = v6,  _8 = v7,  _9 = v8,  _10 = v9 } end
function Us1_None() return { tag = "Us1_None" } end

function Us2_Drink() return { tag = "Us2_Drink" } end
function Us2_Engage() return { tag = "Us2_Engage" } end
function Us2_StepSomewhere() return { tag = "Us2_StepSomewhere" } end
function Us2_Stand() return { tag = "Us2_Stand" } end

function Us3_Some(v0, v1) return { tag = "Us3_Some",  _1 = v0,  _2 = v1 } end
function Us3_None() return { tag = "Us3_None" } end

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
    local v1 = (v0 .. "\n")
    g_resources.writeFileContents("/tibia-probe.log", v1)
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
        local v2 = ("game login error: " .. v1)
        local v3 = ("[tibia-probe] " .. v2)
        write_log_line_6(v3)
        local v4 = "[tibia-probe] finish: game login error"
        write_log_line_6(v4)
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

function format_real_8(v0)
    local v1 = ""
    local v2 = { __tag = "Mut2", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = (v4 .. v3)
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure5(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        local v4 = tostring(v2)
        local v5 = tostring(v3)
        local v6 = g_clock.millis()
        local v7 = v0 ~= nil and v0.l0
        local v8 = spiral_wrap_signed((v6 - v7), 32)
        local v9 = ("server text [" .. v4)
        local v10 = (v9 .. "] t=")
        local v11 = format_real_8(v8)
        local v12 = (v10 .. v11)
        local v13 = (v12 .. ": ")
        local v14 = (v13 .. v5)
        local v15 = ("[tibia-probe] " .. v14)
        return write_log_line_6(v15)
    end
end

function typed_c4(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(v2)
        return closure5({ v0, v1, v2 })
    end
end

function chasing_9(v0)
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

function method11(v0, v1, v2)
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
            return method11(v0, v1, v12)
        else
            return v2
        end
    end
end

function method12(v0, v1)
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
            return method12(v0, v3)
        else
            return v3
        end
    end
end

function env_i32_10(v0, v1)
    local v2 = get_environment_variable_1(v0)
    local v3 = string.len(v2)
    local v4 = 0
    local v5 = method11(v2, v3, v4)
    local v6 = spiral_wrap_signed((v3 - 1), 32)
    local v7 = string.sub(v2, (v5)+1, (v6)+1)
    local v8 = string.len(v7)
    local v9 = method12(v7, v8)
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

function player_present_14()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function parity_summary_15()
    local v0 = ArenaParity ~= nil
    if v0 then
        local v1 = ArenaParity.summary()
        return v1
    else
        local v2 = ""
        return v2
    end
end

function method17(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method17(v4, v1)
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

function method18(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method18(v4, v1)
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

function method19(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = spiral_wrap_signed((v1 + 1), 32)
        return method19(v4, v5)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function forget_dead_16(v0)
    local v1 = v0 ~= nil and v0.l0
    local v2 = Uh0_Nil()
    local v3 = method17(v1, v2)
    local v4 = v0 ~= nil and v0.l0
    local v5 = Uh0_Nil()
    local v6 = method18(v4, v5)
    v0.l0 = v6
    local v7 = 0
    return method19(v3, v7)
end

function live_monster_21(v0)
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

function scan_20(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 > v4
    if v7 then
        return v6
    else
        local v8 = spiral_wrap_signed((v5 + 1), 32)
        local v9 = (v3)[v5]
        local v10 = live_monster_21(v9)
        local getv33 = function()
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
                local getv30 = function()
                    if v6 ~= nil and v6.tag == "Us3_None" then
                        local v28 = v24 < 999
                        return v28
                    elseif v6 ~= nil and v6.tag == "Us3_Some" then
                        local v25 = v6._1
                        local v26 = v6._2
                        local v27 = v24 < v26
                        return v27
                    end
                end
                local v30 = getv30()
                if v30 then
                    return Us3_Some(v5, v24)
                else
                    return v6
                end
            else
                return v6
            end
        end
        local v33 = getv33()
        return scan_20(v0, v1, v2, v3, v4, v8, v33)
    end
end

function method23(v0, v1, v2)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v3 = v1._1
        local v4 = v1._2
        local v5 = v1._3
        local v6 = method23(v0, v5, v2)
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

function remember_22(v0, v1)
    local v2 = (v1):getId()
    local v3 = v0 ~= nil and v0.l0
    local v4 = Uh0_Nil()
    local v5 = method23(v2, v3, v4)
    local v6 = Uh0_Cons(v2, v1, v5)
    v0.l0 = v6
    return nil
end

function diagonal_south_27(v0, v1)
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

function diagonal_step_26(v0, v1)
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
            return diagonal_south_27(v0, v1)
        end
    end
end

function south_or_west_step_25(v0, v1)
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
            return diagonal_step_26(v0, v1)
        end
    end
end

function step_24(v0, v1)
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
            return south_or_west_step_25(v0, v1)
        end
    end
end

function closure9(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 = (table.unpack or unpack)(capt)
    return function(dom)
        return ticked_13(v0, v1, v2, v3, v5, v6, v7, v8, v9, v10, v11, v12, v13, v4)
    end
end

function ticked_13(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13)
    local v14 = player_present_14()
    local v15 = v14 == false
    local getv333 = function()
        if v15 then
            local v16 = parity_summary_15()
            local v17 = v16 ~= ""
            if v17 then
                local v18 = ("[tibia-probe] " .. v16)
                write_log_line_6(v18)
            else
            end
            local v19 = "[tibia-probe] finish: offline"
            write_log_line_6(v19)
            local v20 = g_game.isOnline()
            if v20 then
                g_game.safeLogout()
            else
            end
            local v21 = closure3(nil)
            scheduleEvent(v21, 2000)
            return Us1_None()
        else
            local v23 = g_clock.millis()
            local v24 = g_game.getLocalPlayer():getHealth()
            local v25 = spiral_wrap_signed((v4 + 1), 32)
            local v26 = v24 < v12
            local getv27 = function()
                if v26 then
                    return v24
                else
                    return v12
                end
            end
            local v27 = getv27()
            local v28 = v24 <= 0
            if v28 then
                local v29 = g_game.getLocalPlayer():getHealth()
                local v30 = g_game.getLocalPlayer():getExperience()
                local v31 = spiral_wrap_signed((v30 - v0), 32)
                local v32 = format_real_8(v25)
                local v33 = ("ticks " .. v32)
                local v34 = (v33 .. " heals ")
                local v35 = format_real_8(v5)
                local v36 = (v34 .. v35)
                local v37 = (v36 .. " strikes ")
                local v38 = format_real_8(v6)
                local v39 = (v37 .. v38)
                local v40 = (v39 .. " holds ")
                local v41 = format_real_8(v7)
                local v42 = (v40 .. v41)
                local v43 = format_real_8(v9)
                local v44 = (" retreats " .. v43)
                local v45 = (v44 .. " cornered ")
                local v46 = format_real_8(v10)
                local v47 = (v45 .. v46)
                local v48 = (v47 .. " gated ")
                local v49 = format_real_8(v11)
                local v50 = (v48 .. v49)
                local v51 = (v50 .. " kills ")
                local v52 = format_real_8(v8)
                local v53 = (v51 .. v52)
                local v54 = (v42 .. v53)
                local v55 = format_real_8(v29)
                local v56 = (" health " .. v55)
                local v57 = (v56 .. " lowest ")
                local v58 = format_real_8(v27)
                local v59 = (v57 .. v58)
                local v60 = (v59 .. " experience +")
                local v61 = format_real_8(v31)
                local v62 = (v60 .. v61)
                local v63 = (v54 .. v62)
                local v64 = ("dead: " .. v63)
                local v65 = ("[tibia-probe] " .. v64)
                write_log_line_6(v65)
                local v66 = parity_summary_15()
                local v67 = v66 ~= ""
                if v67 then
                    local v68 = ("[tibia-probe] " .. v66)
                    write_log_line_6(v68)
                else
                end
                local v69 = "[tibia-probe] finish: death"
                write_log_line_6(v69)
                local v70 = g_game.isOnline()
                if v70 then
                    g_game.safeLogout()
                else
                end
                local v71 = closure3(nil)
                scheduleEvent(v71, 2000)
                return Us1_None()
            else
                local v73 = forget_dead_16(v3)
                local v74 = spiral_wrap_signed((v8 + v73), 32)
                local v75 = math.random(0, 3)
                local v76 = v75 == 0
                local getv85 = function()
                    if v76 then
                        return Us2_Drink()
                    else
                        local v78 = v75 == 1
                        if v78 then
                            return Us2_Engage()
                        else
                            local v80 = v75 == 2
                            if v80 then
                                return Us2_StepSomewhere()
                            else
                                return Us2_Stand()
                            end
                        end
                    end
                end
                local v85 = getv85()
                local getv269 = function()
                    if v85 ~= nil and v85.tag == "Us2_Drink" then
                        local v86 = g_clock.millis()
                        local v87 = v1 ~= nil and v1.l0
                        local v88 = spiral_wrap_signed((v86 - v87), 32)
                        local v89 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                        if v89 then
                            local v90 = format_real_8(v24)
                            local v91 = ("heal (potion) at health " .. v90)
                            local v92 = (v91 .. " t=")
                            local v93 = format_real_8(v88)
                            local v94 = (v92 .. v93)
                            local v95 = ("[tibia-probe] " .. v94)
                            write_log_line_6(v95)
                        else
                            local v96 = format_real_8(v24)
                            local v97 = ("heal dropped by the action gate at health " .. v96)
                            local v98 = ("[tibia-probe] " .. v97)
                            write_log_line_6(v98)
                        end
                        if v89 then
                            local v99 = spiral_wrap_signed((v5 + 1), 32)
                            return { [1]=v25, [2]=v99, [3]=v6, [4]=v7, [5]=v74, [6]=v9, [7]=v10, [8]=v11, [9]=v27, [10]=v13 }
                        else
                            return { [1]=v25, [2]=v5, [3]=v6, [4]=v7, [5]=v74, [6]=v9, [7]=v10, [8]=v11, [9]=v27, [10]=v13 }
                        end
                    elseif v85 ~= nil and v85.tag == "Us2_Engage" then
                        local v110 = g_game.getLocalPlayer():getPosition()
                        local v111 = v110.x
                        local v112 = v110.y
                        local v113 = v110.z
                        local v114 = g_map.getSpectators({ x = v111, y = v112, z = v113 }, false)
                        local v115 = #(v114)
                        local v116 = 1
                        local v117 = Us3_None()
                        local v118 = scan_20(v111, v112, v113, v114, v115, v116, v117)
                        if v118 ~= nil and v118.tag == "Us3_None" then
                            return { [1]=v25, [2]=v5, [3]=v6, [4]=v7, [5]=v74, [6]=v9, [7]=v10, [8]=v11, [9]=v27, [10]=v13 }
                        elseif v118 ~= nil and v118.tag == "Us3_Some" then
                            local v119 = v118._1
                            local v120 = v118._2
                            local v121 = (v114)[v119]
                            local v122 = true
                            chasing_9(v122)
                            local v123 = g_game.getAttackingCreature()
                            local v124 = (v123) == (v121)
                            local v125 = v124 == false
                            if v125 then
                                g_game.attack(v121)
                                remember_22(v3, v121)
                                local v126 = (v121):getName()
                                local v127 = ("strike " .. v126)
                                local v128 = (v121):getPosition()
                                local v129 = v128.x
                                local v130 = v128.y
                                local v131 = v128.z
                                local v132 = format_real_8(v129)
                                local v133 = ("" .. v132)
                                local v134 = (v133 .. ",")
                                local v135 = format_real_8(v130)
                                local v136 = (v134 .. v135)
                                local v137 = (v136 .. ",")
                                local v138 = format_real_8(v131)
                                local v139 = (v137 .. v138)
                                local v140 = (" at " .. v139)
                                local v141 = (v140 .. " from ")
                                local v142 = format_real_8(v111)
                                local v143 = ("" .. v142)
                                local v144 = (v143 .. ",")
                                local v145 = format_real_8(v112)
                                local v146 = (v144 .. v145)
                                local v147 = (v146 .. ",")
                                local v148 = format_real_8(v113)
                                local v149 = (v147 .. v148)
                                local v150 = (v141 .. v149)
                                local v151 = (v127 .. v150)
                                local v152 = (v151 .. " health ")
                                local v153 = format_real_8(v24)
                                local v154 = (v152 .. v153)
                                local v155 = ("[tibia-probe] " .. v154)
                                write_log_line_6(v155)
                            else
                            end
                            local v156 = spiral_wrap_signed((v6 + 1), 32)
                            return { [1]=v25, [2]=v5, [3]=v156, [4]=v7, [5]=v74, [6]=v9, [7]=v10, [8]=v11, [9]=v27, [10]=v13 }
                        end
                    elseif v85 ~= nil and v85.tag == "Us2_Stand" then
                        local v238 = spiral_wrap_signed((v7 + 1), 32)
                        return { [1]=v25, [2]=v5, [3]=v6, [4]=v238, [5]=v74, [6]=v9, [7]=v10, [8]=v11, [9]=v27, [10]=v13 }
                    elseif v85 ~= nil and v85.tag == "Us2_StepSomewhere" then
                        local v177 = v23 >= v13
                        local getv180 = function()
                            if v177 then
                                local v178 = g_game.getLocalPlayer():isWalking()
                                local v179 = v178 == false
                                return v179
                            else
                                return false
                            end
                        end
                        local v180 = getv180()
                        if v180 then
                            local v181 = math.random(1, 8)
                            local v182 = v181 == 1
                            local getv184 = function()
                                if v182 then
                                    return true
                                else
                                    local v183 = v181 == 2
                                    return v183
                                end
                            end
                            local v184 = getv184()
                            local getv209 = function()
                                if v184 then
                                    local getv185 = function()
                                        if v182 then
                                            return { [1]=0, [2]=-1, [3]=false }
                                        else
                                            return { [1]=1, [2]=0, [3]=false }
                                        end
                                    end
                                    local v185, v186, v187 = (table.unpack or unpack)(getv185())
                                    return { [1]=v185, [2]=v186, [3]=v187 }
                                else
                                    local v188 = v181 == 3
                                    local getv190 = function()
                                        if v188 then
                                            return true
                                        else
                                            local v189 = v181 == 4
                                            return v189
                                        end
                                    end
                                    local v190 = getv190()
                                    local getv206 = function()
                                        if v190 then
                                            local getv191 = function()
                                                if v188 then
                                                    return { [1]=0, [2]=1, [3]=false }
                                                else
                                                    return { [1]=-1, [2]=0, [3]=false }
                                                end
                                            end
                                            local v191, v192, v193 = (table.unpack or unpack)(getv191())
                                            return { [1]=v191, [2]=v192, [3]=v193 }
                                        else
                                            local v194 = v181 == 5
                                            local getv203 = function()
                                                if v194 then
                                                    return { [1]=1, [2]=-1, [3]=true }
                                                else
                                                    local v195 = v181 == 6
                                                    local getv200 = function()
                                                        if v195 then
                                                            return { [1]=1, [2]=1, [3]=true }
                                                        else
                                                            local v196 = v181 == 7
                                                            local getv197 = function()
                                                                if v196 then
                                                                    return { [1]=-1, [2]=1, [3]=true }
                                                                else
                                                                    return { [1]=-1, [2]=-1, [3]=true }
                                                                end
                                                            end
                                                            local v197, v198, v199 = (table.unpack or unpack)(getv197())
                                                            return { [1]=v197, [2]=v198, [3]=v199 }
                                                        end
                                                    end
                                                    local v200, v201, v202 = (table.unpack or unpack)(getv200())
                                                    return { [1]=v200, [2]=v201, [3]=v202 }
                                                end
                                            end
                                            local v203, v204, v205 = (table.unpack or unpack)(getv203())
                                            return { [1]=v203, [2]=v204, [3]=v205 }
                                        end
                                    end
                                    local v206, v207, v208 = (table.unpack or unpack)(getv206())
                                    return { [1]=v206, [2]=v207, [3]=v208 }
                                end
                            end
                            local v209, v210, v211 = (table.unpack or unpack)(getv209())
                            local v212 = step_24(v209, v210)
                            if v212 then
                                local v213 = spiral_wrap_signed((v9 + 1), 32)
                                local getv214 = function()
                                    if v211 then
                                        return 3
                                    else
                                        return 1
                                    end
                                end
                                local v214 = getv214()
                                local v215 = spiral_wrap_signed(spiral_mul_mod32(650, v214), 32)
                                local v216 = spiral_wrap_signed((v23 + v215), 32)
                                return { [1]=v25, [2]=v5, [3]=v6, [4]=v7, [5]=v74, [6]=v213, [7]=v10, [8]=v11, [9]=v27, [10]=v216 }
                            else
                                local v217 = spiral_wrap_signed((v11 + 1), 32)
                                return { [1]=v25, [2]=v5, [3]=v6, [4]=v7, [5]=v74, [6]=v9, [7]=v10, [8]=v217, [9]=v27, [10]=v13 }
                            end
                        else
                            return { [1]=v25, [2]=v5, [3]=v6, [4]=v7, [5]=v74, [6]=v9, [7]=v10, [8]=v11, [9]=v27, [10]=v13 }
                        end
                    end
                end
                local v269, v270, v271, v272, v273, v274, v275, v276, v277, v278 = (table.unpack or unpack)(getv269())
                local v279 = math.fmod(v269, 100)
                local v280 = v279 == 0
                if v280 then
                    local v281 = g_game.getLocalPlayer():getPosition()
                    local v282 = v281.x
                    local v283 = v281.y
                    local v284 = v281.z
                    local v285 = format_real_8(v282)
                    local v286 = ("" .. v285)
                    local v287 = (v286 .. ",")
                    local v288 = format_real_8(v283)
                    local v289 = (v287 .. v288)
                    local v290 = (v289 .. ",")
                    local v291 = format_real_8(v284)
                    local v292 = (v290 .. v291)
                    local v293 = g_game.getLocalPlayer():getHealth()
                    local v294 = g_game.getLocalPlayer():getExperience()
                    local v295 = spiral_wrap_signed((v294 - v0), 32)
                    local v296 = format_real_8(v269)
                    local v297 = ("ticks " .. v296)
                    local v298 = (v297 .. " heals ")
                    local v299 = format_real_8(v270)
                    local v300 = (v298 .. v299)
                    local v301 = (v300 .. " strikes ")
                    local v302 = format_real_8(v271)
                    local v303 = (v301 .. v302)
                    local v304 = (v303 .. " holds ")
                    local v305 = format_real_8(v272)
                    local v306 = (v304 .. v305)
                    local v307 = format_real_8(v274)
                    local v308 = (" retreats " .. v307)
                    local v309 = (v308 .. " cornered ")
                    local v310 = format_real_8(v275)
                    local v311 = (v309 .. v310)
                    local v312 = (v311 .. " gated ")
                    local v313 = format_real_8(v276)
                    local v314 = (v312 .. v313)
                    local v315 = (v314 .. " kills ")
                    local v316 = format_real_8(v273)
                    local v317 = (v315 .. v316)
                    local v318 = (v306 .. v317)
                    local v319 = format_real_8(v293)
                    local v320 = (" health " .. v319)
                    local v321 = (v320 .. " lowest ")
                    local v322 = format_real_8(v277)
                    local v323 = (v321 .. v322)
                    local v324 = (v323 .. " experience +")
                    local v325 = format_real_8(v295)
                    local v326 = (v324 .. v325)
                    local v327 = (v318 .. v326)
                    local v328 = (v327 .. " player at ")
                    local v329 = (v328 .. v292)
                    local v330 = ("[tibia-probe] " .. v329)
                    write_log_line_6(v330)
                else
                end
                return Us1_Some(v269, v270, v271, v272, v273, v274, v275, v276, v277, v278)
            end
        end
    end
    local v333 = getv333()
    if v333 ~= nil and v333.tag == "Us1_None" then
        return nil
    elseif v333 ~= nil and v333.tag == "Us1_Some" then
        local v334 = v333._1
        local v335 = v333._2
        local v336 = v333._3
        local v337 = v333._4
        local v338 = v333._5
        local v339 = v333._6
        local v340 = v333._7
        local v341 = v333._8
        local v342 = v333._9
        local v343 = v333._10
        local v344 = g_clock.millis()
        local v345 = v1 ~= nil and v1.l0
        local v346 = spiral_wrap_signed((v344 - v345), 32)
        local v347 = "TIBIA_ARENA_RUN_MS"
        local v348 = 150000
        local v349 = env_i32_10(v347, v348)
        local v350 = v346 > v349
        if v350 then
            local v351 = g_game.getLocalPlayer():getHealth()
            local v352 = g_game.getLocalPlayer():getExperience()
            local v353 = spiral_wrap_signed((v352 - v0), 32)
            local v354 = format_real_8(v334)
            local v355 = ("ticks " .. v354)
            local v356 = (v355 .. " heals ")
            local v357 = format_real_8(v335)
            local v358 = (v356 .. v357)
            local v359 = (v358 .. " strikes ")
            local v360 = format_real_8(v336)
            local v361 = (v359 .. v360)
            local v362 = (v361 .. " holds ")
            local v363 = format_real_8(v337)
            local v364 = (v362 .. v363)
            local v365 = format_real_8(v339)
            local v366 = (" retreats " .. v365)
            local v367 = (v366 .. " cornered ")
            local v368 = format_real_8(v340)
            local v369 = (v367 .. v368)
            local v370 = (v369 .. " gated ")
            local v371 = format_real_8(v341)
            local v372 = (v370 .. v371)
            local v373 = (v372 .. " kills ")
            local v374 = format_real_8(v338)
            local v375 = (v373 .. v374)
            local v376 = (v364 .. v375)
            local v377 = format_real_8(v351)
            local v378 = (" health " .. v377)
            local v379 = (v378 .. " lowest ")
            local v380 = format_real_8(v342)
            local v381 = (v379 .. v380)
            local v382 = (v381 .. " experience +")
            local v383 = format_real_8(v353)
            local v384 = (v382 .. v383)
            local v385 = (v376 .. v384)
            local v386 = ("end: " .. v385)
            local v387 = ("[tibia-probe] " .. v386)
            write_log_line_6(v387)
            local v388 = parity_summary_15()
            local v389 = v388 ~= ""
            if v389 then
                local v390 = ("[tibia-probe] " .. v388)
                write_log_line_6(v390)
            else
            end
            local v391 = "[tibia-probe] finish: run complete"
            write_log_line_6(v391)
            local v392 = g_game.isOnline()
            if v392 then
                g_game.safeLogout()
            else
            end
            local v393 = closure3(nil)
            scheduleEvent(v393, 2000)
            return nil
        else
            local v394 = g_game.getLocalPlayer():getExperience()
            local v395 = spiral_wrap_signed((v394 - v0), 32)
            local v396 = v395 >= v2
            if v396 then
                local v397 = g_clock.millis()
                local v398 = v1 ~= nil and v1.l0
                local v399 = spiral_wrap_signed((v397 - v398), 32)
                local v400 = format_real_8(v399)
                local v401 = ("cleared at " .. v400)
                local v402 = (v401 .. " ms")
                local v403 = ("[tibia-probe] " .. v402)
                write_log_line_6(v403)
                local v404 = g_game.getLocalPlayer():getHealth()
                local v405 = g_game.getLocalPlayer():getExperience()
                local v406 = spiral_wrap_signed((v405 - v0), 32)
                local v407 = format_real_8(v334)
                local v408 = ("ticks " .. v407)
                local v409 = (v408 .. " heals ")
                local v410 = format_real_8(v335)
                local v411 = (v409 .. v410)
                local v412 = (v411 .. " strikes ")
                local v413 = format_real_8(v336)
                local v414 = (v412 .. v413)
                local v415 = (v414 .. " holds ")
                local v416 = format_real_8(v337)
                local v417 = (v415 .. v416)
                local v418 = format_real_8(v339)
                local v419 = (" retreats " .. v418)
                local v420 = (v419 .. " cornered ")
                local v421 = format_real_8(v340)
                local v422 = (v420 .. v421)
                local v423 = (v422 .. " gated ")
                local v424 = format_real_8(v341)
                local v425 = (v423 .. v424)
                local v426 = (v425 .. " kills ")
                local v427 = format_real_8(v338)
                local v428 = (v426 .. v427)
                local v429 = (v417 .. v428)
                local v430 = format_real_8(v404)
                local v431 = (" health " .. v430)
                local v432 = (v431 .. " lowest ")
                local v433 = format_real_8(v342)
                local v434 = (v432 .. v433)
                local v435 = (v434 .. " experience +")
                local v436 = format_real_8(v406)
                local v437 = (v435 .. v436)
                local v438 = (v429 .. v437)
                local v439 = ("cleared: " .. v438)
                local v440 = ("[tibia-probe] " .. v439)
                write_log_line_6(v440)
                local v441 = parity_summary_15()
                local v442 = v441 ~= ""
                if v442 then
                    local v443 = ("[tibia-probe] " .. v441)
                    write_log_line_6(v443)
                else
                end
                local v444 = "[tibia-probe] finish: cleared"
                write_log_line_6(v444)
                local v445 = g_game.isOnline()
                if v445 then
                    g_game.safeLogout()
                else
                end
                local v446 = closure3(nil)
                scheduleEvent(v446, 2000)
                return nil
            else
                local v447 = closure9({ v0, v1, v2, v3, v343, v334, v335, v336, v337, v338, v339, v340, v341, v342 })
                scheduleEvent(v447, 100)
                return nil
            end
        end
    end
end

function closure8(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = g_game.getLocalPlayer():getPosition()
        local v4 = v3.x
        local v5 = v3.y
        local v6 = v3.z
        local v7 = format_real_8(v4)
        local v8 = ("" .. v7)
        local v9 = (v8 .. ",")
        local v10 = format_real_8(v5)
        local v11 = (v9 .. v10)
        local v12 = (v11 .. ",")
        local v13 = format_real_8(v6)
        local v14 = (v12 .. v13)
        local v15 = ("random control starts at " .. v14)
        local v16 = (v15 .. " (drink, engage, random step or stand, equal odds every ")
        local v17 = 100
        local v18 = format_real_8(v17)
        local v19 = (v16 .. v18)
        local v20 = (v19 .. " ms)")
        local v21 = ("[tibia-probe] " .. v20)
        write_log_line_6(v21)
        local v22 = g_clock.millis()
        v0.l0 = v22
        local v23 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v24 = 90
        local v25 = env_i32_10(v23, v24)
        local v26 = 0
        local v27 = 0
        local v28 = 0
        local v29 = 0
        local v30 = 0
        local v31 = 0
        local v32 = 0
        local v33 = 0
        local v34 = 999
        local v35 = 0
        return ticked_13(v2, v0, v25, v1, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35)
    end
end

function closure7(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getExperience()
        local v3 = false
        chasing_9(v3)
        g_game.setFightMode(FightBalanced)
        local v4 = closure8({ v0, v1, v2 })
        scheduleEvent(v4, 1000)
        return nil
    end
end

function closure6(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = g_game.getLocalPlayer():getName()
        local v3 = g_game.getLocalPlayer():getHealth()
        local v4 = g_game.getLocalPlayer():getMana()
        local v5 = ("in game as " .. v2)
        local v6 = (v5 .. " health ")
        local v7 = format_real_8(v3)
        local v8 = (v6 .. v7)
        local v9 = (v8 .. " mana ")
        local v10 = format_real_8(v4)
        local v11 = (v9 .. v10)
        local v12 = ("[tibia-probe] " .. v11)
        write_log_line_6(v12)
        local v13 = closure7({ v0, v1 })
        scheduleEvent(v13, 1500)
        return nil
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_4(v0, v1, v2, v3, v4, v5)
    end
end

function poll_4(v0, v1, v2, v3, v4, v5)
    local v6 = v0 == ""
    local getv8 = function()
        if v6 then
            return true
        else
            return file_exists_5(v0)
        end
    end
    local v8 = getv8()
    if v8 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v9 = typed_c2(nil)
        local v10 = function(message) (v9)(message) end
        local v11 = typed_c4({ v2, v3 })
        local v12 = function(mode, text) (v11)(mode)(text) end
        local v13 = closure6({ v4, v5 })
        connect(g_game, { onGameStart = v13, onLoginError = v10, onTextMessage = v12 })
        local v14 = "@god"
        local v15 = "@god\ngod"
        g_game.loginWorld(v14, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v15)
        return nil
    else
        local v16 = closure10({ v0, v1, v2, v3, v4, v5 })
        scheduleEvent(v16, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        local v5 = "TIBIA_LOGIN_GATE"
        local v6 = ""
        local v7 = env_text_0(v5, v6)
        return poll_4(v7, v0, v1, v2, v3, v4)
    end
end

function closure11(capt)
    return function(dom)
        local v0 = parity_summary_15()
        local v1 = v0 ~= ""
        if v1 then
            local v2 = ("[tibia-probe] " .. v0)
            write_log_line_6(v2)
        else
        end
        local v3 = "[tibia-probe] finish: timeout"
        write_log_line_6(v3)
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

math.randomseed(os.time())
local v0 = { __tag = "Mut0", l0 = 0 }
local v1 = Uh0_Nil()
local v2 = { __tag = "Mut1", l0 = v1 }
local v3 = "TIBIA_ARENA_CHARACTER"
local v4 = "Knight Sample"
local v5 = env_text_0(v3, v4)
local v6 = (v5 .. "_1511")
disable_client_bot_2(v6)
local v7 = env_text_0(v3, v4)
local v8 = "TIBIA_PROBE_HIDDEN"
local v9 = get_environment_variable_1(v8)
local v10 = v9 == "1"
if v10 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_3()
local v11 = closure0(nil)
scheduleEvent(v11, 200)
scheduleEvent(v11, 1000)
local v12 = closure1({ v7, v0, v2, v0, v2 })
scheduleEvent(v12, 3000)
local v13 = closure11(nil)
scheduleEvent(v13, 200000)
return 0
