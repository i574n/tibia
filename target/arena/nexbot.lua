local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Mut0, Uh0_Cons, Mut1, Us0_Some, Us0_None, Uh1_Cons, fresh_counts_1, closure0, counting_3, counting_if_present_4, guarded_pick_6, closure1, guarding_cancel_follow_5, wrapped_attack_calls_2, method7, instrument_0, get_environment_variable_9, env_text_8, disable_client_bot_10, mute_11, closure2, file_exists_13, log_flush_15, write_log_line_14, closure5, typed_c4, format_real_16, closure7, typed_c6, enable_client_bot_17, method19, method20, env_i32_18, player_present_22, parity_summary_23, closure10, go_21, attacking_short_25, held_text_28, calls_head_27, modes_text_29, method31, method32, method33, called_text_30, target_distance_text_34, report_26, closure11, go_24, closure9, ready_c8, closure12, poll_12, closure3, closure13
Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1, v2) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1,  _3 = v2 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

function Us0_Some(v0) return { tag = "Us0_Some",  _1 = v0 } end
function Us0_None() return { tag = "Us0_None" } end

Uh1_Nil = (function() local shared = { tag = "Uh1_Nil" } return function() return shared end end)()
function Uh1_Cons(v0, v1) return { tag = "Uh1_Cons",  _1 = v0,  _2 = v1 } end

function fresh_counts_1()
    local v0 = { __tag = "Mut0", l0 = 0 }
    local v1 = { __tag = "Mut0", l0 = 0 }
    local v2 = { __tag = "Mut0", l0 = 0 }
    local v3 = { __tag = "Mut0", l0 = 0 }
    local v4 = { __tag = "Mut0", l0 = 0 }
    local v5 = { __tag = "Mut0", l0 = 0 }
    local v6 = { __tag = "Mut0", l0 = 0 }
    local v7 = { __tag = "Mut0", l0 = 0 }
    local v8 = { __tag = "Mut0", l0 = 0 }
    local v9 = { __tag = "Mut0", l0 = 0 }
    local v10 = { __tag = "Mut0", l0 = 0 }
    local v11 = { __tag = "Mut0", l0 = 0 }
    local v12 = { __tag = "Mut0", l0 = 0 }
    local v13 = { __tag = "Mut0", l0 = 0 }
    local v14 = { __tag = "Mut0", l0 = 0 }
    local v15 = { __tag = "Mut0", l0 = 0 }
    local v16 = { __tag = "Mut0", l0 = 0 }
    local v17 = { __tag = "Mut0", l0 = 0 }
    local v18 = "autoWalk"
    local v19 = "cancelFollow"
    local v20 = "equipItem"
    local v21 = "follow"
    local v22 = "forceWalk"
    local v23 = "look"
    local v24 = "move"
    local v25 = "setChaseMode"
    local v26 = "setFightMode"
    local v27 = "stop"
    local v28 = "talk"
    local v29 = "turn"
    local v30 = "useInventoryItemWith"
    local v31 = "useWith"
    local v32 = "walk"
    local v33 = Uh0_Nil()
    local v34 = Uh0_Cons(v32, v0, v33)
    local v35 = Uh0_Cons(v31, v1, v34)
    local v36 = Uh0_Cons(v30, v2, v35)
    local v37 = Uh0_Cons(v29, v3, v36)
    local v38 = Uh0_Cons(v28, v4, v37)
    local v39 = Uh0_Cons(v27, v5, v38)
    local v40 = Uh0_Cons(v26, v6, v39)
    local v41 = Uh0_Cons(v25, v7, v40)
    local v42 = Uh0_Cons(v24, v8, v41)
    local v43 = Uh0_Cons(v23, v9, v42)
    local v44 = Uh0_Cons(v22, v10, v43)
    local v45 = Uh0_Cons(v21, v11, v44)
    local v46 = Uh0_Cons(v20, v12, v45)
    local v47 = Uh0_Cons(v19, v13, v46)
    local v48 = Uh0_Cons(v18, v14, v47)
    return { [1]=v15, [2]=v16, [3]=v17, [4]=v48 }
end

