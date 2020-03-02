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
        ["/hello"]       = function(params) ngx.print("someone said hello") end,
        ["/hello/:name"] = function(params) ngx.print("hello, " .. params.name) end,
        ["/hello2"]      = function(params) ngx.print(json.encode(val)) end
    },
    POST = {
        ["/app/:id/comments"] = function(params)
            ngx.print("comment " .. params.comment .. " created on app " .. params.id)
        end
    }
})

local ok, errmsg = r:execute(
    ngx.var.request_method,
    ngx.var.request_uri,
    ngx.req.get_uri_args()
)

if not ok then
    if ngx.var.request_uri:match("[.]html$") then
        ngx.exec("@404")
    else
        ngx.exec("@fallback")
    end
end
