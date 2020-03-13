local b64          = require "ngx.base64"

local setmetatable = setmetatable
local tonumber     = tonumber
local concat       = table.concat

local filesession = {}
filesession.__index = filesession

function filesession.new(config)
    local self = {
        encode    = config.encoder.encode,
        decode    = config.encoder.decode,
        delimiter = '|',
        location  = "/tmp/"
    }
    return setmetatable(self, filesession)
end

function filesession:filename(id)
    return self.location .. b64.encode_base64url(id) .. ".dat"
end

function filesession:key(id)
    return self.encode(id)
end

function filesession:cookie(value)
    local result, delim = {}, self.delimiter
    local count, pos = 1, 1
    local match_start, match_end = value:find(delim, 1, true)
    while match_start do
        if count > 2 then
            return nil
        end
        result[count] = value:sub(pos, match_end - 1)
        count, pos = count + 1, match_end + 1
        match_start, match_end = value:find(delim, pos, true)
    end
    if count ~= 3 then
        return nil
    end
    result[3] = value:sub(pos)
    return result
end

function filesession:open(value, lifetime)
    local r = self:cookie(value)
    if r and r[1] and r[2] and r[3] then
        local id, expires, hash = self.decode(r[1]), tonumber(r[2]), self.decode(r[3])
        local file = io.open(self:filename(id), "r")
        if file then
            local text = file:read("*a")
            file:close()
            local data = text
            return id, expires, data, hash
        end
    end
    return nil, "invalid"
end

function filesession:start(id)
    return self
end

function filesession:save(id, expires, data, hash, close)
    local file, err = io.open(self:filename(id), "w")
    if file then
        file:write(data)
        file:flush()
        file:close()
        local key = self:key(id)
        return concat({ key, expires, self.encode(hash) }, self.delimiter)
    end
    return nil, err
end

function filesession:close()
    return true
end

function filesession:destroy(id)
    os.remove(self:filename(id))
    return true, nil
end

return filesession
