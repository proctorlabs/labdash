local auth = require "api.session"

local function default()
    ngx.exec("/")
end

if auth:check() then
    local site = CFG.menu.items[ngx.var['site']]
    if not site then
        default()
    elseif site.type == "wrap" then
        ngx.var['resource_host'] = site.host
        ngx.var['resource_url'] = site.scheme .. '://' .. site.host .. "/"
        ngx.var['resource_scheme'] = site.scheme
        ngx.exec("@wrap_resource")
    elseif site.type == "url" then
        ngx.status = 302
        ngx.header['Location'] = site.url
    else
        default()
    end
else
    auth:validate()
end
