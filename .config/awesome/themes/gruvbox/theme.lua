---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local themes_path = gears.filesystem.get_xdg_config_home() .. "awesome/themes/"

local theme_name = "gruvbox"
local theme_path = themes_path .. theme_name

local theme = {}

-- Gruvbox Light
--     source: https://github.com/morhetz/gruvbox
local palette = {
    bg = "#fbf1c7", -- bg0
    fg = "#3c3836", -- fg1

    bg0_h = "f9f5d7",
    bg0_s = "f2e5bc",
    bg0 = "#fbf1c7",
    bg1 = "#ebdbb2",
    bg2 = "#d5c4a1",
    bg3 = "#bdae93",
    bg4 = "#a89984",

    fg0 = "#282828",
    fg1 = "#3c3836",
    fg2 = "#504945",
    fg3 = "#665c54",
    fg4 = "#7c6f64",
    
    -- main palette
    white = "#fbf1c7",
    red = "#cc241d",
    green = "#98971a",
    yellow = "#d79921",
    blue = "#4585588",
    purple = "#b16286",
    aqua = "#689d6a",
    grey = "#7c6f64",

    orange = "#d65d0e",

    -- alternate palette with darker colors
    alt = {
        white = "#928374", -- actually grey
        red = "#9d0006",
        green = "#79740e",
        yellow = "#b57614",
        blue = "#076678",
        purple = "#8f3f71",
        aqua = "#427b58",
        grey = "#3c3836",

        orange = "#d65d0e",
    }
}

theme.font          = "IBM Plex Sans 9"

theme.bg_normal     = palette.bg1
theme.bg_focus      = palette.bg
theme.bg_urgent     = palette.bg
theme.bg_minimize   = palette.bg4
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = palette.fg
theme.fg_focus      = palette.fg0
theme.fg_urgent     = palette.red
theme.fg_minimize   = theme.fg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1.5)
theme.border_normal = palette.bg3
theme.border_focus  = palette.bg2
theme.border_marked = palette.green

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

local function circle(color)
    return gears.surface.load_from_shape(64, 64, gears.shape.circle, color)
end

-- Define the image to load
theme.titlebar_close_button_normal = circle(palette.red)
theme.titlebar_close_button_focus  = theme.titlebar_close_button_normal

theme.titlebar_minimize_button_normal = circle(palette.yellow)
theme.titlebar_minimize_button_focus  = theme.titlebar_minimize_button_normal

theme.titlebar_ontop_button_normal_inactive = theme_path.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_path.."/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_path.."/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_path.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_path.."/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = circle(palette.green)
theme.titlebar_maximized_button_focus_inactive = theme.titlebar_maximized_button_normal_inactive
theme.titlebar_maximized_button_normal_active = circle(palette.alt.green)
theme.titlebar_maximized_button_focus_active  = theme.titlebar_maximized_button_normal_active

theme.wallpaper = theme_path.."background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_path.."layouts/fairhw.png"
theme.layout_fairv = theme_path.."/layouts/fairvw.png"
theme.layout_floating  = theme_path.."/layouts/floatingw.png"
theme.layout_magnifier = theme_path.."/layouts/magnifierw.png"
theme.layout_max = theme_path.."/layouts/maxw.png"
theme.layout_fullscreen = theme_path.."/layouts/fullscreenw.png"
theme.layout_tilebottom = theme_path.."/layouts/tilebottomw.png"
theme.layout_tileleft   = theme_path.."/layouts/tileleftw.png"
theme.layout_tile = theme_path.."/layouts/tilew.png"
theme.layout_tiletop = theme_path.."/layouts/tiletopw.png"
theme.layout_spiral  = theme_path.."/layouts/spiralw.png"
theme.layout_dwindle = theme_path.."/layouts/dwindlew.png"
theme.layout_cornernw = theme_path.."/layouts/cornernww.png"
theme.layout_cornerne = theme_path.."/layouts/cornernew.png"
theme.layout_cornersw = theme_path.."/layouts/cornersww.png"
theme.layout_cornerse = theme_path.."/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
