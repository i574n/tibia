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
local Us0_Some, Us0_None, Uh0_Cons, Mut0, Mut1, Us1_Some, Us1_None, Mut2, Uh1_Cons, Mut3, Us2_Some, Us2_None, get_environment_variable_1, method2, method3, env_i32_0, env_text_4, mute_5, closure0, file_exists_7, log_flush_9, write_log_line_8, closure3, typed_c2, digits_from_11, method12, number_between_10, player_present_13, format_real_14, method15, method16, insert_sorted_18, method17, nth_19, method20, method21, method22, method23, closure6, closure5, typed_c4, chasing_24, live_monster_27, scan_26, closure9, ticked_25, closure8, closure7, closure10, poll_6, closure1, on_timeout_c11
function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1 } end

Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

function Us1_Some(v0) return { tag = "Us1_Some",  _1 = v0 } end
function Us1_None() return { tag = "Us1_None" } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

Uh1_Nil = (function() local shared = { tag = "Uh1_Nil" } return function() return shared end end)()
function Uh1_Cons(v0, v1) return { tag = "Uh1_Cons",  _1 = v0,  _2 = v1 } end

Mut3 = function(l0) return { __tag = "Mut3", l0 = l0 } end

function Us2_Some(v0, v1) return { tag = "Us2_Some",  _1 = v0,  _2 = v1 } end
function Us2_None() return { tag = "Us2_None" } end

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

function mute_5()
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
        return mute_5()
    end
end

function file_exists_7(v0)
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

function log_flush_9()
    local v0 = table.concat(TibiaProbeLog, string.char(10))
    local v1 = "\n"
    local v2 = v0 .. v1 
    g_resources.writeFileContents("/tibia-probe.log", v2)
    return nil
end

function write_log_line_8(v0)
    local v1 = TibiaProbeLog == nil
    if v1 then
        TibiaProbeLog = {}
    else
    end
    table.insert(TibiaProbeLog, v0)
    g_logger.info(v0)
    return log_flush_9()
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
        write_log_line_8(v5)
        local v6 = "finish: "
        local v7 = "game login error"
        local v8 = v6 .. v7 
        local v9 = v4 .. v8 
        write_log_line_8(v9)
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

function digits_from_11(v0, v1, v2)
    local v3 = string.len(v0)
    local v4 = v1 >= v3
    local getv18 = function()
        if v4 then
            return Us0_None()
        else
            local v6 = spiral_wrap_signed((v1 + 1), 32)
            local v7 = string.sub(v0, v6, v6)
            local v8 = (string.match(v7, "^%s*[+-]?%d+%s*$") ~= nil)
            local v9 = (tonumber(v7) or 0)
            local v10 = (math.modf(v9))
            local getv12 = function()
                if v8 then
                    local v11 = v9 >= -2147483648.0
                    return v11
                else
                    return false
                end
            end
            local v12 = getv12()
            local getv14 = function()
                if v12 then
                    local v13 = v9 <= 2147483647.0
                    return v13
                else
                    return false
                end
            end
            local v14 = getv14()
            if v14 then
                return Us0_Some(v10)
            else
                return Us0_None()
            end
        end
    end
    local v18 = getv18()
    if v18 ~= nil and v18.tag == "Us0_None" then
        return { [1]=v2, [2]=v1 }
    elseif v18 ~= nil and v18.tag == "Us0_Some" then
        local v19 = v18._1
        local v20 = spiral_wrap_signed((v1 + 1), 32)
        local v21 = spiral_wrap_signed(spiral_mul_mod32(v2, 10), 32)
        local v22 = spiral_wrap_signed((v21 + v19), 32)
        return digits_from_11(v0, v20, v22)
    end
end

