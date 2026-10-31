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
local Mut0, Uh0_Cons, Mut1, Mut2, Us0_Some, Us0_None, Us1_Some, Us1_None, Us2_Drink, Us2_Engage, Us2_StepSomewhere, Us2_Stand, get_environment_variable_1, env_text_0, disable_client_bot_2, mute_3, closure0, file_exists_5, log_flush_7, write_log_line_6, closure3, typed_c2, format_real_8, closure5, typed_c4, chasing_9, method11, method12, env_i32_10, player_present_14, parity_summary_15, method17, method18, method19, forget_dead_16, live_monster_21, scan_20, method23, remember_22, diagonal_south_27, diagonal_step_26, south_or_west_step_25, step_24, closure9, ticked_13, closure8, closure7, closure6, closure10, poll_4, closure1, closure11
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
    local v1 = "\n"
    local v2 = v0 .. v1 
    g_resources.writeFileContents("/tibia-probe.log", v2)
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
        local v2 = "game login error: "
        local v3 = v2 .. v1 
        local v4 = "[tibia-probe] "
        local v5 = v4 .. v3 
        write_log_line_6(v5)
        local v6 = "finish: "
        local v7 = "game login error"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        write_log_line_6(v9)
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

function format_real_8(v0)
    local v1 = ""
    local v2 = { __tag = "Mut2", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
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
        local v9 = "server text ["
        local v10 = v9 .. v4 
        local v11 = "] t="
        local v12 = v10 .. v11 
        local v13 = format_real_8(v8)
        local v14 = v12 .. v13 
        local v15 = ": "
        local v16 = v14 .. v15 
        local v17 = v16 .. v5 
        local v18 = "[tibia-probe] "
        local v19 = v18 .. v17 
        return write_log_line_6(v19)
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

function scan_20(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v5 > v4
    local getv37 = function()
        if v9 then
            return { [1]=v6, [2]=v7, [3]=v8 }
        else
            local v10 = spiral_wrap_signed((v5 + 1), 32)
            local v11 = (v3)[v5]
            local v12 = live_monster_21(v11)
            local getv31 = function()
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
                    local v27 = v26 < v8
                    local getv28 = function()
                        if v27 then
                            return { [1]=true, [2]=v5, [3]=v26 }
                        else
                            return { [1]=v6, [2]=v7, [3]=v8 }
                        end
                    end
                    local v28, v29, v30 = (table.unpack or unpack)(getv28())
                    return { [1]=v28, [2]=v29, [3]=v30 }
                else
                    return { [1]=v6, [2]=v7, [3]=v8 }
                end
            end
            local v31, v32, v33 = (table.unpack or unpack)(getv31())
            local v34, v35, v36 = (table.unpack or unpack)(scan_20(v0, v1, v2, v3, v4, v10, v31, v32, v33))
            return { [1]=v34, [2]=v35, [3]=v36 }
        end
    end
    local v37, v38, v39 = (table.unpack or unpack)(getv37())
    return { [1]=v37, [2]=v38, [3]=v39 }
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
    local getv371 = function()
        if v15 then
            local v16 = parity_summary_15()
            local v17 = v16 ~= ""
            if v17 then
                local v18 = "[tibia-probe] "
                local v19 = v18 .. v16 
                write_log_line_6(v19)
            else
            end
            local v20 = "finish: "
            local v21 = "offline"
            local v22 = v20 .. v21 
            local v23 = "[tibia-probe] "
            local v24 = v23 .. v22 
            write_log_line_6(v24)
            local v25 = g_game.isOnline()
            if v25 then
                g_game.safeLogout()
            else
            end
            local v26 = closure3(nil)
            scheduleEvent(v26, 2000)
            return Us1_None()
        else
            local v28 = g_clock.millis()
            local v29 = g_game.getLocalPlayer():getHealth()
            local v30 = spiral_wrap_signed((v4 + 1), 32)
            local v31 = v29 < v12
            local getv32 = function()
                if v31 then
                    return v29
                else
                    return v12
                end
            end
            local v32 = getv32()
            local v33 = v29 <= 0
            if v33 then
                local v34 = g_game.getLocalPlayer():getHealth()
                local v35 = g_game.getLocalPlayer():getExperience()
                local v36 = spiral_wrap_signed((v35 - v0), 32)
                local v37 = format_real_8(v30)
                local v38 = "ticks "
                local v39 = v38 .. v37 
                local v40 = " heals "
                local v41 = v39 .. v40 
                local v42 = format_real_8(v5)
                local v43 = v41 .. v42 
                local v44 = " strikes "
                local v45 = v43 .. v44 
                local v46 = format_real_8(v6)
                local v47 = v45 .. v46 
                local v48 = " holds "
                local v49 = v47 .. v48 
                local v50 = format_real_8(v7)
                local v51 = v49 .. v50 
                local v52 = format_real_8(v9)
                local v53 = " retreats "
                local v54 = v53 .. v52 
                local v55 = " cornered "
                local v56 = v54 .. v55 
                local v57 = format_real_8(v10)
                local v58 = v56 .. v57 
                local v59 = " gated "
                local v60 = v58 .. v59 
                local v61 = format_real_8(v11)
                local v62 = v60 .. v61 
                local v63 = " kills "
                local v64 = v62 .. v63 
                local v65 = format_real_8(v8)
                local v66 = v64 .. v65 
                local v67 = v51 .. v66 
                local v68 = format_real_8(v34)
                local v69 = " health "
                local v70 = v69 .. v68 
                local v71 = " lowest "
                local v72 = v70 .. v71 
                local v73 = format_real_8(v32)
                local v74 = v72 .. v73 
                local v75 = " experience +"
                local v76 = v74 .. v75 
                local v77 = format_real_8(v36)
                local v78 = v76 .. v77 
                local v79 = v67 .. v78 
                local v80 = "dead: "
                local v81 = v80 .. v79 
                local v82 = "[tibia-probe] "
                local v83 = v82 .. v81 
                write_log_line_6(v83)
                local v84 = parity_summary_15()
                local v85 = v84 ~= ""
                if v85 then
                    local v86 = v82 .. v84 
                    write_log_line_6(v86)
                else
                end
                local v87 = "finish: "
                local v88 = "death"
                local v89 = v87 .. v88 
                local v90 = v82 .. v89 
                write_log_line_6(v90)
                local v91 = g_game.isOnline()
                if v91 then
                    g_game.safeLogout()
                else
                end
                local v92 = closure3(nil)
                scheduleEvent(v92, 2000)
                return Us1_None()
            else
                local v94 = forget_dead_16(v3)
                local v95 = spiral_wrap_signed((v8 + v94), 32)
                local v96 = math.random(0, 3)
                local v97 = v96 == 0
                local getv106 = function()
                    if v97 then
                        return Us2_Drink()
                    else
                        local v99 = v96 == 1
                        if v99 then
                            return Us2_Engage()
                        else
                            local v101 = v96 == 2
                            if v101 then
                                return Us2_StepSomewhere()
                            else
                                return Us2_Stand()
                            end
                        end
                    end
                end
                local v106 = getv106()
                local getv292 = function()
                    if v106 ~= nil and v106.tag == "Us2_Drink" then
                        local v107 = g_clock.millis()
                        local v108 = v1 ~= nil and v1.l0
                        local v109 = spiral_wrap_signed((v107 - v108), 32)
                        local v110 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                        if v110 then
                            local v111 = format_real_8(v29)
                            local v112 = "heal (potion) at health "
                            local v113 = v112 .. v111 
                            local v114 = " t="
                            local v115 = v113 .. v114 
                            local v116 = format_real_8(v109)
                            local v117 = v115 .. v116 
                            local v118 = "[tibia-probe] "
                            local v119 = v118 .. v117 
                            write_log_line_6(v119)
                        else
                            local v120 = format_real_8(v29)
                            local v121 = "heal dropped by the action gate at health "
                            local v122 = v121 .. v120 
                            local v123 = "[tibia-probe] "
                            local v124 = v123 .. v122 
                            write_log_line_6(v124)
                        end
                        if v110 then
                            local v125 = spiral_wrap_signed((v5 + 1), 32)
                            return { [1]=v30, [2]=v125, [3]=v6, [4]=v7, [5]=v95, [6]=v9, [7]=v10, [8]=v11, [9]=v32, [10]=v13 }
                        else
                            return { [1]=v30, [2]=v5, [3]=v6, [4]=v7, [5]=v95, [6]=v9, [7]=v10, [8]=v11, [9]=v32, [10]=v13 }
                        end
                    elseif v106 ~= nil and v106.tag == "Us2_Engage" then
                        local v136 = g_game.getLocalPlayer():getPosition()
                        local v137 = v136.x
                        local v138 = v136.y
                        local v139 = v136.z
                        local v140 = g_map.getSpectators({ x = v137, y = v138, z = v139 }, false)
                        local v141 = #(v140)
                        local v142 = 1
                        local v143 = false
                        local v144 = 0
                        local v145 = 999
                        local v146, v147, v148 = (table.unpack or unpack)(scan_20(v137, v138, v139, v140, v141, v142, v143, v144, v145))
                        if v146 then
                            local v149 = (v140)[v147]
                            local v150 = true
                            chasing_9(v150)
                            local v151 = g_game.getAttackingCreature()
                            local v152 = (v151) == (v149)
                            local v153 = v152 == false
                            if v153 then
                                g_game.attack(v149)
                                remember_22(v3, v149)
                                local v154 = (v149):getName()
                                local v155 = "strike "
                                local v156 = v155 .. v154 
                                local v157 = (v149):getPosition()
                                local v158 = v157.x
                                local v159 = v157.y
                                local v160 = v157.z
                                local v161 = format_real_8(v158)
                                local v162 = ""
                                local v163 = v162 .. v161 
                                local v164 = ","
                                local v165 = v163 .. v164 
                                local v166 = format_real_8(v159)
                                local v167 = v165 .. v166 
                                local v168 = v167 .. v164 
                                local v169 = format_real_8(v160)
                                local v170 = v168 .. v169 
                                local v171 = " at "
                                local v172 = v171 .. v170 
                                local v173 = " from "
                                local v174 = v172 .. v173 
                                local v175 = format_real_8(v137)
                                local v176 = v162 .. v175 
                                local v177 = v176 .. v164 
                                local v178 = format_real_8(v138)
                                local v179 = v177 .. v178 
                                local v180 = v179 .. v164 
                                local v181 = format_real_8(v139)
                                local v182 = v180 .. v181 
                                local v183 = v174 .. v182 
                                local v184 = v156 .. v183 
                                local v185 = " health "
                                local v186 = v184 .. v185 
                                local v187 = format_real_8(v29)
                                local v188 = v186 .. v187 
                                local v189 = "[tibia-probe] "
                                local v190 = v189 .. v188 
                                write_log_line_6(v190)
                            else
                            end
                            local v191 = spiral_wrap_signed((v6 + 1), 32)
                            return { [1]=v30, [2]=v5, [3]=v191, [4]=v7, [5]=v95, [6]=v9, [7]=v10, [8]=v11, [9]=v32, [10]=v13 }
                        else
                            return { [1]=v30, [2]=v5, [3]=v6, [4]=v7, [5]=v95, [6]=v9, [7]=v10, [8]=v11, [9]=v32, [10]=v13 }
                        end
                    elseif v106 ~= nil and v106.tag == "Us2_Stand" then
                        local v261 = spiral_wrap_signed((v7 + 1), 32)
                        return { [1]=v30, [2]=v5, [3]=v6, [4]=v261, [5]=v95, [6]=v9, [7]=v10, [8]=v11, [9]=v32, [10]=v13 }
                    elseif v106 ~= nil and v106.tag == "Us2_StepSomewhere" then
                        local v202 = v28 >= v13
                        local getv205 = function()
                            if v202 then
                                local v203 = g_game.getLocalPlayer():isWalking()
                                local v204 = v203 == false
                                return v204
                            else
                                return false
                            end
                        end
                        local v205 = getv205()
                        if v205 then
                            local v206 = math.random(1, 8)
                            local v207 = v206 == 1
                            local getv232 = function()
                                if v207 then
                                    return { [1]=0, [2]=-1, [3]=false }
                                else
                                    local v208 = v206 == 2
                                    local getv229 = function()
                                        if v208 then
                                            return { [1]=1, [2]=0, [3]=false }
                                        else
                                            local v209 = v206 == 3
                                            local getv226 = function()
                                                if v209 then
                                                    return { [1]=0, [2]=1, [3]=false }
                                                else
                                                    local v210 = v206 == 4
                                                    local getv223 = function()
                                                        if v210 then
                                                            return { [1]=-1, [2]=0, [3]=false }
                                                        else
                                                            local v211 = v206 == 5
                                                            local getv220 = function()
                                                                if v211 then
                                                                    return { [1]=1, [2]=-1, [3]=true }
                                                                else
                                                                    local v212 = v206 == 6
                                                                    local getv217 = function()
                                                                        if v212 then
                                                                            return { [1]=1, [2]=1, [3]=true }
                                                                        else
                                                                            local v213 = v206 == 7
                                                                            local getv214 = function()
                                                                                if v213 then
                                                                                    return { [1]=-1, [2]=1, [3]=true }
                                                                                else
                                                                                    return { [1]=-1, [2]=-1, [3]=true }
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
                                    return { [1]=v229, [2]=v230, [3]=v231 }
                                end
                            end
                            local v232, v233, v234 = (table.unpack or unpack)(getv232())
                            local v235 = step_24(v232, v233)
                            if v235 then
                                local v236 = spiral_wrap_signed((v9 + 1), 32)
                                local getv237 = function()
                                    if v234 then
                                        return 3
                                    else
                                        return 1
                                    end
                                end
                                local v237 = getv237()
                                local v238 = spiral_wrap_signed(spiral_mul_mod32(650, v237), 32)
                                local v239 = spiral_wrap_signed((v28 + v238), 32)
                                return { [1]=v30, [2]=v5, [3]=v6, [4]=v7, [5]=v95, [6]=v236, [7]=v10, [8]=v11, [9]=v32, [10]=v239 }
                            else
                                local v240 = spiral_wrap_signed((v11 + 1), 32)
                                return { [1]=v30, [2]=v5, [3]=v6, [4]=v7, [5]=v95, [6]=v9, [7]=v10, [8]=v240, [9]=v32, [10]=v13 }
                            end
                        else
                            return { [1]=v30, [2]=v5, [3]=v6, [4]=v7, [5]=v95, [6]=v9, [7]=v10, [8]=v11, [9]=v32, [10]=v13 }
                        end
                    end
                end
                local v292, v293, v294, v295, v296, v297, v298, v299, v300, v301 = (table.unpack or unpack)(getv292())
                local v302 = math.fmod(v292, 100)
                local v303 = v302 == 0
                if v303 then
                    local v304 = g_game.getLocalPlayer():getPosition()
                    local v305 = v304.x
                    local v306 = v304.y
                    local v307 = v304.z
                    local v308 = format_real_8(v305)
                    local v309 = ""
                    local v310 = v309 .. v308 
                    local v311 = ","
                    local v312 = v310 .. v311 
                    local v313 = format_real_8(v306)
                    local v314 = v312 .. v313 
                    local v315 = v314 .. v311 
                    local v316 = format_real_8(v307)
                    local v317 = v315 .. v316 
                    local v318 = g_game.getLocalPlayer():getHealth()
                    local v319 = g_game.getLocalPlayer():getExperience()
                    local v320 = spiral_wrap_signed((v319 - v0), 32)
                    local v321 = format_real_8(v292)
                    local v322 = "ticks "
                    local v323 = v322 .. v321 
                    local v324 = " heals "
                    local v325 = v323 .. v324 
                    local v326 = format_real_8(v293)
                    local v327 = v325 .. v326 
                    local v328 = " strikes "
                    local v329 = v327 .. v328 
                    local v330 = format_real_8(v294)
                    local v331 = v329 .. v330 
                    local v332 = " holds "
                    local v333 = v331 .. v332 
                    local v334 = format_real_8(v295)
                    local v335 = v333 .. v334 
                    local v336 = format_real_8(v297)
                    local v337 = " retreats "
                    local v338 = v337 .. v336 
                    local v339 = " cornered "
                    local v340 = v338 .. v339 
                    local v341 = format_real_8(v298)
                    local v342 = v340 .. v341 
                    local v343 = " gated "
                    local v344 = v342 .. v343 
                    local v345 = format_real_8(v299)
                    local v346 = v344 .. v345 
                    local v347 = " kills "
                    local v348 = v346 .. v347 
                    local v349 = format_real_8(v296)
                    local v350 = v348 .. v349 
                    local v351 = v335 .. v350 
                    local v352 = format_real_8(v318)
                    local v353 = " health "
                    local v354 = v353 .. v352 
                    local v355 = " lowest "
                    local v356 = v354 .. v355 
                    local v357 = format_real_8(v300)
                    local v358 = v356 .. v357 
                    local v359 = " experience +"
                    local v360 = v358 .. v359 
                    local v361 = format_real_8(v320)
                    local v362 = v360 .. v361 
                    local v363 = v351 .. v362 
                    local v364 = " player at "
                    local v365 = v363 .. v364 
                    local v366 = v365 .. v317 
                    local v367 = "[tibia-probe] "
                    local v368 = v367 .. v366 
                    write_log_line_6(v368)
                else
                end
                return Us1_Some(v292, v293, v294, v295, v296, v297, v298, v299, v300, v301)
            end
        end
    end
    local v371 = getv371()
    if v371 ~= nil and v371.tag == "Us1_None" then
        return nil
    elseif v371 ~= nil and v371.tag == "Us1_Some" then
        local v372 = v371._1
        local v373 = v371._2
        local v374 = v371._3
        local v375 = v371._4
        local v376 = v371._5
        local v377 = v371._6
        local v378 = v371._7
        local v379 = v371._8
        local v380 = v371._9
        local v381 = v371._10
        local v382 = g_clock.millis()
        local v383 = v1 ~= nil and v1.l0
        local v384 = spiral_wrap_signed((v382 - v383), 32)
        local v385 = "TIBIA_ARENA_RUN_MS"
        local v386 = 150000
        local v387 = env_i32_10(v385, v386)
        local v388 = v384 > v387
        if v388 then
            local v389 = g_game.getLocalPlayer():getHealth()
            local v390 = g_game.getLocalPlayer():getExperience()
            local v391 = spiral_wrap_signed((v390 - v0), 32)
            local v392 = format_real_8(v372)
            local v393 = "ticks "
            local v394 = v393 .. v392 
            local v395 = " heals "
            local v396 = v394 .. v395 
            local v397 = format_real_8(v373)
            local v398 = v396 .. v397 
            local v399 = " strikes "
            local v400 = v398 .. v399 
            local v401 = format_real_8(v374)
            local v402 = v400 .. v401 
            local v403 = " holds "
            local v404 = v402 .. v403 
            local v405 = format_real_8(v375)
            local v406 = v404 .. v405 
            local v407 = format_real_8(v377)
            local v408 = " retreats "
            local v409 = v408 .. v407 
            local v410 = " cornered "
            local v411 = v409 .. v410 
            local v412 = format_real_8(v378)
            local v413 = v411 .. v412 
            local v414 = " gated "
            local v415 = v413 .. v414 
            local v416 = format_real_8(v379)
            local v417 = v415 .. v416 
            local v418 = " kills "
            local v419 = v417 .. v418 
            local v420 = format_real_8(v376)
            local v421 = v419 .. v420 
            local v422 = v406 .. v421 
            local v423 = format_real_8(v389)
            local v424 = " health "
            local v425 = v424 .. v423 
            local v426 = " lowest "
            local v427 = v425 .. v426 
            local v428 = format_real_8(v380)
            local v429 = v427 .. v428 
            local v430 = " experience +"
            local v431 = v429 .. v430 
            local v432 = format_real_8(v391)
            local v433 = v431 .. v432 
            local v434 = v422 .. v433 
            local v435 = "end: "
            local v436 = v435 .. v434 
            local v437 = "[tibia-probe] "
            local v438 = v437 .. v436 
            write_log_line_6(v438)
            local v439 = parity_summary_15()
            local v440 = v439 ~= ""
            if v440 then
                local v441 = v437 .. v439 
                write_log_line_6(v441)
            else
            end
            local v442 = "finish: "
            local v443 = "run complete"
            local v444 = v442 .. v443 
            local v445 = v437 .. v444 
            write_log_line_6(v445)
            local v446 = g_game.isOnline()
            if v446 then
                g_game.safeLogout()
            else
            end
            local v447 = closure3(nil)
            scheduleEvent(v447, 2000)
            return nil
        else
            local v448 = g_game.getLocalPlayer():getExperience()
            local v449 = spiral_wrap_signed((v448 - v0), 32)
            local v450 = v449 >= v2
            if v450 then
                local v451 = g_clock.millis()
                local v452 = v1 ~= nil and v1.l0
                local v453 = spiral_wrap_signed((v451 - v452), 32)
                local v454 = format_real_8(v453)
                local v455 = "cleared at "
                local v456 = v455 .. v454 
                local v457 = " ms"
                local v458 = v456 .. v457 
                local v459 = "[tibia-probe] "
                local v460 = v459 .. v458 
                write_log_line_6(v460)
                local v461 = g_game.getLocalPlayer():getHealth()
                local v462 = g_game.getLocalPlayer():getExperience()
                local v463 = spiral_wrap_signed((v462 - v0), 32)
                local v464 = format_real_8(v372)
                local v465 = "ticks "
                local v466 = v465 .. v464 
                local v467 = " heals "
                local v468 = v466 .. v467 
                local v469 = format_real_8(v373)
                local v470 = v468 .. v469 
                local v471 = " strikes "
                local v472 = v470 .. v471 
                local v473 = format_real_8(v374)
                local v474 = v472 .. v473 
                local v475 = " holds "
                local v476 = v474 .. v475 
                local v477 = format_real_8(v375)
                local v478 = v476 .. v477 
                local v479 = format_real_8(v377)
                local v480 = " retreats "
                local v481 = v480 .. v479 
                local v482 = " cornered "
                local v483 = v481 .. v482 
                local v484 = format_real_8(v378)
                local v485 = v483 .. v484 
                local v486 = " gated "
                local v487 = v485 .. v486 
                local v488 = format_real_8(v379)
                local v489 = v487 .. v488 
                local v490 = " kills "
                local v491 = v489 .. v490 
                local v492 = format_real_8(v376)
                local v493 = v491 .. v492 
                local v494 = v478 .. v493 
                local v495 = format_real_8(v461)
                local v496 = " health "
                local v497 = v496 .. v495 
                local v498 = " lowest "
                local v499 = v497 .. v498 
                local v500 = format_real_8(v380)
                local v501 = v499 .. v500 
                local v502 = " experience +"
                local v503 = v501 .. v502 
                local v504 = format_real_8(v463)
                local v505 = v503 .. v504 
                local v506 = v494 .. v505 
                local v507 = "cleared: "
                local v508 = v507 .. v506 
                local v509 = v459 .. v508 
                write_log_line_6(v509)
                local v510 = parity_summary_15()
                local v511 = v510 ~= ""
                if v511 then
                    local v512 = v459 .. v510 
                    write_log_line_6(v512)
                else
                end
                local v513 = "finish: "
                local v514 = "cleared"
                local v515 = v513 .. v514 
                local v516 = v459 .. v515 
                write_log_line_6(v516)
                local v517 = g_game.isOnline()
                if v517 then
                    g_game.safeLogout()
                else
                end
                local v518 = closure3(nil)
                scheduleEvent(v518, 2000)
                return nil
            else
                local v519 = closure9({ v0, v1, v2, v3, v381, v372, v373, v374, v375, v376, v377, v378, v379, v380 })
                scheduleEvent(v519, 100)
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
        local v8 = ""
        local v9 = v8 .. v7 
        local v10 = ","
        local v11 = v9 .. v10 
        local v12 = format_real_8(v5)
        local v13 = v11 .. v12 
        local v14 = v13 .. v10 
        local v15 = format_real_8(v6)
        local v16 = v14 .. v15 
        local v17 = "random control starts at "
        local v18 = v17 .. v16 
        local v19 = " (drink, engage, random step or stand, equal odds every "
        local v20 = v18 .. v19 
        local v21 = 100
        local v22 = format_real_8(v21)
        local v23 = v20 .. v22 
        local v24 = " ms)"
        local v25 = v23 .. v24 
        local v26 = "[tibia-probe] "
        local v27 = v26 .. v25 
        write_log_line_6(v27)
        local v28 = g_clock.millis()
        v0.l0 = v28
        local v29 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v30 = 90
        local v31 = env_i32_10(v29, v30)
        local v32 = 0
        local v33 = 0
        local v34 = 0
        local v35 = 0
        local v36 = 0
        local v37 = 0
        local v38 = 0
        local v39 = 0
        local v40 = 999
        local v41 = 0
        return ticked_13(v2, v0, v31, v1, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41)
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
        local v5 = "in game as "
        local v6 = v5 .. v2 
        local v7 = " health "
        local v8 = v6 .. v7 
        local v9 = format_real_8(v3)
        local v10 = v8 .. v9 
        local v11 = " mana "
        local v12 = v10 .. v11 
        local v13 = format_real_8(v4)
        local v14 = v12 .. v13 
        local v15 = "[tibia-probe] "
        local v16 = v15 .. v14 
        write_log_line_6(v16)
        local v17 = closure7({ v0, v1 })
        scheduleEvent(v17, 1500)
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
            local v2 = "[tibia-probe] "
            local v3 = v2 .. v0 
            write_log_line_6(v3)
        else
        end
        local v4 = "finish: "
        local v5 = "timeout"
        local v6 = v4 .. v5 
        local v7 = "[tibia-probe] "
        local v8 = v7 .. v6 
        write_log_line_6(v8)
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

math.randomseed(os.time())
local v0 = { __tag = "Mut0", l0 = 0 }
local v1 = Uh0_Nil()
local v2 = { __tag = "Mut1", l0 = v1 }
local v3 = "TIBIA_ARENA_CHARACTER"
local v4 = "Knight Sample"
local v5 = env_text_0(v3, v4)
local v6 = "_1511"
local v7 = v5 .. v6 
disable_client_bot_2(v7)
local v8 = env_text_0(v3, v4)
local v9 = "TIBIA_PROBE_HIDDEN"
local v10 = get_environment_variable_1(v9)
local v11 = v10 == "1"
if v11 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_3()
local v12 = closure0(nil)
scheduleEvent(v12, 200)
scheduleEvent(v12, 1000)
local v13 = closure1({ v8, v0, v2, v0, v2 })
scheduleEvent(v13, 3000)
local v14 = closure11(nil)
scheduleEvent(v14, 200000)
return 0
