local auth = require "api.session"

if not auth:check() then
    ngx.exit(403)
end
