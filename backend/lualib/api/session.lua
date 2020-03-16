local sessions = require "resty.session"
local util = require "util"

local session = {}
session.__index = session

local function new()
    local s = sessions.new(CFG.session_config)
    s.storage = require "plugins/filestore".new(s)
    return s
end

function session:login(username, password)
    if (ngx.shared.shmem:get("loginuname:" .. username) or
        ngx.shared.shmem:get("loginip:" .. ngx.var.remote_addr)) then
        ngx.sleep(3)
        return util.fail(429, "Try again later")
    end

    ngx.shared.shmem:set("loginuname:" .. username, 1, 10)
    ngx.shared.shmem:set("loginip:" .. ngx.var.remote_addr, 1, 10)
    ngx.sleep(0.2)
    local ld = lualdap.open_simple(
        CFG.ldap.uri,
        CFG.ldap.search_attr .. "=" .. username .. "," .. CFG.ldap.base_dn,
        password
    )

    if ld == nil then
        util.fail(401, "Authentication failed")
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
        util.result(s.data)
        return true
    else
        util.fail(403, "Authorization required")
        return false
    end
end

function session:logout()
    local s = new():open()
    if s.present then
        s:destroy()
    end
end

return session
