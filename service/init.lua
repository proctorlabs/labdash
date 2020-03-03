-- preload dependencies
local yaml = require 'lyaml'
local json = require "cjson"
require "resty.template"
require 'router'

local file = io.open("/etc/nginx/dashboard.yml", "r")
local text = file:read("*a")
file.close()

local cfg = yaml.load(text)
local links = cfg["links"]
local content_root = cfg["options"]["content"]

local dashboard = ngx.shared.dashboard
dashboard:set("links", json.encode(links))
dashboard:set("content_root", content_root)
