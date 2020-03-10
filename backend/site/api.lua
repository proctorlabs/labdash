local json = require "cjson"
local router = require "router"
local auth = require "api.session"
local r = router.new()

r:match({
    GET = {
        ["/api/menu"] = function(params)
            ngx.print(json.encode(labdash.menu))
        end,

        ["/api/session"] = function(params)
            auth:validate()
        end
    },

    POST = {
        ["/api/session"] = function(params)
            ngx.req.read_body()
            local req = json.decode(ngx.req.get_body_data())
            auth:login(req['username'], req['password'])
        end
    },

    DELETE = {
        ["/api/session"] = function(params)
            auth:logout()
        end
    }
})

ngx.header["content-type"] = 'application/json'

local ok, errmsg = r:execute(
    ngx.var.request_method,
    ngx.var.request_uri,
    ngx.req.get_uri_args()
)

if not ok then
    ngx.status = 400
    ngx.print("{\"error\": \"Bad request\"}")
end
