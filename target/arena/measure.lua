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
local Us0_Some, Us0_None, Uh0_Cons, Mut0, Mut1, Us1_Some, Us1_None, Mut2, Uh1_Cons, Us2_Took, Us2_Dealt, Us2_Other, Mut3, Us3_Some, Us3_None, Us4_Some, Us4_None, get_environment_variable_1, method2, method3, env_i32_0, env_text_4, mute_5, closure0, file_exists_7, log_flush_9, write_log_line_8, closure3, typed_c2, digits_from_11, method12, number_between_10, player_present_13, format_real_14, method15, method16, insert_sorted_18, method17, nth_19, method20, method21, method22, method23, closure6, closure5, typed_c4, chasing_24, live_monster_27, scan_26, closure9, ticked_25, closure8, closure7, closure10, poll_6, closure1, on_timeout_c11
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

function Us2_Took(v0) return { tag = "Us2_Took",  _1 = v0 } end
function Us2_Dealt(v0) return { tag = "Us2_Dealt",  _1 = v0 } end
function Us2_Other() return { tag = "Us2_Other" } end

Mut3 = function(l0) return { __tag = "Mut3", l0 = l0 } end

function Us3_Some(v0, v1) return { tag = "Us3_Some",  _1 = v0,  _2 = v1 } end
function Us3_None() return { tag = "Us3_None" } end

