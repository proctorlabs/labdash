-- preload dependencies
require "cjson"
require "resty.session"
require "router"
require "lualdap"
require "api.session"

local config = require("config").new()
local yaml = require "lyaml"
local file = io.open("/etc/nginx/dashboard.yml", "r")
local text = file:read("*a")
file.close()
local cfg = yaml.load(text)
CFG = config:parse(cfg)
