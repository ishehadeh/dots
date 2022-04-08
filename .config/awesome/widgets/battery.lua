local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local power_supply = require("system.power_supply")
local gdebug = gears.debug

local battery = {}

function battery:update()
    local energy = self._private.device:get_energy() / self._private.device:get_energy_full()
    self._private.text:set_text(string.format(" %.0f%% ", energy * 100))
end

function battery:set_device(device_name)
    self._private.device = power_supply.new(device_name)
    self:update()
end

function battery:get_device()
    return self._private.device
end

local function new_battery(device_name)
    local text = wibox.widget.textbox()
    local widget = wibox.widget.base.make_widget(text, "battery", { enable_properties = true })
    gears.table.crush(widget, battery, true)

    widget._private.text = text
    widget._private.timer = gears.timer {
        timeout   = 5,
        callback  = function()
            widget:update()
        end
    }

    widget:set_device(device_name or "BAT0")
    return widget
end

return setmetatable(battery, { __call = function(self, bat) return new_battery(bat) end })