function method12(v0, v1, v2)
    if v1 ~= nil and v1.tag == "Uh1_Cons" then
        local v3 = v1._1
        local v4 = v1._2
        local getv6 = function()
            if v2 then
                return true
            else
                local v5 = v3 == "" or v0:sub(1, #v3) == v3 
                return v5
            end
        end
        local v6 = getv6()
        return method12(v0, v4, v6)
    elseif v1 ~= nil and v1.tag == "Uh1_Nil" then
        return v2
    end
end

function number_between_10(v0, v1, v2)
    local v3 = string.find(v2, v0, 1, true)
    local v4 = v3 == nil
    local getv6 = function()
        if v4 then
            return 0
        else
            local v5 = v3
            return v5
        end
    end
    local v6 = getv6()
    local v7 = spiral_wrap_signed((v6 - 1), 32)
    local v8 = v7 < 0
    if v8 then
        return -1
    else
        local v9 = string.len(v0)
        local v10 = spiral_wrap_signed((v7 + v9), 32)
        local v11 = 0
        local v12, v13 = (table.unpack or unpack)(digits_from_11(v2, v10, v11))
        local v14 = v13 > v10
        local getv22 = function()
            if v14 then
                local v15 = string.len(v2)
                local v16 = spiral_wrap_signed((v15 - v13), 32)
                local v17 = spiral_wrap_signed((v13 + 1), 32)
                local v18 = spiral_wrap_signed((v13 + v16), 32)
                local v19 = string.sub(v2, v17, v18)
                local v20 = false
                return method12(v19, v1, v20)
            else
                return false
            end
        end
        local v22 = getv22()
        local getv23 = function()
            if v22 then
                return v12
            else
                return -1
            end
        end
        local v23 = getv23()
        local v24 = v23 >= 0
        if v24 then
            return v23
        else
            local v25 = spiral_wrap_signed((v7 + 1), 32)
            local v26 = string.len(v2)
            local v27 = spiral_wrap_signed((v26 - v25), 32)
            local v28 = spiral_wrap_signed((v25 + 1), 32)
            local v29 = spiral_wrap_signed((v25 + v27), 32)
            local v30 = string.sub(v2, v28, v29)
            return number_between_10(v0, v1, v30)
        end
    end
end

function player_present_13()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function format_real_14(v0)
    local v1 = ""
    local v2 = { __tag = "Mut3", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function method15(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = spiral_wrap_signed((v1 + 1), 32)
        return method15(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method16(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = spiral_wrap_signed((v1 + v2), 32)
        return method16(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function insert_sorted_18(v0, v1)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v4 = v1._1
        local v5 = v1._2
        local v6 = v0 <= v4
        if v6 then
            return Uh0_Cons(v0, v1)
        else
            local v8 = insert_sorted_18(v0, v5)
            return Uh0_Cons(v4, v8)
        end
    elseif v1 ~= nil and v1.tag == "Uh0_Nil" then
        local v2 = Uh0_Nil()
        return Uh0_Cons(v0, v2)
    end
end

function method17(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = insert_sorted_18(v2, v1)
        return method17(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function nth_19(v0, v1)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v2 = v1._1
        local v3 = v1._2
        local v4 = v0 == 0
        if v4 then
            return v2
        else
            local v5 = spiral_wrap_signed((v0 - 1), 32)
            return nth_19(v5, v3)
        end
    elseif v1 ~= nil and v1.tag == "Uh0_Nil" then
        return 0
    end
end

function method20(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = Uh0_Cons(v2, v1)
        return method20(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method21(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = method21(v3, v1)
        local v5 = format_real_14(v2)
        local v6 = ""
        local v7 = v6 .. v5 
        return Uh1_Cons(v7, v4)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method22(v0, v1, v2)
    local getv12 = function()
        if v0 ~= nil and v0.tag == "Uh1_Cons" then
            local v3 = v0._1
            local v4 = v0._2
            local v5, v6 = (table.unpack or unpack)(method22(v4, v1, v2))
            local v7 = v3 .. v6 
            local v8 = v7 .. v5 
            local v9 = ","
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

function method23(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v2 > v1
        local getv5 = function()
            if v4 then
                return v2
            else
                return v1
            end
        end
        local v5 = getv5()
        return method23(v3, v5)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function closure6(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        local v11 = v9 ~= nil and v9.l0
        local v12 = v11 == 0
        if v12 then
            v9.l0 = 1
            local v13 = "finish: "
            local v14 = "death"
            local v15 = v13 .. v14 
            local v16 = "[tibia-probe] "
            local v17 = v16 .. v15 
            write_log_line_8(v17)
            local v18 = g_game.isOnline()
            if v18 then
                g_game.safeLogout()
            else
            end
            local v19 = closure3(nil)
            scheduleEvent(v19, 2000)
            return nil
        else
        end
    end
end

function closure5(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 = (table.unpack or unpack)(capt)
    return function(v12)
        local v13 = tostring(v11)
        local v14 = tostring(v12)
        local v15 = "loses "
        local v16 = " hitpoints due to your"
        local v17 = " hitpoint due to your"
        local v18 = Uh1_Nil()
        local v19 = Uh1_Cons(v17, v18)
        local v20 = Uh1_Cons(v16, v19)
        local v21 = number_between_10(v15, v20, v14)
        local v22 = "You lose "
        local v23 = " hitpoints due to an attack"
        local v24 = " hitpoint due to an attack"
        local v25 = Uh1_Nil()
        local v26 = Uh1_Cons(v24, v25)
        local v27 = Uh1_Cons(v23, v26)
        local v28 = number_between_10(v22, v27, v14)
        local v29 = v28 >= 0
        if v29 then
            local v30 = v1 ~= nil and v1.l0
            local v31 = Uh0_Cons(v28, v30)
            v1.l0 = v31
            return nil
        else
            local v32 = v21 >= 0
            if v32 then
                local v33 = v0 ~= nil and v0.l0
                local v34 = Uh0_Cons(v21, v33)
                v0.l0 = v34
                v5.l0 = 1
                local v35 = "critical"
                local v36 = string.find(v14, v35, 1, true) ~= nil 
                if v36 then
                    local v37 = "critical: "
                    local v38 = v37 .. v14 
                    local v39 = "[tibia-probe] "
                    local v40 = v39 .. v38 
                    return write_log_line_8(v40)
                else
                end
            else
                local v41 = "You died"
                local v42 = string.find(v14, v41, 1, true) ~= nil 
                if v42 then
                    local v43 = player_present_13()
                    if v43 then
                        local v44 = v4 ~= nil and v4.l0
                        local v45 = format_real_14(v44)
                        local v46 = "potions "
                        local v47 = v46 .. v45 
                        local v48 = "[tibia-probe] "
                        local v49 = v48 .. v47 
                        write_log_line_8(v49)
                        local v50 = v0 ~= nil and v0.l0
                        local v51 = 0
                        local v52 = method15(v50, v51)
                        local v53 = v0 ~= nil and v0.l0
                        local v54 = 0
                        local v55 = method16(v53, v54)
                        local v56 = v0 ~= nil and v0.l0
                        local v57 = 0
                        local v58 = method15(v56, v57)
                        local v59 = v58 == 0
                        local getv67 = function()
                            if v59 then
                                return 0
                            else
                                local v60 = v0 ~= nil and v0.l0
                                local v61 = Uh0_Nil()
                                local v62 = method17(v60, v61)
                                local v63 = spiral_wrap_signed((v58 + 1), 32)
                                local v64 = (math.modf(v63 / 2))
                                local v65 = spiral_wrap_signed((v64 - 1), 32)
                                return nth_19(v65, v62)
                            end
                        end
                        local v67 = getv67()
                        local v68 = v2 ~= nil and v2.l0
                        local v69 = v3 ~= nil and v3.l0
                        local v70 = g_game.getLocalPlayer():getExperience()
                        local v71 = v7 ~= nil and v7.l0
                        local v72 = spiral_wrap_signed((v70 - v71), 32)
                        local v73 = g_game.getLocalPlayer():getHealth()
                        local v74 = spiral_wrap_signed((v52 + v68), 32)
                        local v75 = "death"
                        local v76 = ": swings "
                        local v77 = v75 .. v76 
                        local v78 = format_real_14(v74)
                        local v79 = v77 .. v78 
                        local v80 = " landed "
                        local v81 = v79 .. v80 
                        local v82 = format_real_14(v52)
                        local v83 = v81 .. v82 
                        local v84 = " ("
                        local v85 = v83 .. v84 
                        local v86 = v74 > 0
                        local getv91 = function()
                            if v86 then
                                local v87 = v52
                                local v88 = (v87 * 100.0)
                                local v89 = v74
                                local v90 = v88 / v89
                                return v90
                            else
                                return 0.0
                            end
                        end
                        local v91 = getv91()
                        local v92 = string.format("%." .. 1 .. "f", v91)
                        local v93 = v85 .. v92 
                        local v94 = "%)"
                        local v95 = v93 .. v94 
                        local v96 = v52 > 0
                        local getv100 = function()
                            if v96 then
                                local v97 = v55
                                local v98 = v52
                                local v99 = v97 / v98
                                return v99
                            else
                                return 0.0
                            end
                        end
                        local v100 = getv100()
                        local v101 = string.format("%." .. 2 .. "f", v100)
                        local v102 = " mean landed "
                        local v103 = v102 .. v101 
                        local v104 = " median "
                        local v105 = v103 .. v104 
                        local v106 = format_real_14(v67)
                        local v107 = v105 .. v106 
                        local v108 = " total "
                        local v109 = v107 .. v108 
                        local v110 = format_real_14(v55)
                        local v111 = v109 .. v110 
                        local v112 = v95 .. v111 
                        local v113 = format_real_14(v69)
                        local v114 = " kills "
                        local v115 = v114 .. v113 
                        local v116 = " experience +"
                        local v117 = v115 .. v116 
                        local v118 = format_real_14(v72)
                        local v119 = v117 .. v118 
                        local v120 = " health "
                        local v121 = v119 .. v120 
                        local v122 = format_real_14(v73)
                        local v123 = v121 .. v122 
                        local v124 = v112 .. v123 
                        local v125 = v48 .. v124 
                        write_log_line_8(v125)
                        local v126 = v0 ~= nil and v0.l0
                        local v127 = Uh0_Nil()
                        local v128 = method20(v126, v127)
                        local v129 = Uh1_Nil()
                        local v130 = method21(v128, v129)
                        local v131 = ""
                        local v132, v133 = (table.unpack or unpack)(method22(v130, v131, v131))
                        local v134 = "hits "
                        local v135 = v134 .. v132 
                        local v136 = v48 .. v135 
                        write_log_line_8(v136)
                        local v137 = v1 ~= nil and v1.l0
                        local v138 = 0
                        local v139 = method15(v137, v138)
                        local v140 = v1 ~= nil and v1.l0
                        local v141 = 0
                        local v142 = method16(v140, v141)
                        local v143 = v1 ~= nil and v1.l0
                        local v144 = 0
                        local v145 = method15(v143, v144)
                        local v146 = v145 == 0
                        local getv154 = function()
                            if v146 then
                                return 0
                            else
                                local v147 = v1 ~= nil and v1.l0
                                local v148 = Uh0_Nil()
                                local v149 = method17(v147, v148)
                                local v150 = spiral_wrap_signed((v145 + 1), 32)
                                local v151 = (math.modf(v150 / 2))
                                local v152 = spiral_wrap_signed((v151 - 1), 32)
                                return nth_19(v152, v149)
                            end
                        end
                        local v154 = getv154()
                        local v155 = v1 ~= nil and v1.l0
                        local v156 = 0
                        local v157 = method23(v155, v156)
                        local v158 = format_real_14(v139)
                        local v159 = "taken: count "
                        local v160 = v159 .. v158 
                        local v161 = " mean "
                        local v162 = v160 .. v161 
                        local v163 = v139 > 0
                        local getv167 = function()
                            if v163 then
                                local v164 = v142
                                local v165 = v139
                                local v166 = v164 / v165
                                return v166
                            else
                                return 0.0
                            end
                        end
                        local v167 = getv167()
                        local v168 = string.format("%." .. 2 .. "f", v167)
                        local v169 = v162 .. v168 
                        local v170 = v169 .. v104 
                        local v171 = format_real_14(v154)
                        local v172 = v170 .. v171 
                        local v173 = " max "
                        local v174 = v172 .. v173 
                        local v175 = format_real_14(v157)
                        local v176 = v174 .. v175 
                        local v177 = v176 .. v108 
                        local v178 = format_real_14(v142)
                        local v179 = v177 .. v178 
                        local v180 = v48 .. v179 
                        write_log_line_8(v180)
                        local v181 = v1 ~= nil and v1.l0
                        local v182 = Uh0_Nil()
                        local v183 = method20(v181, v182)
                        local v184 = Uh1_Nil()
                        local v185 = method21(v183, v184)
                        local v186, v187 = (table.unpack or unpack)(method22(v185, v131, v131))
                        local v188 = "taken "
                        local v189 = v188 .. v186 
                        local v190 = v48 .. v189 
                        write_log_line_8(v190)
                    else
                    end
                    local v191 = closure6({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 })
                    scheduleEvent(v191, 500)
                    local v192 = "server text ["
                    local v193 = v192 .. v13 
                    local v194 = "]: "
                    local v195 = v193 .. v194 
                    local v196 = v195 .. v14 
                    local v197 = "[tibia-probe] "
                    local v198 = v197 .. v196 
                    return write_log_line_8(v198)
                else
                    local v199 = "You lose"
                    local v200 = string.find(v14, v199, 1, true) ~= nil 
                    local v201 = v200 == false
                    if v201 then
                        local v202 = "server text ["
                        local v203 = v202 .. v13 
                        local v204 = "]: "
                        local v205 = v203 .. v204 
                        local v206 = v205 .. v14 
                        local v207 = "[tibia-probe] "
                        local v208 = v207 .. v206 
                        return write_log_line_8(v208)
                    else
                    end
                end
            end
        end
    end
end

function typed_c4(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(v11)
        return closure5({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 })
    end
end

function chasing_24(v0)
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

function live_monster_27(v0)
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

function scan_26(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v5 > v4
    local getv37 = function()
        if v9 then
            return { [1]=v6, [2]=v7, [3]=v8 }
        else
            local v10 = spiral_wrap_signed((v5 + 1), 32)
            local v11 = (v3)[v5]
            local v12 = live_monster_27(v11)
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
            local v34, v35, v36 = (table.unpack or unpack)(scan_26(v0, v1, v2, v3, v4, v10, v31, v32, v33))
            return { [1]=v34, [2]=v35, [3]=v36 }
        end
    end
    local v37, v38, v39 = (table.unpack or unpack)(getv37())
    return { [1]=v37, [2]=v38, [3]=v39 }
end

function closure9(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = (table.unpack or unpack)(capt)
    return function(dom)
        return ticked_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    end
end

function ticked_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    local v13 = player_present_13()
    local v14 = v13 == false
    if v14 then
        local v15 = v9 ~= nil and v9.l0
        local v16 = v15 == 0
        if v16 then
            v9.l0 = 1
            local v17 = "finish: "
            local v18 = "offline"
            local v19 = v17 .. v18 
            local v20 = "[tibia-probe] "
            local v21 = v20 .. v19 
            write_log_line_8(v21)
            local v22 = g_game.isOnline()
            if v22 then
                g_game.safeLogout()
            else
            end
            local v23 = closure3(nil)
            scheduleEvent(v23, 2000)
            return nil
        else
        end
    else
        local v24 = g_clock.millis()
        local v25 = v6 ~= nil and v6.l0
        local getv28 = function()
            if v25 ~= nil and v25.tag == "Us1_None" then
                return false
            elseif v25 ~= nil and v25.tag == "Us1_Some" then
                local v26 = v25._1
                return true
            end
        end
        local v28 = getv28()
        local getv35 = function()
            if v28 then
                local v29 = v6 ~= nil and v6.l0
                local getv33 = function()
                    if v29 ~= nil and v29.tag == "Us1_None" then
                        local v31 = nil
                        return v31
                    elseif v29 ~= nil and v29.tag == "Us1_Some" then
                        local v30 = v29._1
                        return v30
                    end
                end
                local v33 = getv33()
                local v34 = (v33):isDead()
                return v34
            else
                return false
            end
        end
        local v35 = getv35()
        if v35 then
            local v36 = v3 ~= nil and v3.l0
            local v37 = spiral_wrap_signed((v36 + 1), 32)
            v3.l0 = v37
            local v38 = v3 ~= nil and v3.l0
            local v39 = g_game.getLocalPlayer():getExperience()
            local v40 = v7 ~= nil and v7.l0
            local v41 = spiral_wrap_signed((v39 - v40), 32)
            local v42 = format_real_14(v38)
            local v43 = "kill "
            local v44 = v43 .. v42 
            local v45 = " confirmed dead, experience +"
            local v46 = v44 .. v45 
            local v47 = format_real_14(v41)
            local v48 = v46 .. v47 
            local v49 = "[tibia-probe] "
            local v50 = v49 .. v48 
            write_log_line_8(v50)
            local v51 = Us1_None()
            v6.l0 = v51
        else
        end
        local v52 = v6 ~= nil and v6.l0
        local getv55 = function()
            if v52 ~= nil and v52.tag == "Us1_None" then
                return false
            elseif v52 ~= nil and v52.tag == "Us1_Some" then
                local v53 = v52._1
                return true
            end
        end
        local v55 = getv55()
        local v56 = v55 == false
        local getv112 = function()
            if v56 then
                local v57 = g_game.getLocalPlayer():getPosition()
                local v58 = v57.x
                local v59 = v57.y
                local v60 = v57.z
                local v61 = g_map.getSpectators({ x = v58, y = v59, z = v60 }, false)
                local v62 = #(v61)
                local v63 = 1
                local v64 = false
                local v65 = 0
                local v66 = 999
                local v67, v68, v69 = (table.unpack or unpack)(scan_26(v58, v59, v60, v61, v62, v63, v64, v65, v66))
                local getv71 = function()
                    if v67 then
                        local v70 = v69 <= 1
                        return v70
                    else
                        return false
                    end
                end
                local v71 = getv71()
                if v71 then
                    local v72 = (v61)[v68]
                    local v73 = Us1_Some(v72)
                    v6.l0 = v73
                    g_game.attack(v72)
                    v5.l0 = 0
                    return v24
                else
                    return v11
                end
            else
                local v75 = spiral_wrap_signed((v24 - v11), 32)
                local v76 = v75 >= 2000
                if v76 then
                    local v77 = v6 ~= nil and v6.l0
                    local getv81 = function()
                        if v77 ~= nil and v77.tag == "Us1_None" then
                            local v79 = nil
                            return v79
                        elseif v77 ~= nil and v77.tag == "Us1_Some" then
                            local v78 = v77._1
                            return v78
                        end
                    end
                    local v81 = getv81()
                    local v82 = (v81):getPosition() ~= nil
                    local getv102 = function()
                        if v82 then
                            local v83 = (v81):getPosition()
                            local v84 = v83.x
                            local v85 = v83.y
                            local v86 = v83.z
                            local v87 = g_game.getLocalPlayer():getPosition()
                            local v88 = v87.x
                            local v89 = v87.y
                            local v90 = v87.z
                            local v91 = v84 > v88
                            local getv94 = function()
                                if v91 then
                                    local v92 = spiral_wrap_signed((v84 - v88), 32)
                                    return v92
                                else
                                    local v93 = spiral_wrap_signed((v88 - v84), 32)
                                    return v93
                                end
                            end
                            local v94 = getv94()
                            local v95 = v85 > v89
                            local getv98 = function()
                                if v95 then
                                    local v96 = spiral_wrap_signed((v85 - v89), 32)
                                    return v96
                                else
                                    local v97 = spiral_wrap_signed((v89 - v85), 32)
                                    return v97
                                end
                            end
                            local v98 = getv98()
                            local v99 = v94 > v98
                            local getv100 = function()
                                if v99 then
                                    return v94
                                else
                                    return v98
                                end
                            end
                            local v100 = getv100()
                            local v101 = v100 <= 1
                            return v101
                        else
                            return false
                        end
                    end
                    local v102 = getv102()
                    local getv108 = function()
                        if v102 then
                            local v103 = g_game.getLocalPlayer():getHealth()
                            local v104 = v103 > 0
                            if v104 then
                                local v105 = v5 ~= nil and v5.l0
                                local v106 = v105 == 0
                                return v106
                            else
                                return false
                            end
                        else
                            return false
                        end
                    end
                    local v108 = getv108()
                    if v108 then
                        local v109 = v2 ~= nil and v2.l0
                        local v110 = spiral_wrap_signed((v109 + 1), 32)
                        v2.l0 = v110
                    else
                    end
                    v5.l0 = 0
                    return v24
                else
                    return v11
                end
            end
        end
        local v112 = getv112()
        local v113 = g_game.getLocalPlayer():getHealth()
        local v114 = v113 < v10
        local getv117 = function()
            if v114 then
                local v115 = spiral_wrap_signed((v24 - v12), 32)
                local v116 = v115 >= 1000
                return v116
            else
                return false
            end
        end
        local v117 = getv117()
        local getv121 = function()
            if v117 then
                local v118 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                local v119 = v4 ~= nil and v4.l0
                local v120 = spiral_wrap_signed((v119 + 1), 32)
                v4.l0 = v120
                return v24
            else
                return v12
            end
        end
        local v121 = getv121()
        local v122 = v8 ~= nil and v8.l0
        local v123 = spiral_wrap_signed((v24 - v122), 32)
        local v124 = v123 > 200000
        local getv282 = function()
            if v124 then
                local v125 = v4 ~= nil and v4.l0
                local v126 = format_real_14(v125)
                local v127 = "potions "
                local v128 = v127 .. v126 
                local v129 = "[tibia-probe] "
                local v130 = v129 .. v128 
                write_log_line_8(v130)
                local v131 = v0 ~= nil and v0.l0
                local v132 = 0
                local v133 = method15(v131, v132)
                local v134 = v0 ~= nil and v0.l0
                local v135 = 0
                local v136 = method16(v134, v135)
                local v137 = v0 ~= nil and v0.l0
                local v138 = 0
                local v139 = method15(v137, v138)
                local v140 = v139 == 0
                local getv148 = function()
                    if v140 then
                        return 0
                    else
                        local v141 = v0 ~= nil and v0.l0
                        local v142 = Uh0_Nil()
                        local v143 = method17(v141, v142)
                        local v144 = spiral_wrap_signed((v139 + 1), 32)
                        local v145 = (math.modf(v144 / 2))
                        local v146 = spiral_wrap_signed((v145 - 1), 32)
                        return nth_19(v146, v143)
                    end
                end
                local v148 = getv148()
                local v149 = v2 ~= nil and v2.l0
                local v150 = v3 ~= nil and v3.l0
                local v151 = g_game.getLocalPlayer():getExperience()
                local v152 = v7 ~= nil and v7.l0
                local v153 = spiral_wrap_signed((v151 - v152), 32)
                local v154 = g_game.getLocalPlayer():getHealth()
                local v155 = spiral_wrap_signed((v133 + v149), 32)
                local v156 = "end"
                local v157 = ": swings "
                local v158 = v156 .. v157 
                local v159 = format_real_14(v155)
                local v160 = v158 .. v159 
                local v161 = " landed "
                local v162 = v160 .. v161 
                local v163 = format_real_14(v133)
                local v164 = v162 .. v163 
                local v165 = " ("
                local v166 = v164 .. v165 
                local v167 = v155 > 0
                local getv172 = function()
                    if v167 then
                        local v168 = v133
                        local v169 = (v168 * 100.0)
                        local v170 = v155
                        local v171 = v169 / v170
                        return v171
                    else
                        return 0.0
                    end
                end
                local v172 = getv172()
                local v173 = string.format("%." .. 1 .. "f", v172)
                local v174 = v166 .. v173 
                local v175 = "%)"
                local v176 = v174 .. v175 
                local v177 = v133 > 0
                local getv181 = function()
                    if v177 then
                        local v178 = v136
                        local v179 = v133
                        local v180 = v178 / v179
                        return v180
                    else
                        return 0.0
                    end
                end
                local v181 = getv181()
                local v182 = string.format("%." .. 2 .. "f", v181)
                local v183 = " mean landed "
                local v184 = v183 .. v182 
                local v185 = " median "
                local v186 = v184 .. v185 
                local v187 = format_real_14(v148)
                local v188 = v186 .. v187 
                local v189 = " total "
                local v190 = v188 .. v189 
                local v191 = format_real_14(v136)
                local v192 = v190 .. v191 
                local v193 = v176 .. v192 
                local v194 = format_real_14(v150)
                local v195 = " kills "
                local v196 = v195 .. v194 
                local v197 = " experience +"
                local v198 = v196 .. v197 
                local v199 = format_real_14(v153)
                local v200 = v198 .. v199 
                local v201 = " health "
                local v202 = v200 .. v201 
                local v203 = format_real_14(v154)
                local v204 = v202 .. v203 
                local v205 = v193 .. v204 
                local v206 = v129 .. v205 
                write_log_line_8(v206)
                local v207 = v0 ~= nil and v0.l0
                local v208 = Uh0_Nil()
                local v209 = method20(v207, v208)
                local v210 = Uh1_Nil()
                local v211 = method21(v209, v210)
                local v212 = ""
                local v213, v214 = (table.unpack or unpack)(method22(v211, v212, v212))
                local v215 = "hits "
                local v216 = v215 .. v213 
                local v217 = v129 .. v216 
                write_log_line_8(v217)
                local v218 = v1 ~= nil and v1.l0
                local v219 = 0
                local v220 = method15(v218, v219)
                local v221 = v1 ~= nil and v1.l0
                local v222 = 0
                local v223 = method16(v221, v222)
                local v224 = v1 ~= nil and v1.l0
                local v225 = 0
                local v226 = method15(v224, v225)
                local v227 = v226 == 0
                local getv235 = function()
                    if v227 then
                        return 0
                    else
                        local v228 = v1 ~= nil and v1.l0
                        local v229 = Uh0_Nil()
                        local v230 = method17(v228, v229)
                        local v231 = spiral_wrap_signed((v226 + 1), 32)
                        local v232 = (math.modf(v231 / 2))
                        local v233 = spiral_wrap_signed((v232 - 1), 32)
                        return nth_19(v233, v230)
                    end
                end
                local v235 = getv235()
                local v236 = v1 ~= nil and v1.l0
                local v237 = 0
                local v238 = method23(v236, v237)
                local v239 = format_real_14(v220)
                local v240 = "taken: count "
                local v241 = v240 .. v239 
                local v242 = " mean "
                local v243 = v241 .. v242 
                local v244 = v220 > 0
                local getv248 = function()
                    if v244 then
                        local v245 = v223
                        local v246 = v220
                        local v247 = v245 / v246
                        return v247
                    else
                        return 0.0
                    end
                end
                local v248 = getv248()
                local v249 = string.format("%." .. 2 .. "f", v248)
                local v250 = v243 .. v249 
                local v251 = v250 .. v185 
                local v252 = format_real_14(v235)
                local v253 = v251 .. v252 
                local v254 = " max "
                local v255 = v253 .. v254 
                local v256 = format_real_14(v238)
                local v257 = v255 .. v256 
                local v258 = v257 .. v189 
                local v259 = format_real_14(v223)
                local v260 = v258 .. v259 
                local v261 = v129 .. v260 
                write_log_line_8(v261)
                local v262 = v1 ~= nil and v1.l0
                local v263 = Uh0_Nil()
                local v264 = method20(v262, v263)
                local v265 = Uh1_Nil()
                local v266 = method21(v264, v265)
                local v267, v268 = (table.unpack or unpack)(method22(v266, v212, v212))
                local v269 = "taken "
                local v270 = v269 .. v267 
                local v271 = v129 .. v270 
                write_log_line_8(v271)
                local v272 = v9 ~= nil and v9.l0
                local v273 = v272 == 0
                if v273 then
                    v9.l0 = 1
                    local v274 = "finish: "
                    local v275 = "measure complete"
                    local v276 = v274 .. v275 
                    local v277 = v129 .. v276 
                    write_log_line_8(v277)
                    local v278 = g_game.isOnline()
                    if v278 then
                        g_game.safeLogout()
                    else
                    end
                    local v279 = closure3(nil)
                    scheduleEvent(v279, 2000)
                else
                end
                return Us2_None()
            else
                return Us2_Some(v112, v121)
            end
        end
        local v282 = getv282()
        if v282 ~= nil and v282.tag == "Us2_None" then
            return nil
        elseif v282 ~= nil and v282.tag == "Us2_Some" then
            local v283 = v282._1
            local v284 = v282._2
            local v285 = closure9({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v283, v284 })
            scheduleEvent(v285, 100)
            return nil
        end
    end
end

function closure8(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        local v11 = false
        chasing_24(v11)
        g_game.setFightMode(FightBalanced)
        local v12 = g_game.getFightMode()
        local v13 = tostring(v12)
        local v14 = g_game.getLocalPlayer():getPosition()
        local v15 = v14.x
        local v16 = v14.y
        local v17 = v14.z
        local v18 = format_real_14(v15)
        local v19 = ""
        local v20 = v19 .. v18 
        local v21 = ","
        local v22 = v20 .. v21 
        local v23 = format_real_14(v16)
        local v24 = v22 .. v23 
        local v25 = v24 .. v21 
        local v26 = format_real_14(v17)
        local v27 = v25 .. v26 
        local v28 = "fight mode "
        local v29 = v28 .. v13 
        local v30 = " at "
        local v31 = v29 .. v30 
        local v32 = v31 .. v27 
        local v33 = "[tibia-probe] "
        local v34 = v33 .. v32 
        write_log_line_8(v34)
        local v35 = g_game.getLocalPlayer():getExperience()
        v7.l0 = v35
        local v36 = g_clock.millis()
        v8.l0 = v36
        local v37 = v8 ~= nil and v8.l0
        local v38 = 0
        return ticked_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v37, v38)
    end
end

function closure7(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        local v11 = g_game.getLocalPlayer():getName()
        local v12 = g_game.getLocalPlayer():getHealth()
        local v13 = "in game as "
        local v14 = v13 .. v11 
        local v15 = " health "
        local v16 = v14 .. v15 
        local v17 = format_real_14(v12)
        local v18 = v16 .. v17 
        local v19 = "[tibia-probe] "
        local v20 = v19 .. v18 
        write_log_line_8(v20)
        local v21 = closure8({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 })
        scheduleEvent(v21, 1000)
        return nil
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_6(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23)
    end
end

function poll_6(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23)
    local v24 = v0 == ""
    local getv26 = function()
        if v24 then
            return true
        else
            return file_exists_7(v0)
        end
    end
    local v26 = getv26()
    if v26 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v27 = typed_c2(nil)
        local v28 = function(message) (v27)(message) end
        local v29 = typed_c4({ v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 })
        local v30 = function(mode, text) (v29)(mode)(text) end
        local v31 = closure7({ v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 })
        connect(g_game, { onGameStart = v31, onLoginError = v28, onTextMessage = v30 })
        local v32 = "@god"
        local v33 = "@god\ngod"
        g_game.loginWorld(v32, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v33)
        return nil
    else
        local v34 = closure10({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 })
        scheduleEvent(v34, 50)
        return nil
    end
end

function closure1(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 = (table.unpack or unpack)(capt)
    return function(dom)
        local v23 = "TIBIA_LOGIN_GATE"
        local v24 = ""
        local v25 = env_text_4(v23, v24)
        return poll_6(v25, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22)
    end
end

function on_timeout_c11(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        local v11 = v9 ~= nil and v9.l0
        local v12 = v11 == 0
        if v12 then
            v9.l0 = 1
            local v13 = "finish: "
            local v14 = "timeout"
            local v15 = v13 .. v14 
            local v16 = "[tibia-probe] "
            local v17 = v16 .. v15 
            write_log_line_8(v17)
            local v18 = g_game.isOnline()
            if v18 then
                g_game.safeLogout()
            else
            end
            local v19 = closure3(nil)
            scheduleEvent(v19, 2000)
            return nil
        else
        end
    end
end

local v0 = "TIBIA_MEASURE_POTION_BELOW"
local v1 = 90
local v2 = env_i32_0(v0, v1)
local v3 = Uh0_Nil()
local v4 = { __tag = "Mut0", l0 = v3 }
local v5 = Uh0_Nil()
local v6 = { __tag = "Mut0", l0 = v5 }
local v7 = { __tag = "Mut1", l0 = 0 }
local v8 = { __tag = "Mut1", l0 = 0 }
local v9 = { __tag = "Mut1", l0 = 0 }
local v10 = { __tag = "Mut1", l0 = 0 }
local v11 = Us1_None()
local v12 = { __tag = "Mut2", l0 = v11 }
local v13 = { __tag = "Mut1", l0 = 0 }
local v14 = { __tag = "Mut1", l0 = 0 }
local v15 = { __tag = "Mut1", l0 = 0 }
local v16 = "TIBIA_ARENA_CHARACTER"
local v17 = "Knight Sample"
local v18 = env_text_4(v16, v17)
local v19 = "TIBIA_PROBE_HIDDEN"
local v20 = get_environment_variable_1(v19)
local v21 = v20 == "1"
if v21 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_5()
local v22 = closure0(nil)
scheduleEvent(v22, 200)
scheduleEvent(v22, 1000)
local v23 = closure1({ v18, v4, v6, v7, v8, v9, v10, v12, v13, v14, v15, v2, v4, v6, v7, v8, v9, v10, v12, v13, v14, v15, v2 })
scheduleEvent(v23, 3000)
local v24 = on_timeout_c11({ v4, v6, v7, v8, v9, v10, v12, v13, v14, v15, v2 })
scheduleEvent(v24, 260000)
return 0
