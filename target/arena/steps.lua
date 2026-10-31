local function spiral_wrap_signed(value, bits)
    local modulus = 2 ^ bits
    value = value % modulus
    if value >= modulus / 2 then value = value - modulus end
    return value
end
local Uh0_Cons, Mut0, Uh1_Cons, Mut1, Uh2_Cons, Mut2, Uh3_Cons, get_environment_variable_0, player_present_1, stamp_of_2, restamped_3, with_labeled_4, format_real_5, log_flush_7, write_log_line_6, closure2, closure1, closure0, on_position_change_8, env_text_9, mute_10, closure3, file_exists_12, closure6, typed_c5, closure8, typed_c7, live_monster_15, scan_14, diagonal_south_19, diagonal_step_18, south_or_west_step_17, step_16, walk_away_13, closure10, closure12, closure13, walk_leg_20, closure11, insert_by_label_22, method21, insert_sorted_25, method24, method26, nth_27, method23, method28, closure14, closure9, closure15, poll_11, closure4, closure16
Uh0_Nil = (function() local shared = { tag = "Uh0_Nil" } return function() return shared end end)()
function Uh0_Cons(v0, v1, v2, v3) return { tag = "Uh0_Cons",  _1 = v0,  _2 = v1,  _3 = v2,  _4 = v3 } end

Mut0 = function(l0) return { __tag = "Mut0", l0 = l0 } end

Uh1_Nil = (function() local shared = { tag = "Uh1_Nil" } return function() return shared end end)()
function Uh1_Cons(v0, v1, v2) return { tag = "Uh1_Cons",  _1 = v0,  _2 = v1,  _3 = v2 } end

Mut1 = function(l0) return { __tag = "Mut1", l0 = l0 } end

Uh2_Nil = (function() local shared = { tag = "Uh2_Nil" } return function() return shared end end)()
function Uh2_Cons(v0, v1) return { tag = "Uh2_Cons",  _1 = v0,  _2 = v1 } end

Mut2 = function(l0) return { __tag = "Mut2", l0 = l0 } end

Uh3_Nil = (function() local shared = { tag = "Uh3_Nil" } return function() return shared end end)()
function Uh3_Cons(v0, v1) return { tag = "Uh3_Cons",  _1 = v0,  _2 = v1 } end

function get_environment_variable_0(v0)
    local v1 = os.getenv(v0) or ""
    return v1
end

function player_present_1()
    local v0 = g_game.getLocalPlayer() ~= nil
    if v0 then
        local v1 = g_game.isOnline()
        return v1
    else
        return false
    end
end

function stamp_of_2(v0, v1)
    if v1 ~= nil and v1.tag == "Uh0_Cons" then
        local v3 = v1._1
        local v4 = v1._2
        local v5 = v1._3
        local v6 = v1._4
        local v7 = v3 == v0
        if v7 then
            return { [1]=v4, [2]=v5 }
        else
            return stamp_of_2(v0, v6)
        end
    elseif v1 ~= nil and v1.tag == "Uh0_Nil" then
        local v2 = ""
        return { [1]=-1, [2]=v2 }
    end
end

function restamped_3(v0, v1, v2, v3)
    if v3 ~= nil and v3.tag == "Uh0_Cons" then
        local v6 = v3._1
        local v7 = v3._2
        local v8 = v3._3
        local v9 = v3._4
        local v10 = v6 == v0
        if v10 then
            return Uh0_Cons(v0, v1, v2, v9)
        else
            local v12 = restamped_3(v0, v1, v2, v9)
            return Uh0_Cons(v6, v7, v8, v12)
        end
    elseif v3 ~= nil and v3.tag == "Uh0_Nil" then
        local v4 = Uh0_Nil()
        return Uh0_Cons(v0, v1, v2, v4)
    end
end

function with_labeled_4(v0, v1, v2)
    if v2 ~= nil and v2.tag == "Uh1_Cons" then
        local v7 = v2._1
        local v8 = v2._2
        local v9 = v2._3
        local v10 = v7 == v0
        if v10 then
            local v11 = Uh2_Cons(v1, v8)
            return Uh1_Cons(v7, v11, v9)
        else
            local v13 = with_labeled_4(v0, v1, v9)
            return Uh1_Cons(v7, v8, v13)
        end
    elseif v2 ~= nil and v2.tag == "Uh1_Nil" then
        local v3 = Uh2_Nil()
        local v4 = Uh2_Cons(v1, v3)
        local v5 = Uh1_Nil()
        return Uh1_Cons(v0, v4, v5)
    end
