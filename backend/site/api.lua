local json = require "cjson"
local router = require "router"
local auth = require "api.session"
local img = require "api.image"
local util = require "util"

local r = router.new()

r:match({
    GET = {
        ["/api/menu"] = function(params)
            if auth:check() then
                util.result(CFG.menu)
            else
                auth:validate()
            end
        end,

        ["/api/session"] = function(params)
            ngx.header["content-type"] = 'application/json'
            auth:validate()
        end,

        ["/api/image"] = function(params)
            if auth:check() then
                img.get()
            else
                auth:validate()
            end
        end
    },

    POST = {
        ["/api/session"] = function(params)
            ngx.header["content-type"] = 'application/json'
            ngx.req.read_body()
            local req = json.decode(ngx.req.get_body_data())
            auth:login(req['username'], req['password'])
        end
    },

    DELETE = {
        ["/api/session"] = function(params)
            ngx.header["content-type"] = 'application/json'
            auth:logout()
        end
    }
})

local ok = r:execute(
    ngx.var.request_method,
    ngx.var.request_uri,
    ngx.req.get_uri_args()
)

if not ok then util.fail(400, "Bad request") end
