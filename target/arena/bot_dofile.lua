local closure0
function closure0(capt)
    local v0 = (table.unpack or unpack)(capt)
    return function(v1)
        local v2 = "/"
        local v3 = v2 == "" or v1:sub(1, #v2) == v2 
        local getv9 = function()
            if v3 then
                local v4 = "/bot/nExBot"
                local v5 = v4 .. v1 
                return v5
            else
                local v6 = "/bot/nExBot"
                local v7 = v6 .. v2 
                local v8 = v7 .. v1 
                return v8
            end
        end
        local v9 = getv9()
        local v10 = g_resources.fileExists(v9)
        if v10 then
            local v11 = g_resources.readFileContents(v9)
            local v12 = "@"
            local v13 = v12 .. v9 
            local v14 = loadstring(v11, v13)
            local v15 = (v14) ~= nil
            if v15 then
                local v16 = setfenv ~= nil
                local getv18 = function()
                    if v16 then
                        local v17 = (v0) ~= nil
                        return v17
                    else
                        return false
                    end
                end
                local v18 = getv18()
                if v18 then
                    setfenv(v14, v0)
                else
                end
                local v19 = { (v14)() }
                return v19
            else
                local v20 = select(2, loadstring(v11, v13))
                error(v20, 3)
                local v21 = {}
                return v21
            end
        else
            local v23 = {}
            return v23
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
