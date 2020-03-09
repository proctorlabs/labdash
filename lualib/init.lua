-- preload dependencies
local yaml = require 'lyaml'
local json = require "cjson"
require 'router'
require "lualdap"

local file = io.open("/etc/nginx/dashboard.yml", "r")
local text = file:read("*a")
file.close()

local cfg = yaml.load(text)
local menu = cfg["menu"]
local auth = cfg["auth"]

local dashboard = ngx.shared.dashboard
dashboard:set("menu", json.encode(menu))
dashboard:set("auth", json.encode(auth))
