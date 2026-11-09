local v0 = getfenv ~= nil
if v0 then
    local v1 = getfenv(1)
    return v1
else
    local v2 = _G
    return v2
end
