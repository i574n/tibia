local closure0
function closure0(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = "/"
        local v3 = v2 == "" or v1:sub(1, #v2) == v2 
        local getv6 = function()
            if v3 then
                local v4 = ("/bot/nExBot" .. v1)
                return v4
            else
                local v5 = ("/bot/nExBot/" .. v1)
                return v5
            end
        end
        local v6 = getv6()
        local v7 = g_resources.fileExists(v6)
        if v7 then
            local v8 = g_resources.readFileContents(v6)
            local v9 = ("@" .. v6)
            local v10 = loadstring(v8, v9)
            local v11 = (v10) ~= nil
            if v11 then
                local v12 = setfenv ~= nil
                local getv14 = function()
                    if v12 then
                        local v13 = (v0) ~= nil
                        return v13
                    else
                        return false
                    end
                end
                local v14 = getv14()
                if v14 then
                    setfenv(v10, v0)
                else
                end
                local v15 = { (v10)() }
                return v15
            else
                local v16 = select(2, loadstring(v8, v9))
                error(v16, 3)
                local v17 = {}
                return v17
            end
        else
            local v19 = {}
            return v19
        end
    end
end

local v0 = dofile
local v1 = "/bot_env_probe.lua"
local v2 = (v0)(v1)
local v3 = closure0({ v2 })
dofile = function(path) return unpack((v3)(path)) end
local v4 = (v2) ~= nil
if v4 then
    local v5 = dofile
    local v6 = "dofile"
    do (v2)[v6] = v5 end
    return nil
else
end
