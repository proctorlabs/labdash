local json = require "cjson"

local util = {}
util.__index = util

function util.fail(status, msg)
    ngx.header["content-type"] = 'application/json'
    ngx.status = status
    ngx.print(json.encode({
        status = status,
        error = msg
    }))
end

function util.result(data)
    ngx.header["content-type"] = 'application/json'
    ngx.status = 200
    ngx.print(json.encode(data))
end

function util.split (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

return util
