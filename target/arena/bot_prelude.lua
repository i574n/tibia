local closure0, closure1, closure2
function closure0(capt)
    return function(dom)
        return 0
    end
end

function closure1(capt)
    return function(dom)
        return nil
    end
end

function closure2(capt)
    return function(v0)
        local v1 = dofile
        local v2 = (v1)(v0)
        return v2
    end
end

local v0 = {}
local v1 = "get"
local v2 = closure0(nil)
do (v0)[v1] = v2 end
local v3 = "post"
do (v0)[v3] = v2 end
local v4 = "download"
do (v0)[v4] = v2 end
local v5 = "ws"
do (v0)[v5] = v2 end
local v6 = "cancel"
local v7 = closure1(nil)
do (v0)[v6] = v7 end
g_http = v0
local v8 = {}
do (v8)[v1] = v2 end
local v9 = "getJSON"
do (v8)[v9] = v2 end
do (v8)[v3] = v2 end
local v10 = "postJSON"
do (v8)[v10] = v2 end
do (v8)[v4] = v2 end
do (v8)[v6] = v7 end
HTTP = v8
local v11 = closure2(nil)
SpiralBotDofile = v11
return nil
