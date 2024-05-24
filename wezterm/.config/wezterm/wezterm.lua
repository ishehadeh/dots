-- Pull in the wezterm API
local wezterm = require 'wezterm'
local keys = require('keys')

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font_with_fallback { 'Iosevka Term', 'Noto Color Emoji' }

config.use_fancy_tab_bar = false

-----------
-- Keys  --
-----------
-- Rather than emitting fancy composed characters when alt is pressed, treat the
-- input more like old school ascii with ALT held down
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

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
config.initial_rows = 32
config.initial_cols = 128

config.disable_default_key_bindings = true
config.key_tables = keys.key_tables
config.keys = keys.keys

config.term = 'wezterm'

-- and finally, return the configuration to wezterm
return config