function closure0(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = v0 ~= nil and v0.l0
        local v3 = spiral_wrap_signed((v2 + 1), 32)
        v0.l0 = v3
        return v1
    end
end

function counting_3(v0, v1)
    local v2 = g_game
    local v3 = (v2)[v0]
    local v4 = g_game
    local v5 = closure0({ v1, v3 })
    do (v4)[v0] = function(...) return (v5)()(...) end end
    return nil
end

function counting_if_present_4(v0, v1)
    local v2 = g_game
    local v3 = (v2)[v0]
    local v4 = type(v3) == "function"
    if v4 then
        return counting_3(v0, v1)
    else
    end
end

function guarded_pick_6(v0, v1)
    local v2 = g_game.getFollowingCreature() ~= nil
    if v2 then
        return v1
    else
        local v3 = function() end
        local v4 = v0 ~= nil and v0.l0
        local v5 = spiral_wrap_signed((v4 + 1), 32)
        v0.l0 = v5
        return v3
    end
end

function closure1(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        return guarded_pick_6(v0, v1)
    end
end

function guarding_cancel_follow_5(v0)
    local v1 = g_game
    local v2 = "cancelFollow"
    local v3 = (v1)[v2]
    local v4 = g_game
    local v5 = closure1({ v0, v3 })
    do (v4)[v2] = function(...) return (v5)()(...) end end
    return nil
end

function wrapped_attack_calls_2(v0, v1, v2, v3)
    local v4 = "attack"
    counting_3(v4, v0)
    local v5 = "cancelAttack"
    counting_if_present_4(v5, v1)
    local v6 = "cancelAttackAndFollow"
    counting_if_present_4(v6, v1)
    return guarding_cancel_follow_5(v2)
end

function method7(v0)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v1 = v0._1
        local v2 = v0._2
        local v3 = v0._3
        counting_if_present_4(v1, v2)
        return method7(v3)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return nil
    end
end

function instrument_0()
    local v0, v1, v2, v3 = (table.unpack or unpack)(fresh_counts_1())
    wrapped_attack_calls_2(v0, v1, v2, v3)
    method7(v3)
    return { [1]=v0, [2]=v1, [3]=v2, [4]=v3 }
end

function get_environment_variable_9(v0)
    local v1 = os.getenv(v0) or ""
    return v1
end

function env_text_8(v0, v1)
    local v2 = get_environment_variable_9(v0)
    local v3 = v2 == ""
    if v3 then
        return v1
    else
        return v2
    end
end

function disable_client_bot_10(v0)
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

function mute_11()
    g_settings.set("enableAudio", false)
    local v0 = g_sounds ~= nil
    if v0 then
        g_sounds.setAudioEnabled(false)
        g_sounds.stopAll()
        return nil
    else
    end
end

function closure2(capt)
    return function(dom)
        local v0 = "TIBIA_PROBE_HIDDEN"
        local v1 = get_environment_variable_9(v0)
        local v2 = v1 == "1"
        if v2 then
            g_window.move({ x = -32000, y = -32000 })
            g_window.hide()
        else
        end
        return mute_11()
    end
end

function file_exists_13(v0)
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

function log_flush_15()
    local v0 = table.concat(TibiaProbeLog, string.char(10))
    local v1 = (v0 .. "\n")
    g_resources.writeFileContents("/tibia-probe.log", v1)
    return nil
end

function write_log_line_14(v0)
    local v1 = TibiaProbeLog == nil
    if v1 then
        TibiaProbeLog = {}
    else
    end
    table.insert(TibiaProbeLog, v0)
    g_logger.info(v0)
    return log_flush_15()
end

function closure5(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function typed_c4(capt)
    return function(v0)
        local v1 = tostring(v0)
        local v2 = ("game login error: " .. v1)
        local v3 = ("[tibia-probe] " .. v2)
        write_log_line_14(v3)
        local v4 = "[tibia-probe] finish: game login error"
        write_log_line_14(v4)
        local v5 = g_game.isOnline()
        if v5 then
            g_game.safeLogout()
        else
        end
        local v6 = closure5(nil)
        scheduleEvent(v6, 2000)
        return nil
    end
end

function format_real_16(v0)
    local v1 = ""
    local v2 = { __tag = "Mut1", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = (v4 .. v3)
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
end

function closure7(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(v3)
        local v4 = tostring(v2)
        local v5 = tostring(v3)
        local v6 = g_clock.millis()
        local v7 = v1 ~= nil and v1.l0
        local v8 = spiral_wrap_signed((v6 - v7), 32)
        local v9 = v0 ~= nil and v0.l0
        local v10 = v9 == 1
        local getv13 = function()
            if v10 then
                local v11 = "health potion"
                local v12 = string.find(v5, v11, 1, true) ~= nil 
                return v12
            else
                return false
            end
        end
        local v13 = getv13()
        if v13 then
            local v14 = ("server text after finish (potion not counted) [" .. v4)
            local v15 = (v14 .. "] @t+")
            local v16 = format_real_16(v8)
            local v17 = (v15 .. v16)
            local v18 = ("[tibia-probe] " .. v17)
            return write_log_line_14(v18)
        else
            local v19 = ("server text [" .. v4)
            local v20 = (v19 .. "]: ")
            local v21 = (v20 .. v5)
            local v22 = (v21 .. " @t+")
            local v23 = format_real_16(v8)
            local v24 = (v22 .. v23)
            local v25 = ("[tibia-probe] " .. v24)
            return write_log_line_14(v25)
        end
    end
end

function typed_c6(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(v2)
        return closure7({ v0, v1, v2 })
    end
end

function enable_client_bot_17(v0, v1)
    local v2 = g_settings.getNode("bot")
    local v3 = (v2) ~= nil
    local getv5 = function()
        if v3 then
            return v2
        else
            local v4 = {}
            return v4
        end
    end
    local v5 = getv5()
    do (v5)[v0] = { enabled = true, config = v1 } end
    g_settings.setNode("bot", v5)
    g_settings.save()
    return nil
end

function method19(v0, v1, v2)
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
            return method19(v0, v1, v12)
        else
            return v2
        end
    end
end

function method20(v0, v1)
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
            return method20(v0, v3)
        else
            return v3
        end
    end
end

function env_i32_18(v0, v1)
    local v2 = get_environment_variable_9(v0)
    local v3 = string.len(v2)
    local v4 = 0
    local v5 = method19(v2, v3, v4)
    local v6 = spiral_wrap_signed((v3 - 1), 32)
    local v7 = string.sub(v2, (v5)+1, (v6)+1)
    local v8 = string.len(v7)
    local v9 = method20(v7, v8)
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

function player_present_22()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function parity_summary_23()
    local v0 = ArenaParity ~= nil
    if v0 then
        local v1 = ArenaParity.summary()
        return v1
    else
        local v2 = ""
        return v2
    end
end

function closure10(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_21(v0, v1, v2, v3, v4, v5)
    end
end

function go_21(v0, v1, v2, v3, v4, v5)
    local v6 = v5 ~= nil and v5.l0
    local v7 = v6 == 0
    local getv9 = function()
        if v7 then
            return player_present_22()
        else
            return false
        end
    end
    local v9 = getv9()
    if v9 then
        local v10 = g_game.getLocalPlayer():getHealth()
        local v11 = v3 ~= nil and v3.l0
        local v12 = v10 < v11
        if v12 then
            v3.l0 = v10
        else
        end
        local v13 = g_clock.millis()
        local v14 = spiral_wrap_signed((v13 - v1), 32)
        local v15 = v4 ~= nil and v4.l0
        local v16 = v15 == 0
        local getv20 = function()
            if v16 then
                local v17 = g_game.getLocalPlayer():getExperience()
                local v18 = spiral_wrap_signed((v17 - v0), 32)
                local v19 = v18 >= v2
                return v19
            else
                return false
            end
        end
        local v20 = getv20()
        local getv45 = function()
            if v20 then
                v4.l0 = 1
                local v21 = g_game.getLocalPlayer():getExperience()
                local v22 = spiral_wrap_signed((v21 - v0), 32)
                local v23 = v3 ~= nil and v3.l0
                local v24 = format_real_16(v14)
                local v25 = ("cleared at " .. v24)
                local v26 = (v25 .. " ms")
                local v27 = ("[tibia-probe] " .. v26)
                write_log_line_14(v27)
                local v28 = format_real_16(v22)
                local v29 = ("cleared: experience +" .. v28)
                local v30 = (v29 .. " health ")
                local v31 = format_real_16(v10)
                local v32 = (v30 .. v31)
                local v33 = (v32 .. " lowest health ")
                local v34 = format_real_16(v23)
                local v35 = (v33 .. v34)
                local v36 = ("[tibia-probe] " .. v35)
                write_log_line_14(v36)
                local v37 = v5 ~= nil and v5.l0
                local v38 = v37 == 0
                if v38 then
                    v5.l0 = 1
                    local v39 = parity_summary_23()
                    local v40 = v39 ~= ""
                    if v40 then
                        local v41 = ("[tibia-probe] " .. v39)
                        write_log_line_14(v41)
                    else
                    end
                    local v42 = "[tibia-probe] finish: cleared"
                    write_log_line_14(v42)
                    local v43 = g_game.isOnline()
                    if v43 then
                        g_game.safeLogout()
                    else
                    end
                    local v44 = closure5(nil)
                    scheduleEvent(v44, 2000)
                else
                end
                return true
            else
                return false
            end
        end
        local v45 = getv45()
        local v46 = v45 == false
        if v46 then
            local v47 = closure10({ v0, v1, v2, v3, v4, v5 })
            scheduleEvent(v47, 100)
            return nil
        else
        end
    else
    end
end

function attacking_short_25()
    local v0 = g_game.getAttackingCreature()
    local v1 = (v0) ~= nil
    if v1 then
        local v2 = (v0):getName()
        local v3 = (v2 .. " ")
        local v4 = (v0):getHealthPercent()
        local v5 = format_real_16(v4)
        local v6 = (v3 .. v5)
        local v7 = (v6 .. "%")
        return v7
    else
        local v8 = "nothing"
        return v8
    end
end

function held_text_28(v0)
    local v1 = g_game.getLocalPlayer()
    local v2 = (v1):getInventoryItem(v0)
    local v3 = (v2) ~= nil
    if v3 then
        local v4 = (v2):getId()
        local v5 = format_real_16(v4)
        local v6 = ("" .. v5)
        return v6
    else
        local v7 = "-"
        return v7
    end
end

function calls_head_27(v0, v1, v2, v3)
    local v4 = InventorySlotLeft
    local v5 = held_text_28(v4)
    local v6 = (v5 .. "/")
    local v7 = InventorySlotRight
    local v8 = held_text_28(v7)
    local v9 = (v6 .. v8)
    local v10 = v0 ~= nil and v0.l0
    local v11 = format_real_16(v10)
    local v12 = ("diag attack calls " .. v11)
    local v13 = (v12 .. " cancels ")
    local v14 = v1 ~= nil and v1.l0
    local v15 = format_real_16(v14)
    local v16 = (v13 .. v15)
    local v17 = (v16 .. " hands ")
    local v18 = (v17 .. v9)
    return v18
end

function modes_text_29()
    local v0 = g_game.getChaseMode()
    local v1 = format_real_16(v0)
    local v2 = (" chase " .. v1)
    local v3 = (v2 .. " fight ")
    local v4 = g_game.getFightMode()
    local v5 = tostring(v4)
    local v6 = (v3 .. v5)
    return v6
end

function method31(v0, v1)
    if v0 ~= nil and v0.tag == "Uh0_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = v3 ~= nil and v3.l0
        local v6 = v5 > 0
        local getv12 = function()
            if v6 then
                local v7 = (v2 .. "=")
                local v8 = v3 ~= nil and v3.l0
                local v9 = format_real_16(v8)
                local v10 = (v7 .. v9)
                return Uh1_Cons(v10, v1)
            else
                return v1
            end
        end
        local v12 = getv12()
        return method31(v4, v12)
    elseif v0 ~= nil and v0.tag == "Uh0_Nil" then
        return v1
    end
end

function method32(v0, v1)
    if v0 ~= nil and v0.tag == "Uh1_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = Uh1_Cons(v2, v1)
        return method32(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh1_Nil" then
        return v1
    end
end

function method33(v0, v1, v2)
    local getv12 = function()
        if v0 ~= nil and v0.tag == "Uh1_Cons" then
            local v3 = v0._1
            local v4 = v0._2
            local v5, v6 = (table.unpack or unpack)(method33(v4, v1, v2))
            local v7 = (v3 .. v6)
            local v8 = (v7 .. v5)
            local v9 = " "
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

function called_text_30(v0, v1, v2, v3)
    local v4 = Uh1_Nil()
    local v5 = method31(v3, v4)
    local v6 = Uh1_Nil()
    local v7 = method32(v5, v6)
    local v8 = ""
    local v9, v10 = (table.unpack or unpack)(method33(v7, v8, v8))
    return v9
end

function target_distance_text_34()
    local v0 = g_game.getAttackingCreature()
    local v1 = (v0) ~= nil
    if v1 then
        local v2 = (v0):getPosition()
        local v3 = v2.x
        local v4 = v2.y
        local v5 = v2.z
        local v6 = g_game.getLocalPlayer():getPosition()
        local v7 = v6.x
        local v8 = v6.y
        local v9 = v6.z
        local v10 = v3 > v7
        local getv13 = function()
            if v10 then
                local v11 = spiral_wrap_signed((v3 - v7), 32)
                return v11
            else
                local v12 = spiral_wrap_signed((v7 - v3), 32)
                return v12
            end
        end
        local v13 = getv13()
        local v14 = v4 > v8
        local getv17 = function()
            if v14 then
                local v15 = spiral_wrap_signed((v4 - v8), 32)
                return v15
            else
                local v16 = spiral_wrap_signed((v8 - v4), 32)
                return v16
            end
        end
        local v17 = getv17()
        local v18 = v13 > v17
        local getv19 = function()
            if v18 then
                return v13
            else
                return v17
            end
        end
        local v19 = getv19()
        local v20 = format_real_16(v19)
        local v21 = ("" .. v20)
        return v21
    else
        local v22 = "-"
        return v22
    end
end

function report_26(v0, v1, v2, v3)
    local v4 = calls_head_27(v0, v1, v2, v3)
    local v5 = modes_text_29()
    local v6 = called_text_30(v0, v1, v2, v3)
    local v7 = (" calls " .. v6)
    local v8 = (v7 .. " guarded cancelFollow ")
    local v9 = v2 ~= nil and v2.l0
    local v10 = format_real_16(v9)
    local v11 = (v8 .. v10)
    local v12 = (v4 .. " target distance ")
    local v13 = target_distance_text_34()
    local v14 = (v12 .. v13)
    local v15 = (v14 .. v5)
    local v16 = (v15 .. v11)
    return v16
end

function closure11(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 = (table.unpack or unpack)(capt)
    return function(dom)
        return go_24(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    end
end

function go_24(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    local v10 = v9 ~= nil and v9.l0
    local v11 = v10 == 0
    if v11 then
        local v12 = player_present_22()
        local v13 = v12 == false
        if v13 then
            local v14 = v9 ~= nil and v9.l0
            local v15 = v14 == 0
            if v15 then
                v9.l0 = 1
                local v16 = parity_summary_23()
                local v17 = v16 ~= ""
                if v17 then
                    local v18 = ("[tibia-probe] " .. v16)
                    write_log_line_14(v18)
                else
                end
                local v19 = "[tibia-probe] finish: offline"
                write_log_line_14(v19)
                local v20 = g_game.isOnline()
                if v20 then
                    g_game.safeLogout()
                else
                end
                local v21 = closure5(nil)
                scheduleEvent(v21, 2000)
                return nil
            else
            end
        else
            local v22 = g_game.getLocalPlayer():getHealth()
            local v23 = v7 ~= nil and v7.l0
            local v24 = v22 < v23
            if v24 then
                v7.l0 = v22
            else
            end
            local v25 = g_clock.millis()
            local v26 = spiral_wrap_signed((v25 - v5), 32)
            local v27 = v8 ~= nil and v8.l0
            local v28 = v27 == 0
            local getv32 = function()
                if v28 then
                    local v29 = g_game.getLocalPlayer():getExperience()
                    local v30 = spiral_wrap_signed((v29 - v4), 32)
                    local v31 = v30 >= v6
                    return v31
                else
                    return false
                end
            end
            local v32 = getv32()
            local getv57 = function()
                if v32 then
                    v8.l0 = 1
                    local v33 = g_game.getLocalPlayer():getExperience()
                    local v34 = spiral_wrap_signed((v33 - v4), 32)
                    local v35 = v7 ~= nil and v7.l0
                    local v36 = format_real_16(v26)
                    local v37 = ("cleared at " .. v36)
                    local v38 = (v37 .. " ms")
                    local v39 = ("[tibia-probe] " .. v38)
                    write_log_line_14(v39)
                    local v40 = format_real_16(v34)
                    local v41 = ("cleared: experience +" .. v40)
                    local v42 = (v41 .. " health ")
                    local v43 = format_real_16(v22)
                    local v44 = (v42 .. v43)
                    local v45 = (v44 .. " lowest health ")
                    local v46 = format_real_16(v35)
                    local v47 = (v45 .. v46)
                    local v48 = ("[tibia-probe] " .. v47)
                    write_log_line_14(v48)
                    local v49 = v9 ~= nil and v9.l0
                    local v50 = v49 == 0
                    if v50 then
                        v9.l0 = 1
                        local v51 = parity_summary_23()
                        local v52 = v51 ~= ""
                        if v52 then
                            local v53 = ("[tibia-probe] " .. v51)
                            write_log_line_14(v53)
                        else
                        end
                        local v54 = "[tibia-probe] finish: cleared"
                        write_log_line_14(v54)
                        local v55 = g_game.isOnline()
                        if v55 then
                            g_game.safeLogout()
                        else
                        end
                        local v56 = closure5(nil)
                        scheduleEvent(v56, 2000)
                    else
                    end
                    return true
                else
                    return false
                end
            end
            local v57 = getv57()
            local v58 = v57 == false
            if v58 then
                local v59 = g_game.getLocalPlayer():getExperience()
                local v60 = spiral_wrap_signed((v59 - v4), 32)
                local v61 = v7 ~= nil and v7.l0
                local v62 = attacking_short_25()
                local v63 = g_game.getLocalPlayer():getPosition()
                local v64 = v63.x
                local v65 = v63.y
                local v66 = v63.z
                local v67 = format_real_16(v64)
                local v68 = ("" .. v67)
                local v69 = (v68 .. ",")
                local v70 = format_real_16(v65)
                local v71 = (v69 .. v70)
                local v72 = (v71 .. ",")
                local v73 = format_real_16(v66)
                local v74 = (v72 .. v73)
                local v75 = (math.modf(v26 / 1000))
                local v76 = format_real_16(v75)
                local v77 = ("t=" .. v76)
                local v78 = (v77 .. "s experience +")
                local v79 = format_real_16(v60)
                local v80 = (v78 .. v79)
                local v81 = (v80 .. " health ")
                local v82 = format_real_16(v22)
                local v83 = (v81 .. v82)
                local v84 = (v83 .. " lowest ")
                local v85 = format_real_16(v61)
                local v86 = (v84 .. v85)
                local v87 = (v86 .. " attacking ")
                local v88 = (v87 .. v62)
                local v89 = (v88 .. " at ")
                local v90 = (v89 .. v74)
                local v91 = ("[tibia-probe] " .. v90)
                write_log_line_14(v91)
                local v92 = report_26(v0, v1, v2, v3)
                local v93 = v92 ~= ""
                if v93 then
                    local v94 = ("[tibia-probe] " .. v92)
                    write_log_line_14(v94)
                else
                end
                local v95 = v26 > 150000
                if v95 then
                    local v96 = format_real_16(v60)
                    local v97 = ("end: experience +" .. v96)
                    local v98 = (v97 .. " lowest health ")
                    local v99 = format_real_16(v61)
                    local v100 = (v98 .. v99)
                    local v101 = ("[tibia-probe] " .. v100)
                    write_log_line_14(v101)
                    local v102 = v9 ~= nil and v9.l0
                    local v103 = v102 == 0
                    if v103 then
                        v9.l0 = 1
                        local v104 = parity_summary_23()
                        local v105 = v104 ~= ""
                        if v105 then
                            local v106 = ("[tibia-probe] " .. v104)
                            write_log_line_14(v106)
                        else
                        end
                        local v107 = "[tibia-probe] finish: run complete"
                        write_log_line_14(v107)
                        local v108 = g_game.isOnline()
                        if v108 then
                            g_game.safeLogout()
                        else
                        end
                        local v109 = closure5(nil)
                        scheduleEvent(v109, 2000)
                        return nil
                    else
                    end
                else
                    local v110 = closure11({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 })
                    scheduleEvent(v110, 10000)
                    return nil
                end
            else
            end
        end
    else
    end
end

function closure9(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        g_game.setFightMode(FightBalanced)
        local v6 = "TIBIA_ARENA_CHARACTER"
        local v7 = "Knight Sample"
        local v8 = env_text_8(v6, v7)
        local v9 = (v8 .. "_1511")
        local v10 = "nExBot"
        enable_client_bot_17(v9, v10)
        modules.game_bot.refresh()
        local v11 = g_clock.millis()
        local v12 = v5 ~= nil and v5.l0
        local v13 = spiral_wrap_signed((v11 - v12), 32)
        local v14 = format_real_16(v13)
        local v15 = ("client bot starts @t+" .. v14)
        local v16 = ("[tibia-probe] " .. v15)
        write_log_line_14(v16)
        local v17 = g_game.getLocalPlayer():getExperience()
        local v18 = g_clock.millis()
        local v19 = "TIBIA_ARENA_FULL_EXPERIENCE"
        local v20 = 90
        local v21 = env_i32_18(v19, v20)
        local v22 = { __tag = "Mut0", l0 = 999 }
        local v23 = { __tag = "Mut0", l0 = 0 }
        go_21(v17, v18, v21, v22, v23, v4)
        return go_24(v0, v1, v2, v3, v17, v18, v21, v22, v23, v4)
    end
end

function ready_c8(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        local v6 = g_game.getLocalPlayer():getName()
        local v7 = g_game.getLocalPlayer():getHealth()
        local v8 = ("in game as " .. v6)
        local v9 = (v8 .. " health ")
        local v10 = format_real_16(v7)
        local v11 = (v9 .. v10)
        local v12 = (v11 .. " ")
        local v13 = (v12 .. "(nExBot 4.0.4 at 19632d4, TargetBot arena config)")
        local v14 = ("[tibia-probe] " .. v13)
        write_log_line_14(v14)
        local v15 = g_clock.millis()
        v4.l0 = v15
        local v16 = closure9({ v0, v1, v2, v3, v5, v4 })
        scheduleEvent(v16, 2500)
        return nil
    end
end

function closure12(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_12(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    end
end

function poll_12(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    local v10 = v0 == ""
    local getv12 = function()
        if v10 then
            return true
        else
            return file_exists_13(v0)
        end
    end
    local v12 = getv12()
    if v12 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v13 = typed_c4(nil)
        local v14 = function(message) (v13)(message) end
        local v15 = typed_c6({ v2, v3 })
        local v16 = function(mode, text) (v15)(mode)(text) end
        local v17 = ready_c8({ v4, v5, v6, v7, v8, v9 })
        connect(g_game, { onGameStart = v17, onLoginError = v14, onTextMessage = v16 })
        local v18 = "@god"
        local v19 = "@god\ngod"
        g_game.loginWorld(v18, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v19)
        return nil
    else
        local v20 = closure12({ v0, v1, v2, v3, v4, v5, v6, v7, v8, v9 })
        scheduleEvent(v20, 50)
        return nil
    end
end

function closure3(capt)
    local v0, v1, v2, v3, v4, v5, v6, v7, v8 = (table.unpack or unpack)(capt)
    return function(dom)
        local v9 = "TIBIA_LOGIN_GATE"
        local v10 = ""
        local v11 = env_text_8(v9, v10)
        return poll_12(v11, v0, v1, v2, v3, v4, v5, v6, v7, v8)
    end
end

function closure13(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(dom)
        local v1 = v0 ~= nil and v0.l0
        local v2 = v1 == 0
        if v2 then
            v0.l0 = 1
            local v3 = parity_summary_23()
            local v4 = v3 ~= ""
            if v4 then
                local v5 = ("[tibia-probe] " .. v3)
                write_log_line_14(v5)
            else
            end
            local v6 = "[tibia-probe] finish: timeout"
            write_log_line_14(v6)
            local v7 = g_game.isOnline()
            if v7 then
                g_game.safeLogout()
            else
            end
            local v8 = closure5(nil)
            scheduleEvent(v8, 2000)
            return nil
        else
        end
    end
end

local v0, v1, v2, v3 = (table.unpack or unpack)(instrument_0())
local v4 = { __tag = "Mut0", l0 = 0 }
local v5 = { __tag = "Mut0", l0 = 0 }
local v6 = "TIBIA_ARENA_CHARACTER"
local v7 = "Knight Sample"
local v8 = env_text_8(v6, v7)
local v9 = (v8 .. "_1511")
disable_client_bot_10(v9)
local v10 = env_text_8(v6, v7)
local v11 = "TIBIA_PROBE_HIDDEN"
local v12 = get_environment_variable_9(v11)
local v13 = v12 == "1"
if v13 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_11()
local v14 = closure2(nil)
scheduleEvent(v14, 200)
scheduleEvent(v14, 1000)
local v15 = closure3({ v10, v4, v5, v0, v1, v2, v3, v5, v4 })
scheduleEvent(v15, 3000)
local v16 = closure13({ v4 })
scheduleEvent(v16, 200000)
return 0