function Us4_Some(v0, v1) return { tag = "Us4_Some",  _1 = v0,  _2 = v1 } end
function Us4_None() return { tag = "Us4_None" } end

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
    local v1 = (v0 .. "\n")
    g_resources.writeFileContents("/tibia-probe.log", v1)
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
        local v2 = ("game login error: " .. v1)
        local v3 = ("[tibia-probe] " .. v2)
        write_log_line_8(v3)
        local v4 = "[tibia-probe] finish: game login error"
        write_log_line_8(v4)
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
        return Us0_None()
    else
        local v10 = string.len(v0)
        local v11 = spiral_wrap_signed((v7 + v10), 32)
        local v12 = 0
        local v13, v14 = (table.unpack or unpack)(digits_from_11(v2, v11, v12))
        local v15 = v14 > v11
        local getv23 = function()
            if v15 then
                local v16 = string.len(v2)
                local v17 = spiral_wrap_signed((v16 - v14), 32)
                local v18 = spiral_wrap_signed((v14 + 1), 32)
                local v19 = spiral_wrap_signed((v14 + v17), 32)
                local v20 = string.sub(v2, v18, v19)
                local v21 = false
                return method12(v20, v1, v21)
            else
                return false
            end
        end
        local v23 = getv23()
        local getv26 = function()
            if v23 then
                return Us0_Some(v13)
            else
                return Us0_None()
            end
        end
        local v26 = getv26()
        if v26 ~= nil and v26.tag == "Us0_None" then
            local v29 = spiral_wrap_signed((v7 + 1), 32)
            local v30 = string.len(v2)
            local v31 = spiral_wrap_signed((v30 - v29), 32)
            local v32 = spiral_wrap_signed((v29 + 1), 32)
            local v33 = spiral_wrap_signed((v29 + v31), 32)
            local v34 = string.sub(v2, v32, v33)
            return number_between_10(v0, v1, v34)
        elseif v26 ~= nil and v26.tag == "Us0_Some" then
            local v27 = v26._1
            return Us0_Some(v27)
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
    local v5 = (v4 .. v3)
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
        local v6 = ("" .. v5)
        return Uh1_Cons(v6, v4)
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
            local v7 = (v3 .. v6)
            local v8 = (v7 .. v5)
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
            local v13 = "[tibia-probe] finish: death"
            write_log_line_8(v13)
            local v14 = g_game.isOnline()
            if v14 then
                g_game.safeLogout()
            else
            end
            local v15 = closure3(nil)
            scheduleEvent(v15, 2000)
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
        local v15 = "You lose "
        local v16 = " hitpoints due to an attack"
        local v17 = " hitpoint due to an attack"
        local v18 = Uh1_Nil()
        local v19 = Uh1_Cons(v17, v18)
        local v20 = Uh1_Cons(v16, v19)
        local v21 = number_between_10(v15, v20, v14)
        local getv37 = function()
            if v21 ~= nil and v21.tag == "Us0_None" then
                local v24 = "loses "
                local v25 = " hitpoints due to your"
                local v26 = " hitpoint due to your"
                local v27 = Uh1_Nil()
                local v28 = Uh1_Cons(v26, v27)
                local v29 = Uh1_Cons(v25, v28)
                local v30 = number_between_10(v24, v29, v14)
                if v30 ~= nil and v30.tag == "Us0_None" then
                    return Us2_Other()
                elseif v30 ~= nil and v30.tag == "Us0_Some" then
                    local v31 = v30._1
                    return Us2_Dealt(v31)
                end
            elseif v21 ~= nil and v21.tag == "Us0_Some" then
                local v22 = v21._1
                return Us2_Took(v22)
            end
        end
        local v37 = getv37()
        if v37 ~= nil and v37.tag == "Us2_Dealt" then
            local v41 = v37._1
            local v42 = v0 ~= nil and v0.l0
            local v43 = Uh0_Cons(v41, v42)
            v0.l0 = v43
            v5.l0 = 1
            local v44 = "critical"
            local v45 = string.find(v14, v44, 1, true) ~= nil 
            if v45 then
                local v46 = ("critical: " .. v14)
                local v47 = ("[tibia-probe] " .. v46)
                return write_log_line_8(v47)
            else
            end
        elseif v37 ~= nil and v37.tag == "Us2_Other" then
            local v48 = "You died"
            local v49 = string.find(v14, v48, 1, true) ~= nil 
            if v49 then
                local v50 = player_present_13()
                if v50 then
                    local v51 = v4 ~= nil and v4.l0
                    local v52 = format_real_14(v51)
                    local v53 = ("potions " .. v52)
                    local v54 = ("[tibia-probe] " .. v53)
                    write_log_line_8(v54)
                    local v55 = v0 ~= nil and v0.l0
                    local v56 = 0
                    local v57 = method15(v55, v56)
                    local v58 = v0 ~= nil and v0.l0
                    local v59 = 0
                    local v60 = method16(v58, v59)
                    local v61 = v0 ~= nil and v0.l0
                    local v62 = 0
                    local v63 = method15(v61, v62)
                    local v64 = v63 == 0
                    local getv72 = function()
                        if v64 then
                            return 0
                        else
                            local v65 = v0 ~= nil and v0.l0
                            local v66 = Uh0_Nil()
                            local v67 = method17(v65, v66)
                            local v68 = spiral_wrap_signed((v63 + 1), 32)
                            local v69 = (math.modf(v68 / 2))
                            local v70 = spiral_wrap_signed((v69 - 1), 32)
                            return nth_19(v70, v67)
                        end
                    end
                    local v72 = getv72()
                    local v73 = v2 ~= nil and v2.l0
                    local v74 = v3 ~= nil and v3.l0
                    local v75 = g_game.getLocalPlayer():getExperience()
                    local v76 = v7 ~= nil and v7.l0
                    local v77 = spiral_wrap_signed((v75 - v76), 32)
                    local v78 = g_game.getLocalPlayer():getHealth()
                    local v79 = spiral_wrap_signed((v57 + v73), 32)
                    local v80 = format_real_14(v79)
                    local v81 = ("death: swings " .. v80)
                    local v82 = (v81 .. " landed ")
                    local v83 = format_real_14(v57)
                    local v84 = (v82 .. v83)
                    local v85 = (v84 .. " (")
                    local v86 = v79 > 0
                    local getv91 = function()
                        if v86 then
                            local v87 = v57
                            local v88 = (v87 * 100.0)
                            local v89 = v79
                            local v90 = v88 / v89
                            return v90
                        else
                            return 0.0
                        end
                    end
                    local v91 = getv91()
                    local v92 = string.format("%." .. 1 .. "f", v91)
                    local v93 = (v85 .. v92)
                    local v94 = (v93 .. "%)")
                    local v95 = v57 > 0
                    local getv99 = function()
                        if v95 then
                            local v96 = v60
                            local v97 = v57
                            local v98 = v96 / v97
                            return v98
                        else
                            return 0.0
                        end
                    end
                    local v99 = getv99()
                    local v100 = string.format("%." .. 2 .. "f", v99)
                    local v101 = (" mean landed " .. v100)
                    local v102 = (v101 .. " median ")
                    local v103 = format_real_14(v72)
                    local v104 = (v102 .. v103)
                    local v105 = (v104 .. " total ")
                    local v106 = format_real_14(v60)
                    local v107 = (v105 .. v106)
                    local v108 = (v94 .. v107)
                    local v109 = format_real_14(v74)
                    local v110 = (" kills " .. v109)
                    local v111 = (v110 .. " experience +")
                    local v112 = format_real_14(v77)
                    local v113 = (v111 .. v112)
                    local v114 = (v113 .. " health ")
                    local v115 = format_real_14(v78)
                    local v116 = (v114 .. v115)
                    local v117 = (v108 .. v116)
                    local v118 = ("[tibia-probe] " .. v117)
                    write_log_line_8(v118)
                    local v119 = v0 ~= nil and v0.l0
                    local v120 = Uh0_Nil()
                    local v121 = method20(v119, v120)
                    local v122 = Uh1_Nil()
                    local v123 = method21(v121, v122)
                    local v124 = ""
                    local v125, v126 = (table.unpack or unpack)(method22(v123, v124, v124))
                    local v127 = ("hits " .. v125)
                    local v128 = ("[tibia-probe] " .. v127)
                    write_log_line_8(v128)
                    local v129 = v1 ~= nil and v1.l0
                    local v130 = 0
                    local v131 = method15(v129, v130)
                    local v132 = v1 ~= nil and v1.l0
                    local v133 = 0
                    local v134 = method16(v132, v133)
                    local v135 = v1 ~= nil and v1.l0
                    local v136 = 0
                    local v137 = method15(v135, v136)
                    local v138 = v137 == 0
                    local getv146 = function()
                        if v138 then
                            return 0
                        else
                            local v139 = v1 ~= nil and v1.l0
                            local v140 = Uh0_Nil()
                            local v141 = method17(v139, v140)
                            local v142 = spiral_wrap_signed((v137 + 1), 32)
                            local v143 = (math.modf(v142 / 2))
                            local v144 = spiral_wrap_signed((v143 - 1), 32)
                            return nth_19(v144, v141)
                        end
                    end
                    local v146 = getv146()
                    local v147 = v1 ~= nil and v1.l0
                    local v148 = 0
                    local v149 = method23(v147, v148)
                    local v150 = format_real_14(v131)
                    local v151 = ("taken: count " .. v150)
                    local v152 = (v151 .. " mean ")
                    local v153 = v131 > 0
                    local getv157 = function()
                        if v153 then
                            local v154 = v134
                            local v155 = v131
                            local v156 = v154 / v155
                            return v156
                        else
                            return 0.0
                        end
                    end
                    local v157 = getv157()
                    local v158 = string.format("%." .. 2 .. "f", v157)
                    local v159 = (v152 .. v158)
                    local v160 = (v159 .. " median ")
                    local v161 = format_real_14(v146)
                    local v162 = (v160 .. v161)
                    local v163 = (v162 .. " max ")
                    local v164 = format_real_14(v149)
                    local v165 = (v163 .. v164)
                    local v166 = (v165 .. " total ")
                    local v167 = format_real_14(v134)
                    local v168 = (v166 .. v167)
                    local v169 = ("[tibia-probe] " .. v168)
                    write_log_line_8(v169)
                    local v170 = v1 ~= nil and v1.l0
                    local v171 = Uh0_Nil()
                    local v172 = method20(v170, v171)
                    local v173 = Uh1_Nil()
                    local v174 = method21(v172, v173)
                    local v175, v176 = (table.unpack or unpack)(method22(v174, v124, v124))
                    local v177 = ("taken " .. v175)
                    local v178 = ("[tibia-probe] " .. v177)
                    write_log_line_8(v178)
                else
                end
                local v179 = closure6({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 })
                scheduleEvent(v179, 500)
                local v180 = ("server text [" .. v13)
                local v181 = (v180 .. "]: ")
                local v182 = (v181 .. v14)
                local v183 = ("[tibia-probe] " .. v182)
                return write_log_line_8(v183)
            else
                local v184 = "You lose"
                local v185 = string.find(v14, v184, 1, true) ~= nil 
                local v186 = v185 == false
                if v186 then
                    local v187 = ("server text [" .. v13)
                    local v188 = (v187 .. "]: ")
                    local v189 = (v188 .. v14)
                    local v190 = ("[tibia-probe] " .. v189)
                    return write_log_line_8(v190)
                else
                end
            end
        elseif v37 ~= nil and v37.tag == "Us2_Took" then
            local v38 = v37._1
            local v39 = v1 ~= nil and v1.l0
            local v40 = Uh0_Cons(v38, v39)
            v1.l0 = v40
            return nil
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

