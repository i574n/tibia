do
  local nativeDofile = dofile
  local moduleEnv = nativeDofile("/bot_env_probe.lua")
  local botRoot = "/bot/nExBot"
  local function resolve(path)
    if path:sub(1, 1) == "/" then return botRoot .. path end
    return botRoot .. "/" .. path
  end
  dofile = function(path)
    local full = resolve(path)
    if nexbotTrace then nexbotTrace("nested " .. full) end
    if not g_resources.fileExists(full) then
      if nexbotTrace then nexbotTrace("nested missing " .. full) end
      return nil
    end
    local source = g_resources.readFileContents(full)
    local chunk, err = loadstring(source, "@" .. full)
    if not chunk then error(err, 2) end
    if setfenv and moduleEnv then setfenv(chunk, moduleEnv) end
    local results = {chunk()}
    if nexbotTrace then nexbotTrace("nested done " .. full) end
    return unpack(results)
  end
  if moduleEnv then moduleEnv.dofile = dofile end
end