end

function format_real_5(v0)
    local v1 = ""
    local v2 = { __tag = "Mut2", l0 = v1 }
    local v3 = tostring(v0)       
    local v4 = v2 ~= nil and v2.l0
    local v5 = v4 .. v3 
    v2.l0 = v5
    local v6 = v2 ~= nil and v2.l0
    return v6
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
            local v9 = v4.x
            local v10 = v4.y
            local v11 = v4.z
            local v12 = v5.x
            local v13 = v5.y
            local v14 = v5.z
            local v15 = (v3):isLocalPlayer()
            local v16 = (v3):isMonster()
            local v17 = (v16) or (v15)
            local getv34 = function()
                if v17 then
                    local v18 = v9 > v12
                    local getv21 = function()
                        if v18 then
                            local v19 = spiral_wrap_signed((v9 - v12), 32)
                            return v19
                        else
                            local v20 = spiral_wrap_signed((v12 - v9), 32)
                            return v20
                        end
                    end
                    local v21 = getv21()
                    local v22 = v10 > v13
                    local getv25 = function()
                        if v22 then
                            local v23 = spiral_wrap_signed((v10 - v13), 32)
                            return v23
                        else
                            local v24 = spiral_wrap_signed((v13 - v10), 32)
                            return v24
                        end
                    end
                    local v25 = getv25()
                    local v26 = v11 == v14
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
                    if v31 then
                        local v32 = v25 <= 1
                        return v32
                    else
                        return false
                    end
                else
                    return false
                end
            end
            local v34 = getv34()
            if v34 then
                local v35 = g_clock.millis()
                local v36 = (v3):getId()
                local v37 = v9 > v12
                local getv40 = function()
                    if v37 then
                        local v38 = spiral_wrap_signed((v9 - v12), 32)
                        return v38
                    else
                        local v39 = spiral_wrap_signed((v12 - v9), 32)
                        return v39
                    end
                end
                local v40 = getv40()
                local v41 = v40 == 1
                local getv47 = function()
                    if v41 then
                        local v42 = v10 > v13
                        local getv45 = function()
                            if v42 then
                                local v43 = spiral_wrap_signed((v10 - v13), 32)
                                return v43
                            else
                                local v44 = spiral_wrap_signed((v13 - v10), 32)
                                return v44
                            end
                        end
                        local v45 = getv45()
                        local v46 = v45 == 1
                        return v46
                    else
                        return false
                    end
                end
                local v47 = getv47()
                local v48 = player_present_1()
                local getv64 = function()
                    if v48 then
                        local v49 = g_game.getLocalPlayer():getPosition()
                        local v50 = v49.x
                        local v51 = v49.y
                        local v52 = v49.z
                        local v53 = v9 > v50
                        local getv56 = function()
                            if v53 then
                                local v54 = spiral_wrap_signed((v9 - v50), 32)
                                return v54
                            else
                                local v55 = spiral_wrap_signed((v50 - v9), 32)
                                return v55
                            end
                        end
                        local v56 = getv56()
                        local v57 = v10 > v51
                        local getv60 = function()
                            if v57 then
                                local v58 = spiral_wrap_signed((v10 - v51), 32)
                                return v58
                            else
                                local v59 = spiral_wrap_signed((v51 - v10), 32)
                                return v59
                            end
                        end
                        local v60 = getv60()
                        local v61 = v56 > v60
                        local getv62 = function()
                            if v61 then
                                return v56
                            else
                                return v60
                            end
                        end
                        local v62 = getv62()
                        local v63 = v62 <= 1
                        return v63
                    else
                        return false
                    end
                end
                local v64 = getv64()
                local getv67 = function()
                    if v15 then
                        local v65 = "knight-"
                        return v65
                    else
                        local v66 = ""
                        return v66
                    end
                end
                local v67 = getv67()
                local getv70 = function()
                    if v47 then
                        local v68 = "diagonal"
                        return v68
                    else
                        local v69 = "straight"
                        return v69
                    end
                end
                local v70 = getv70()
                local v71 = v67 .. v70 
                local getv73 = function()
                    if v0 then
                        local v72 = v15 == false
                        return v72
                    else
                        return false
                    end
                end
                local v73 = getv73()
                local getv78 = function()
                    if v73 then
                        local getv76 = function()
                            if v64 then
                                local v74 = "-adjacent"
                                return v74
                            else
                                local v75 = "-chasing"
                                return v75
                            end
                        end
                        local v76 = getv76()
                        local v77 = v71 .. v76 
                        return v77
                    else
                        return v71
                    end
                end
                local v78 = getv78()
                local v79 = v1 ~= nil and v1.l0
                local v80, v81 = (table.unpack or unpack)(stamp_of_2(v36, v79))
                local v82 = v1 ~= nil and v1.l0
                local v83 = restamped_3(v36, v35, v78, v82)
                v1.l0 = v83
                local v84 = v80 >= 0
                if v84 then
                    local v85 = spiral_wrap_signed((v35 - v80), 32)
                    local v86 = v2 ~= nil and v2.l0
                    local v87 = with_labeled_4(v81, v85, v86)
                    v2.l0 = v87
                    local v88 = (v3):getName()
                    local v89 = format_real_5(v12)
                    local v90 = ""
                    local v91 = v90 .. v89 
                    local v92 = ","
                    local v93 = v91 .. v92 
                    local v94 = format_real_5(v13)
                    local v95 = v93 .. v94 
                    local v96 = v95 .. v92 
                    local v97 = format_real_5(v14)
                    local v98 = v96 .. v97 
                    local v99 = format_real_5(v9)
                    local v100 = v90 .. v99 
                    local v101 = v100 .. v92 
                    local v102 = format_real_5(v10)
                    local v103 = v101 .. v102 
                    local v104 = v103 .. v92 
                    local v105 = format_real_5(v11)
                    local v106 = v104 .. v105 
                    local v107 = " "
                    local v108 = v88 .. v107 
                    local v109 = format_real_5(v36)
                    local v110 = v108 .. v109 
                    local v111 = v110 .. v107 
                    local v112 = v111 .. v78 
                    local v113 = " step "
                    local v114 = v112 .. v113 
                    local v115 = v114 .. v98 
                    local v116 = " -> "
                    local v117 = v115 .. v116 
                    local v118 = v117 .. v106 
                    local v119 = "; interval after its "
                    local v120 = v118 .. v119 
                    local v121 = v120 .. v81 
                    local v122 = v121 .. v113 
                    local v123 = format_real_5(v85)
                    local v124 = v122 .. v123 
                    local v125 = " ms"
                    local v126 = v124 .. v125 
                    local v127 = "[tibia-probe] "
                    local v128 = v127 .. v126 
                    return write_log_line_6(v128)
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

