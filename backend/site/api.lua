local json = require "cjson"
local router = require "router"
local auth = require "api.session"
local img = require "api.image"
local r = router.new()

r:match({
    GET = {
        ["/api/menu"] = function(params)
            ngx.header["content-type"] = 'application/json'
            ngx.print(json.encode(labdash.menu))
        end,

        ["/api/session"] = function(params)
            ngx.header["content-type"] = 'application/json'
            auth:validate()
        end,

        ["/api/image"] = function(params)
            ngx.header["content-type"] = 'text/plain'
            img.get()
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

local ok, errmsg = r:execute(
    ngx.var.request_method,
    ngx.var.request_uri,
    ngx.req.get_uri_args()
)

if not ok then
    ngx.header["content-type"] = 'application/json'
    ngx.status = 400
    ngx.print("{\"error\": \"Bad request\"}")
end
