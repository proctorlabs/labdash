-- preload dependencies
require "cjson"
require "resty.session"
require "router"
require "lualdap"
require "api.session"

local yaml = require "lyaml"
local file = io.open("/etc/nginx/dashboard.yml", "r")
local text = file:read("*a")
file.close()

local cfg = yaml.load(text)
labdash = {
    menu = cfg['menu'],

    session_config = {
        name = "dash_session",
        secret = cfg['auth']['secret'],
        strategy = "regenerate",
        cookie = {
            persistent = true,
            domain = cfg['sessions']['domain'],
            renew = 3600 * 24,
            lifetime = 3600 * 24 * 7
        },
        random = {
            length = 32
        }
    },

    ldap = {
        uri = cfg['auth']['uri'],
        base_dn = cfg['auth']['base_dn'],
        search_attr = cfg['auth']['search_attr']
    }
}