function on_position_change_8(v0)
    local v1 = function(c, n, o) (v0)(c)(n)(o) end
    connect(Creature, { onPositionChange = v1 })
    connect(LocalPlayer, { onPositionChange = v1 })
    return nil
end

function env_text_9(v0, v1)
    local v2 = get_environment_variable_0(v0)
    local v3 = v2 == ""
    if v3 then
        return v1
    else
        return v2
    end
end

function mute_10()
    g_settings.set("enableAudio", false)
    local v0 = g_sounds ~= nil
    if v0 then
        g_sounds.setAudioEnabled(false)
        g_sounds.stopAll()
        return nil
    else
    end
end

function closure3(capt)
    return function(dom)
        local v0 = "TIBIA_PROBE_HIDDEN"
        local v1 = get_environment_variable_0(v0)
        local v2 = v1 == "1"
        if v2 then
            g_window.move({ x = -32000, y = -32000 })
            g_window.hide()
        else
        end
        return mute_10()
    end
end

function file_exists_12(v0)
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

function closure6(capt)
    return function(dom)
        g_app.exit()
        return nil
    end
end

function typed_c5(capt)
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
        local v11 = closure6(nil)
        scheduleEvent(v11, 2000)
        return nil
    end
end

function closure8(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = tostring(v0)
        local v3 = tostring(v1)
        local v4 = "server text ["
        local v5 = v4 .. v2 
        local v6 = "]: "
        local v7 = v5 .. v6 
        local v8 = v7 .. v3 
        local v9 = "[tibia-probe] "
        local v10 = v9 .. v8 
        return write_log_line_6(v10)
    end
end

function typed_c7(capt)
    return function(v0)
        return closure8({ v0 })
    end
end

function live_monster_15(v0)
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

function scan_14(v0, v1, v2, v3, v4, v5, v6, v7, v8)
    local v9 = v5 > v4
    local getv37 = function()
        if v9 then
            return { [1]=v6, [2]=v7, [3]=v8 }
        else
            local v10 = spiral_wrap_signed((v5 + 1), 32)
            local v11 = (v3)[v5]
            local v12 = live_monster_15(v11)
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
            local v34, v35, v36 = (table.unpack or unpack)(scan_14(v0, v1, v2, v3, v4, v10, v31, v32, v33))
            return { [1]=v34, [2]=v35, [3]=v36 }
        end
    end
    local v37, v38, v39 = (table.unpack or unpack)(getv37())
    return { [1]=v37, [2]=v38, [3]=v39 }
end

function diagonal_south_19(v0, v1)
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

function diagonal_step_18(v0, v1)
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
            return diagonal_south_19(v0, v1)
        end
    end
end

function south_or_west_step_17(v0, v1)
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
            return diagonal_step_18(v0, v1)
        end
    end
end

function step_16(v0, v1)
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
            return south_or_west_step_17(v0, v1)
        end
    end
end

function walk_away_13()
    local v0 = player_present_1()
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
        local v11, v12, v13 = (table.unpack or unpack)(scan_14(v2, v3, v4, v5, v6, v7, v8, v9, v10))
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
                local v37 = step_16(v28, v33)
            else
            end
        else
        end
        local v38 = closure10(nil)
        scheduleEvent(v38, 1300)
        return nil
    else
    end
end

function closure10(capt)
    return function(dom)
        return walk_away_13()
    end
end

function closure12(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = spiral_wrap_signed((v2 + 1), 32)
        return walk_leg_20(v0, v1, v3)
    end
end

function closure13(capt)
    local v0, v1 = (table.unpack or unpack)(capt)
    return function(dom)
        local v2 = spiral_wrap_signed((v1 - 1), 32)
        local v3 = 0
        return walk_leg_20(v0, v2, v3)
    end
end

function walk_leg_20(v0, v1, v2)
    local v3 = player_present_1()
    local v4 = v3 == false
    if v4 then
        local v5 = "[tibia-probe] "
        local v6 = "knight walk stopped: no player in game"
        local v7 = v5 .. v6 
        return write_log_line_6(v7)
    else
        local v8 = g_game.getLocalPlayer():isWalking()
        if v8 then
            local v9 = math.fmod(v2, 40)
            local v10 = v9 == 39
            if v10 then
                local v11 = g_game.getLocalPlayer():getPosition()
                local v12 = v11.x
                local v13 = v11.y
                local v14 = v11.z
                local v15 = format_real_5(v12)
                local v16 = ""
                local v17 = v16 .. v15 
                local v18 = ","
                local v19 = v17 .. v18 
                local v20 = format_real_5(v13)
                local v21 = v19 .. v20 
                local v22 = v21 .. v18 
                local v23 = format_real_5(v14)
                local v24 = v22 .. v23 
                local v25 = "knight walk still walking at "
                local v26 = v25 .. v24 
                local v27 = " after "
                local v28 = v26 .. v27 
                local v29 = spiral_wrap_signed((v2 + 1), 32)
                local v30 = format_real_5(v29)
                local v31 = v28 .. v30 
                local v32 = " polls"
                local v33 = v31 .. v32 
                local v34 = "[tibia-probe] "
                local v35 = v34 .. v33 
                write_log_line_6(v35)
            else
            end
            local v36 = closure12({ v0, v1, v2 })
            scheduleEvent(v36, 50)
            return nil
        else
            local v37 = v1 == 0
            if v37 then
                local v38 = spiral_wrap_signed(-(v0), 32)
                local v39 = 5
                local v40 = 0
                return walk_leg_20(v38, v39, v40)
            else
                local v41 = 0
                local v42 = step_16(v0, v41)
                local v43 = v42 == false
                if v43 then
                    local v44 = format_real_5(v0)
                    local v45 = "knight walk step "
                    local v46 = v45 .. v44 
                    local v47 = " refused at "
                    local v48 = v46 .. v47 
                    local v49 = g_game.getLocalPlayer():getPosition()
                    local v50 = v49.x
                    local v51 = v49.y
                    local v52 = v49.z
                    local v53 = format_real_5(v50)
                    local v54 = ""
                    local v55 = v54 .. v53 
                    local v56 = ","
                    local v57 = v55 .. v56 
                    local v58 = format_real_5(v51)
                    local v59 = v57 .. v58 
                    local v60 = v59 .. v56 
                    local v61 = format_real_5(v52)
                    local v62 = v60 .. v61 
                    local v63 = v48 .. v62 
                    local v64 = "[tibia-probe] "
                    local v65 = v64 .. v63 
                    write_log_line_6(v65)
                else
                end
                local v66 = closure13({ v0, v1 })
                scheduleEvent(v66, 50)
                return nil
            end
        end
    end
end

function closure11(capt)
    return function(dom)
        local v0 = g_game.getLocalPlayer():getPosition() ~= nil
        local getv16 = function()
            if v0 then
                local v1 = g_game.getLocalPlayer():getPosition()
                local v2 = v1.x
                local v3 = v1.y
                local v4 = v1.z
                local v5 = format_real_5(v2)
                local v6 = ""
                local v7 = v6 .. v5 
                local v8 = ","
                local v9 = v7 .. v8 
                local v10 = format_real_5(v3)
                local v11 = v9 .. v10 
                local v12 = v11 .. v8 
                local v13 = format_real_5(v4)
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
        local v25 = g_game.getLocalPlayer():getSpeed()
        local v26 = tostring(v25)
        local v27 = v24 .. v26 
        local v28 = " walking "
        local v29 = v27 .. v28 
        local v30 = v29 .. v20 
        local v31 = "[tibia-probe] "
        local v32 = v31 .. v30 
        write_log_line_6(v32)
        local v33 = -1
        local v34 = 5
        local v35 = 0
        return walk_leg_20(v33, v34, v35)
    end
end

function insert_by_label_22(v0, v1, v2)
    if v2 ~= nil and v2.tag == "Uh1_Cons" then
        local v5 = v2._1
        local v6 = v2._2
        local v7 = v2._3
        local v8 = v0 < v5
        local getv11 = function()
            if v8 then
                return -1
            else
                local v9 = v0 > v5
                if v9 then
                    return 1
                else
                    return 0
                end
            end
        end
        local v11 = getv11()
        local v12 = v11 == -1
        if v12 then
            return Uh1_Cons(v0, v1, v2)
        else
            local v14 = insert_by_label_22(v0, v1, v7)
            return Uh1_Cons(v5, v6, v14)
        end
    elseif v2 ~= nil and v2.tag == "Uh1_Nil" then
        local v3 = Uh1_Nil()
        return Uh1_Cons(v0, v1, v3)
    end
end

function method21(v0, v1)
    if v0 ~= nil and v0.tag == "Uh1_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = insert_by_label_22(v2, v3, v1)
        return method21(v4, v5)
    elseif v0 ~= nil and v0.tag == "Uh1_Nil" then
        return v1
    end
end

function insert_sorted_25(v0, v1)
    if v1 ~= nil and v1.tag == "Uh2_Cons" then
        local v4 = v1._1
        local v5 = v1._2
        local v6 = v0 <= v4
        if v6 then
            return Uh2_Cons(v0, v1)
        else
            local v8 = insert_sorted_25(v0, v5)
            return Uh2_Cons(v4, v8)
        end
    elseif v1 ~= nil and v1.tag == "Uh2_Nil" then
        local v2 = Uh2_Nil()
        return Uh2_Cons(v0, v2)
    end
end

function method24(v0, v1)
    if v0 ~= nil and v0.tag == "Uh2_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = insert_sorted_25(v2, v1)
        return method24(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh2_Nil" then
        return v1
    end
end

function method26(v0, v1)
    if v0 ~= nil and v0.tag == "Uh2_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = spiral_wrap_signed((v1 + 1), 32)
        return method26(v3, v4)
    elseif v0 ~= nil and v0.tag == "Uh2_Nil" then
        return v1
    end
end

function nth_27(v0, v1)
    if v1 ~= nil and v1.tag == "Uh2_Cons" then
        local v2 = v1._1
        local v3 = v1._2
        local v4 = v0 == 0
        if v4 then
            return v2
        else
            local v5 = spiral_wrap_signed((v0 - 1), 32)
            return nth_27(v5, v3)
        end
    elseif v1 ~= nil and v1.tag == "Uh2_Nil" then
        return 0
    end
end

function method23(v0, v1)
    if v0 ~= nil and v0.tag == "Uh1_Cons" then
        local v2 = v0._1
        local v3 = v0._2
        local v4 = v0._3
        local v5 = method23(v4, v1)
        local v6 = Uh2_Nil()
        local v7 = method24(v3, v6)
        local v8 = 0
        local v9 = method26(v3, v8)
        local v10 = " n="
        local v11 = v2 .. v10 
        local v12 = format_real_5(v9)
        local v13 = v11 .. v12 
        local v14 = " median "
        local v15 = v13 .. v14 
        local v16 = spiral_wrap_signed((v9 + 1), 32)
        local v17 = (math.modf(v16 / 2))
        local v18 = spiral_wrap_signed((v17 - 1), 32)
        local v19 = nth_27(v18, v7)
        local v20 = format_real_5(v19)
        local v21 = v15 .. v20 
        local v22 = 0
        local v23 = nth_27(v22, v7)
        local v24 = format_real_5(v23)
        local v25 = " min "
        local v26 = v25 .. v24 
        local v27 = " max "
        local v28 = v26 .. v27 
        local v29 = spiral_wrap_signed((v9 - 1), 32)
        local v30 = nth_27(v29, v7)
        local v31 = format_real_5(v30)
        local v32 = v28 .. v31 
        local v33 = v21 .. v32 
        return Uh3_Cons(v33, v5)
    elseif v0 ~= nil and v0.tag == "Uh1_Nil" then
        return v1
    end
end

function method28(v0, v1, v2)
    local getv12 = function()
        if v0 ~= nil and v0.tag == "Uh3_Cons" then
            local v3 = v0._1
            local v4 = v0._2
            local v5, v6 = (table.unpack or unpack)(method28(v4, v1, v2))
            local v7 = v3 .. v6 
            local v8 = v7 .. v5 
            local v9 = "; "
            return { [1]=v8, [2]=v9 }
        else
            local getv10 = function()
                if v0 ~= nil and v0.tag == "Uh3_Nil" then
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

function closure14(capt)
    local v0, v1, v2 = (table.unpack or unpack)(capt)
    return function(dom)
        local v3 = v2 ~= nil and v2.l0
        local v4 = Uh1_Nil()
        local v5 = method21(v3, v4)
        local v6 = Uh3_Nil()
        local v7 = method23(v5, v6)
        local v8 = ""
        local v9, v10 = (table.unpack or unpack)(method28(v7, v8, v8))
        local v11 = "end: "
        local v12 = v11 .. v9 
        local v13 = "[tibia-probe] "
        local v14 = v13 .. v12 
        write_log_line_6(v14)
        local v15 = "finish: "
        local v16 = "steps measured"
        local v17 = v15 .. v16 
        local v18 = v13 .. v17 
        write_log_line_6(v18)
        local v19 = g_game.isOnline()
        if v19 then
            g_game.safeLogout()
        else
        end
        local v20 = closure6(nil)
        scheduleEvent(v20, 2000)
        return nil
    end
end

function closure9(capt)
    local v0, v1, v2, v3 = (table.unpack or unpack)(capt)
    return function(dom)
        local v4 = g_game.getLocalPlayer():getName()
        local v5 = g_game.getLocalPlayer():getPosition() ~= nil
        local getv21 = function()
            if v5 then
                local v6 = g_game.getLocalPlayer():getPosition()
                local v7 = v6.x
                local v8 = v6.y
                local v9 = v6.z
                local v10 = format_real_5(v7)
                local v11 = ""
                local v12 = v11 .. v10 
                local v13 = ","
                local v14 = v12 .. v13 
                local v15 = format_real_5(v8)
                local v16 = v14 .. v15 
                local v17 = v16 .. v13 
                local v18 = format_real_5(v9)
                local v19 = v17 .. v18 
                return v19
            else
                local v20 = "nil"
                return v20
            end
        end
        local v21 = getv21()
        local v22 = "in game as "
        local v23 = v22 .. v4 
        local v24 = " at "
        local v25 = v23 .. v24 
        local v26 = v25 .. v21 
        local v27 = " speed "
        local v28 = v26 .. v27 
        local v29 = g_game.getLocalPlayer():getSpeed()
        local v30 = tostring(v29)
        local v31 = v28 .. v30 
        local v32 = "[tibia-probe] "
        local v33 = v32 .. v31 
        write_log_line_6(v33)
        if v1 then
            local v34 = closure10(nil)
            scheduleEvent(v34, 2000)
        else
        end
        if v0 then
            local v35 = closure11(nil)
            scheduleEvent(v35, 2000)
        else
        end
        local v36 = closure14({ v1, v2, v3 })
        scheduleEvent(v36, 45000)
        return nil
    end
end

function closure15(capt)
    local v0, v1, v2, v3, v4, v5 = (table.unpack or unpack)(capt)
    return function(dom)
        return poll_11(v0, v1, v2, v3, v4, v5)
    end
end

function poll_11(v0, v1, v2, v3, v4, v5)
    local v6 = v0 == ""
    local getv8 = function()
        if v6 then
            return true
        else
            return file_exists_12(v0)
        end
    end
    local v8 = getv8()
    if v8 then
        g_game.setClientVersion(1511)
        g_game.setProtocolVersion(g_game.getClientProtocolVersion(1511))
        g_game.chooseRsa("127.0.0.1")
        local v9 = typed_c5(nil)
        local v10 = function(message) (v9)(message) end
        local v11 = typed_c7(nil)
        local v12 = function(mode, text) (v11)(mode)(text) end
        local v13 = closure9({ v2, v3, v4, v5 })
        connect(g_game, { onGameStart = v13, onLoginError = v10, onTextMessage = v12 })
        local v14 = "@god"
        local v15 = "@god\ngod"
        g_game.loginWorld(v14, "god", "OTServBR-Global", "127.0.0.1", 7172, v1, "", v15)
        return nil
    else
        local v16 = closure15({ v0, v1, v2, v3, v4, v5 })
        scheduleEvent(v16, 50)
        return nil
    end
end

function closure4(capt)
    local v0, v1, v2, v3, v4 = (table.unpack or unpack)(capt)
    return function(dom)
        local v5 = "TIBIA_LOGIN_GATE"
        local v6 = ""
        local v7 = env_text_9(v5, v6)
        return poll_11(v7, v0, v1, v2, v3, v4)
    end
end

function closure16(capt)
    return function(dom)
        local v0 = "finish: "
        local v1 = "timeout"
        local v2 = v0 .. v1 
        local v3 = "[tibia-probe] "
        local v4 = v3 .. v2 
        write_log_line_6(v4)
        local v5 = g_game.isOnline()
        if v5 then
            g_game.safeLogout()
        else
        end
        local v6 = closure6(nil)
        scheduleEvent(v6, 2000)
        return nil
    end
end

local v0 = "TIBIA_STEPS_CHASE"
local v1 = get_environment_variable_0(v0)
local v2 = v1 == "1"
local v3 = "TIBIA_STEPS_KNIGHT_WALK"
local v4 = get_environment_variable_0(v3)
local v5 = v4 == "1"
local v6 = Uh0_Nil()
local v7 = { __tag = "Mut0", l0 = v6 }
local v8 = Uh1_Nil()
local v9 = { __tag = "Mut1", l0 = v8 }
local v10 = closure0({ v2, v7, v9 })
on_position_change_8(v10)
local v11 = "TIBIA_ARENA_CHARACTER"
local v12 = "Knight Sample"
local v13 = env_text_9(v11, v12)
local v14 = "TIBIA_PROBE_HIDDEN"
local v15 = get_environment_variable_0(v14)
local v16 = v15 == "1"
if v16 then
    g_window.move({ x = -32000, y = -32000 })
    g_window.hide()
else
end
mute_10()
local v17 = closure3(nil)
scheduleEvent(v17, 200)
scheduleEvent(v17, 1000)
local v18 = closure4({ v13, v5, v2, v7, v9 })
scheduleEvent(v18, 3000)
local v19 = closure16(nil)
scheduleEvent(v19, 90000)
return 0
