local image = {}
image.__index = image

function image.get()
    local res = ngx.shared.shmem:get("imgpath")
    if res then
        ngx.var['resource_url'] = res
    else
        local http = require "resty.http"
        local httpc = http.new()
        local res, err = httpc:request_uri("https://source.unsplash.com/collection/1065976/1920x1080/daily", {
            method = "GET",
            ssl_verify = false
        })

        if not res then
            ngx.status = 500
            ngx.log(ngx.WARN, err)
            return
        end

        ngx.shared.shmem:set("imgpath", res.headers['Location'], 600)
        ngx.var['resource_url'] = res.headers['Location']
    end
    ngx.exec("@cache_resource")
end

return image
