local function silentRequest() return 0 end
g_http = { get = silentRequest, post = silentRequest, download = silentRequest, ws = silentRequest, cancel = function() end }
HTTP = { get = silentRequest, getJSON = silentRequest, post = silentRequest, postJSON = silentRequest, download = silentRequest, cancel = function() end }
if g_platform and g_platform.openUrl then g_platform.openUrl = function() return false end end