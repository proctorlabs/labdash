local json = require "cjson"
local M = {}
 
local function login(self, username, password)
      local ld = lualdap.open_simple(
            self.uri,
            self.search_attr .. "=" .. username .. "," .. self.base_dn,
            password
      )
      if ld == nil then
            ngx.status = 401
            ngx.exit(ngx.HTTP_UNAUTHORIZED)
      else
            ld:close()
            self.session.data.user = username
            self.session:save()
      end
end

local function validate(self)
      if self.session.present and self.session.data.user then
            ngx.print(json.encode(self.session.data))
      else
            ngx.status = 401
            ngx.exit(ngx.HTTP_UNAUTHORIZED)
      end
end

local function logout(self)
      if self.session.present then
            self.session:destroy()
      end
end

local function init(self, config)
      local cfg = json.decode(config)
      self.uri = cfg['uri']
      self.base_dn = cfg['base_dn']
      self.search_attr = cfg['search_attr']
      self.session = require "resty.session".start{ secret = cfg['secret'] }
end

M.init = init
M.login = login
M.validate = validate
M.logout = logout
return M
