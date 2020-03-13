local json = require "cjson"
local sessions = require "resty.session"

local session = {}
session.__index = session

local function new()
    local s = sessions.new(labdash.session_config)
    s.storage = require "plugins/filestore".new(s)
    return s
end

function session:login(username, password)
    local ld = lualdap.open_simple(
        labdash.ldap.uri,
        labdash.ldap.search_attr .. "=" .. username .. "," .. labdash.ldap.base_dn,
        password
    )

    if ld == nil then
        ngx.status = 401
        ngx.print("{\"error\": \"Authentication failed\"}")
    else
        ld:close()
        local s = new():start()
        s.data.user = username
        s:save()
    end
end

function session:check()
    local s = new():open()
    if s.present and s.data.user then
        return true
    else
        return false
    end
end

function session:validate()
    local s = new():open()
    if s.present and s.data.user then
        s:regenerate()
        ngx.print(json.encode(s.data))
    else
        ngx.status = 403
        ngx.print("{\"error\": \"No active session\"}")
    end
end

function session:logout()
    local s = new():open()
    if s.present then
        s:destroy()
    end
end

return session
