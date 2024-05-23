-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font 'Iosevka Term'


-- configure multiplexing
config.unix_domains = {
    {
        -- The name; must be unique amongst all domains
        name = 'default',

        -- leaving this blank to use the default
        -- socket_path = "/some/path",

        -- start the mux server if it's not already running
        no_serve_automatically = true,
    },
}

config.default_gui_startup_args = { 'connect', 'default' }

-- and finally, return the configuration to wezterm
return config
