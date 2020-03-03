local json = require "cjson"
local template = require "resty.template"
local router = require 'router'
local r = router.new()

local dashboard = ngx.shared.dashboard
local content_root = dashboard:get("content_root")
local val = {
    some_value = 12,
    other_val = "string"
}

r:match({
    GET = {
        ["/"] = function(params)
            local links = json.decode(dashboard:get("links"))
            template.render("/index.html", { message = links })
        end,
        ["/api/links"] = function(params) 
            ngx.print(dashboard:get("links"))
        end
    }
})

local ok, errmsg = r:execute(
    ngx.var.request_method,
    ngx.var.request_uri,
    ngx.req.get_uri_args()
)

if not ok then
    ngx.exec("@fallback")
end
