local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local meter_notification = {}


local function new()
    local popup = awful.popup {
        widget = wibox.widget {
            {
                {
                    {
                        max_value     = 1,
                        value         = 0,
                        shape         = gears.shape.rectangle,


                        background_color = "#d5c4a1",
                        color            = "#458588",
                        widget           = wibox.widget.progressbar,
                    },
                    forced_height = 125,
                    forced_width  = 4,
                    direction     = 'east',

                    layout        = wibox.container.rotate,
                },
                left = 6,
                right = 6,

                layout = wibox.container.margin
            },

            spacing = 5,

            layout = wibox.layout.fixed.vertical
        },
        preferred_position = "bottom",
        preferred_anchors = "back",
        offset = {
            y = 20,
            x = -20,
        },

        bg = "#00000000",
        ontop = true,
        shape = gears.shape.rectangle,
        border_color = '#ffffff',
        border_width = 0,
        visible = false,
        type = "notification"
    }

    popup._private.hide_timer = gears.timer {
        timeout   = 2,
        callback  = function()
            popup.visible = false
        end
    }

    gears.table.crush(popup, meter_notification, true)
    return popup
end

function meter_notification:show(value)
    if value then
        self.widget:get_children()[1]:get_children()[1]:get_children()[1]:set_value(value)
    end
    self.visible = true
    self._private.hide_timer:again()
end

return setmetatable(meter_notification, {__call = new})