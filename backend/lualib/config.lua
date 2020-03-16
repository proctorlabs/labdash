local util = require "util"

local config = {}
config.__index = config

function config.new()
    local self = {
        cfg = {
            menu = {
                items = {}
            },
            session_config = {
                name = "dash_session",
                secret = nil,
                strategy = "regenerate",
                cookie = {
                    persistent = true,
                    domain = nil,
                    renew = 3600 * 24,
                    lifetime = 3600 * 24 * 7
                },
                random = {
                    length = 32
                }
            },
            ldap = {
                uri = nil,
                base_dn = nil,
                search_attr = nil
            }
        }
    }
    return setmetatable(self, config)
end

function config:parse(cfg)
    self:add_ldap(cfg)
    self:add_session(cfg)
    self:add_menu(cfg)
    return self.cfg
end

function config:add_session(cfg)
    if cfg.sessions then
        self.cfg.session_config = {
            name = cfg.sessions.name or "dash_session",
            secret = cfg.auth.secret or '623q4hR325t36VsCD3g567922IC0073T',
            strategy = "regenerate",
            cookie = {
                persistent = true,
                domain = cfg.sessions.domain or 'localhost',
                renew = 3600 * 24,
                lifetime = 3600 * 24 * 7
            },
            random = {
                length = 32
            }
        }
    end
end

function config:add_ldap(cfg)
    if cfg.auth then
        self.cfg.ldap = {
            uri = cfg.auth.uri or self.cfg.auth.uri,
            base_dn = cfg.auth.base_dn or self.cfg.auth.base_dn,
            search_attr = cfg.auth.search_attr or self.cfg.auth.search_attr
        }
    end
end

function config:add_menu(cfg)
    if cfg.menu and cfg.menu.items then
        for k, v in pairs(cfg.menu.items) do
            if v.type == 'url' then
                self.cfg.menu.items[k] = {
                    type = 'url',
                    url = v.url,
                    icon = v.icon or 'fa:question',
                    open_in = v.open_in or 'frame',
                    display = v.display or k,
                }
            elseif v.type == 'wrap' then
                self.cfg.menu.items[k] = {
                    type = 'wrap',
                    host = v.host,
                    scheme = v.scheme or 'https',
                    path = v.path or '/',
                    icon = v.icon or 'fa:question',
                    open_in = v.open_in or 'frame',
                    display = v.display or k,
                }
            end
        end
    end
    for _, v in pairs(self.cfg.menu.items) do
        local parts = util.split(v.icon, ":")
        if table.getn(parts) == 2 then
            v.icon = parts[1] .. ' fa-' .. parts[2]
        end
    end
end

return config