function scan_26(v0, v1, v2, v3, v4, v5, v6)
    local v7 = v5 > v4
    if v7 then
        return v6
    else
        local v8 = spiral_wrap_signed((v5 + 1), 32)
        local v9 = (v3)[v5]
        local v10 = live_monster_27(v9)
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
        return scan_26(v0, v1, v2, v3, v4, v8, v33)
    end
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
            local v17 = "[tibia-probe] finish: offline"
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
    else
        local v20 = g_clock.millis()
        local v21 = v6 ~= nil and v6.l0
        local getv24 = function()
            if v21 ~= nil and v21.tag == "Us1_None" then
                return false
            elseif v21 ~= nil and v21.tag == "Us1_Some" then
                local v22 = v21._1
                return true
            end
        end
        local v24 = getv24()
        local getv31 = function()
            if v24 then
                local v25 = v6 ~= nil and v6.l0
                local getv29 = function()
                    if v25 ~= nil and v25.tag == "Us1_None" then
                        local v27 = nil
                        return v27
                    elseif v25 ~= nil and v25.tag == "Us1_Some" then
                        local v26 = v25._1
                        return v26
                    end
                end
                local v29 = getv29()
                local v30 = (v29):isDead()
                return v30
            else
                return false
            end
        end
        local v31 = getv31()
        if v31 then
            local v32 = v3 ~= nil and v3.l0
            local v33 = spiral_wrap_signed((v32 + 1), 32)
            v3.l0 = v33
            local v34 = v3 ~= nil and v3.l0
            local v35 = g_game.getLocalPlayer():getExperience()
            local v36 = v7 ~= nil and v7.l0
            local v37 = spiral_wrap_signed((v35 - v36), 32)
            local v38 = format_real_14(v34)
            local v39 = ("kill " .. v38)
            local v40 = (v39 .. " confirmed dead, experience +")
            local v41 = format_real_14(v37)
            local v42 = (v40 .. v41)
            local v43 = ("[tibia-probe] " .. v42)
            write_log_line_8(v43)
            local v44 = Us1_None()
            v6.l0 = v44
        else
        end
        local v45 = v6 ~= nil and v6.l0
        local getv48 = function()
            if v45 ~= nil and v45.tag == "Us1_None" then
                return false
            elseif v45 ~= nil and v45.tag == "Us1_Some" then
                local v46 = v45._1
                return true
            end
        end
        local v48 = getv48()
        local v49 = v48 == false
        local getv110 = function()
            if v49 then
                local v50 = g_game.getLocalPlayer():getPosition()
                local v51 = v50.x
                local v52 = v50.y
                local v53 = v50.z
                local v54 = g_map.getSpectators({ x = v51, y = v52, z = v53 }, false)
                local v55 = #(v54)
                local v56 = 1
                local v57 = Us3_None()
                local v58 = scan_26(v51, v52, v53, v54, v55, v56, v57)
                local getv66 = function()
                    if v58 ~= nil and v58.tag == "Us3_None" then
                        return Us3_None()
                    elseif v58 ~= nil and v58.tag == "Us3_Some" then
                        local v59 = v58._1
                        local v60 = v58._2
                        local v61 = v60 <= 1
                        if v61 then
                            return v58
                        else
                            return Us3_None()
                        end
                    end
                end
                local v66 = getv66()
                if v66 ~= nil and v66.tag == "Us3_None" then
                    return v11
                elseif v66 ~= nil and v66.tag == "Us3_Some" then
                    local v67 = v66._1
                    local v68 = v66._2
                    local v69 = (v54)[v67]
                    local v70 = Us1_Some(v69)
                    v6.l0 = v70
                    g_game.attack(v69)
                    v5.l0 = 0
                    return v20
                end
            else
                local v73 = spiral_wrap_signed((v20 - v11), 32)
                local v74 = v73 >= 2000
                if v74 then
                    local v75 = v6 ~= nil and v6.l0
                    local getv79 = function()
                        if v75 ~= nil and v75.tag == "Us1_None" then
                            local v77 = nil
                            return v77
                        elseif v75 ~= nil and v75.tag == "Us1_Some" then
                            local v76 = v75._1
                            return v76
                        end
                    end
                    local v79 = getv79()
                    local v80 = (v79):getPosition() ~= nil
                    local getv100 = function()
                        if v80 then
                            local v81 = (v79):getPosition()
                            local v82 = v81.x
                            local v83 = v81.y
                            local v84 = v81.z
                            local v85 = g_game.getLocalPlayer():getPosition()
                            local v86 = v85.x
                            local v87 = v85.y
                            local v88 = v85.z
                            local v89 = v82 > v86
                            local getv92 = function()
                                if v89 then
                                    local v90 = spiral_wrap_signed((v82 - v86), 32)
                                    return v90
                                else
                                    local v91 = spiral_wrap_signed((v86 - v82), 32)
                                    return v91
                                end
                            end
                            local v92 = getv92()
                            local v93 = v83 > v87
                            local getv96 = function()
                                if v93 then
                                    local v94 = spiral_wrap_signed((v83 - v87), 32)
                                    return v94
                                else
                                    local v95 = spiral_wrap_signed((v87 - v83), 32)
                                    return v95
                                end
                            end
                            local v96 = getv96()
                            local v97 = v92 > v96
                            local getv98 = function()
                                if v97 then
                                    return v92
                                else
                                    return v96
                                end
                            end
                            local v98 = getv98()
                            local v99 = v98 <= 1
                            return v99
                        else
                            return false
                        end
                    end
                    local v100 = getv100()
                    local getv106 = function()
                        if v100 then
                            local v101 = g_game.getLocalPlayer():getHealth()
                            local v102 = v101 > 0
                            if v102 then
                                local v103 = v5 ~= nil and v5.l0
                                local v104 = v103 == 0
                                return v104
                            else
                                return false
                            end
                        else
                            return false
                        end
                    end
                    local v106 = getv106()
                    if v106 then
                        local v107 = v2 ~= nil and v2.l0
                        local v108 = spiral_wrap_signed((v107 + 1), 32)
                        v2.l0 = v108
                    else
                    end
                    v5.l0 = 0
                    return v20
                else
                    return v11
                end
            end
        end
        local v110 = getv110()
        local v111 = g_game.getLocalPlayer():getHealth()
        local v112 = v111 < v10
        local getv115 = function()
            if v112 then
                local v113 = spiral_wrap_signed((v20 - v12), 32)
                local v114 = v113 >= 1000
                return v114
            else
                return false
            end
        end
        local v115 = getv115()
        local getv119 = function()
            if v115 then
                local v116 = g_game.useInventoryItemWith(266, g_game.getLocalPlayer()) ~= false
                local v117 = v4 ~= nil and v4.l0
                local v118 = spiral_wrap_signed((v117 + 1), 32)
                v4.l0 = v118
                return v20
            else
                return v12
            end
        end
        local v119 = getv119()
        local v120 = v8 ~= nil and v8.l0
        local v121 = spiral_wrap_signed((v20 - v120), 32)
        local v122 = v121 > 200000
        local getv258 = function()
            if v122 then
                local v123 = v4 ~= nil and v4.l0
                local v124 = format_real_14(v123)
                local v125 = ("potions " .. v124)
                local v126 = ("[tibia-probe] " .. v125)
                write_log_line_8(v126)
                local v127 = v0 ~= nil and v0.l0
                local v128 = 0
                local v129 = method15(v127, v128)
                local v130 = v0 ~= nil and v0.l0
                local v131 = 0
                local v132 = method16(v130, v131)
                local v133 = v0 ~= nil and v0.l0
                local v134 = 0
                local v135 = method15(v133, v134)
                local v136 = v135 == 0
                local getv144 = function()
                    if v136 then
                        return 0
                    else
                        local v137 = v0 ~= nil and v0.l0
                        local v138 = Uh0_Nil()
                        local v139 = method17(v137, v138)
                        local v140 = spiral_wrap_signed((v135 + 1), 32)
                        local v141 = (math.modf(v140 / 2))
                        local v142 = spiral_wrap_signed((v141 - 1), 32)
                        return nth_19(v142, v139)
                    end
                end
                local v144 = getv144()
                local v145 = v2 ~= nil and v2.l0
                local v146 = v3 ~= nil and v3.l0
                local v147 = g_game.getLocalPlayer():getExperience()
                local v148 = v7 ~= nil and v7.l0
                local v149 = spiral_wrap_signed((v147 - v148), 32)
                local v150 = g_game.getLocalPlayer():getHealth()
                local v151 = spiral_wrap_signed((v129 + v145), 32)
                local v152 = format_real_14(v151)
                local v153 = ("end: swings " .. v152)
                local v154 = (v153 .. " landed ")
                local v155 = format_real_14(v129)
                local v156 = (v154 .. v155)
                local v157 = (v156 .. " (")
                local v158 = v151 > 0
                local getv163 = function()
                    if v158 then
                        local v159 = v129
                        local v160 = (v159 * 100.0)
                        local v161 = v151
                        local v162 = v160 / v161
                        return v162
                    else
                        return 0.0
                    end
                end
                local v163 = getv163()
                local v164 = string.format("%." .. 1 .. "f", v163)
                local v165 = (v157 .. v164)
                local v166 = (v165 .. "%)")
                local v167 = v129 > 0
                local getv171 = function()
                    if v167 then
                        local v168 = v132
                        local v169 = v129
                        local v170 = v168 / v169
                        return v170
                    else
                        return 0.0
                    end
                end
                local v171 = getv171()
                local v172 = string.format("%." .. 2 .. "f", v171)
                local v173 = (" mean landed " .. v172)
                local v174 = (v173 .. " median ")
                local v175 = format_real_14(v144)
                local v176 = (v174 .. v175)
                local v177 = (v176 .. " total ")
                local v178 = format_real_14(v132)
                local v179 = (v177 .. v178)
                local v180 = (v166 .. v179)
                local v181 = format_real_14(v146)
                local v182 = (" kills " .. v181)
                local v183 = (v182 .. " experience +")
                local v184 = format_real_14(v149)
                local v185 = (v183 .. v184)
                local v186 = (v185 .. " health ")
                local v187 = format_real_14(v150)
                local v188 = (v186 .. v187)
                local v189 = (v180 .. v188)
                local v190 = ("[tibia-probe] " .. v189)
                write_log_line_8(v190)
                local v191 = v0 ~= nil and v0.l0
                local v192 = Uh0_Nil()
                local v193 = method20(v191, v192)
                local v194 = Uh1_Nil()
                local v195 = method21(v193, v194)
                local v196 = ""
                local v197, v198 = (table.unpack or unpack)(method22(v195, v196, v196))
                local v199 = ("hits " .. v197)
                local v200 = ("[tibia-probe] " .. v199)
                write_log_line_8(v200)
                local v201 = v1 ~= nil and v1.l0
                local v202 = 0
                local v203 = method15(v201, v202)
                local v204 = v1 ~= nil and v1.l0
                local v205 = 0
                local v206 = method16(v204, v205)
                local v207 = v1 ~= nil and v1.l0
                local v208 = 0
                local v209 = method15(v207, v208)
                local v210 = v209 == 0
                local getv218 = function()
                    if v210 then
                        return 0
                    else
                        local v211 = v1 ~= nil and v1.l0
                        local v212 = Uh0_Nil()
                        local v213 = method17(v211, v212)
                        local v214 = spiral_wrap_signed((v209 + 1), 32)
                        local v215 = (math.modf(v214 / 2))
                        local v216 = spiral_wrap_signed((v215 - 1), 32)
                        return nth_19(v216, v213)
                    end
                end
                local v218 = getv218()
                local v219 = v1 ~= nil and v1.l0
                local v220 = 0
                local v221 = method23(v219, v220)
                local v222 = format_real_14(v203)
                local v223 = ("taken: count " .. v222)
                local v224 = (v223 .. " mean ")
                local v225 = v203 > 0
                local getv229 = function()
                    if v225 then
                        local v226 = v206
                        local v227 = v203
                        local v228 = v226 / v227
                        return v228
                    else
                        return 0.0
                    end
                end
                local v229 = getv229()
                local v230 = string.format("%." .. 2 .. "f", v229)
                local v231 = (v224 .. v230)
                local v232 = (v231 .. " median ")
                local v233 = format_real_14(v218)
                local v234 = (v232 .. v233)
                local v235 = (v234 .. " max ")
                local v236 = format_real_14(v221)
                local v237 = (v235 .. v236)
                local v238 = (v237 .. " total ")
                local v239 = format_real_14(v206)
                local v240 = (v238 .. v239)
                local v241 = ("[tibia-probe] " .. v240)
                write_log_line_8(v241)
                local v242 = v1 ~= nil and v1.l0
                local v243 = Uh0_Nil()
                local v244 = method20(v242, v243)
                local v245 = Uh1_Nil()
                local v246 = method21(v244, v245)
                local v247, v248 = (table.unpack or unpack)(method22(v246, v196, v196))
                local v249 = ("taken " .. v247)
                local v250 = ("[tibia-probe] " .. v249)
                write_log_line_8(v250)
                local v251 = v9 ~= nil and v9.l0
                local v252 = v251 == 0
                if v252 then
                    v9.l0 = 1
                    local v253 = "[tibia-probe] finish: measure complete"
                    write_log_line_8(v253)
                    local v254 = g_game.isOnline()
                    if v254 then
                        g_game.safeLogout()
                    else
                    end
                    local v255 = closure3(nil)
                    scheduleEvent(v255, 2000)
                else
                end
                return Us4_None()
            else
                return Us4_Some(v110, v119)
            end
        end
        local v258 = getv258()
        if v258 ~= nil and v258.tag == "Us4_None" then
            return nil
        elseif v258 ~= nil and v258.tag == "Us4_Some" then
            local v259 = v258._1
            local v260 = v258._2
            local v261 = closure9({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v259, v260 })
            scheduleEvent(v261, 100)
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
        local v19 = ("" .. v18)
        local v20 = (v19 .. ",")
        local v21 = format_real_14(v16)
        local v22 = (v20 .. v21)
        local v23 = (v22 .. ",")
        local v24 = format_real_14(v17)
        local v25 = (v23 .. v24)
        local v26 = ("fight mode " .. v13)
        local v27 = (v26 .. " at ")
        local v28 = (v27 .. v25)
        local v29 = ("[tibia-probe] " .. v28)
        write_log_line_8(v29)
        local v30 = g_game.getLocalPlayer():getExperience()
        v7.l0 = v30
        local v31 = g_clock.millis()
        v8.l0 = v31
        local v32 = v8 ~= nil and v8.l0
        local v33 = 0
        return ticked_25(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v32, v33)
    end
end

function closure7(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = (table.unpack or unpack)(capt)
    return function(dom)
        local v11 = g_game.getLocalPlayer():getName()
        local v12 = g_game.getLocalPlayer():getHealth()
        local v13 = ("in game as " .. v11)
        local v14 = (v13 .. " health ")
        local v15 = format_real_14(v12)
        local v16 = (v14 .. v15)
        local v17 = ("[tibia-probe] " .. v16)
        write_log_line_8(v17)
        local v18 = closure8({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 })
        scheduleEvent(v18, 1000)
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
            local v13 = "[tibia-probe] finish: timeout"
            write_log_line_8(v13)
            local v14 = g_game.isOnline()
            if v14 then
                g_game.safeLogout()
            else
            end
            local v15 = closure3(nil)
            scheduleEvent(v15, 2000)
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
