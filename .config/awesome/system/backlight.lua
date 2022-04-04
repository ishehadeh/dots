local lfs = require("lfs")

local backlight = {}

-- Create a new backlight from a directory
-- Exampe: `backlight.open("/sys/class/backlight/intel_backlight")`
--
-- @param path string a path to backlight sysfs directory
-- @returns a new `backlight` object
function backlight.open(path)
    local new = { base_path = path}
    setmetatable(new, backlight)
    backlight.__index = backlight
    return new
end

-- Get a list of available backlights from the default sysfs path
--
-- @param base string [default: "/sys/class/backlight"] the directory to search for backlight devices
-- @returns a list of `backlight` objects
function backlight.list(base)
    local base = base or "/sys/class/backlight"

    local i = 1
    local backlights = {}
    for device in lfs.dir(base) do
        if device ~= '.' and device ~= '..' then
            backlights[i] = backlight.open(base .. "/" .. device)
            i = i + 1
        end
    end

    return backlights
end

-- Get the brightness in units the underlying device uses
--
-- @returns int the device's brightness
function backlight:get_brightness_absolute()
    local f = io.open(self.base_path .. "/brightness")
    if not f then
        error("failed to open file '" .. self.base_path .. "/brightness'")
    end

    local brightness_s = f:read()
    f:close()

    return tonumber(brightness_s)
end

-- Get the maximum brightness of underlying device
--
-- @returns number the device's brightness
function backlight:get_max_brightness_absolute()
    local f = io.open(self.base_path .. "/max_brightness")
    if not f then
        error("failed to open file '" .. self.base_path .. "/max_brightness'")
    end

    local max_brightness_s = f:read()
    f:close()

    return tonumber(max_brightness_s)
end

-- Get the backlight brightness in the range [0, 1]
--
-- @returns number [0.0, 1.0] the device's brightess
function backlight:get_brightness()
    return self:get_brightness_absolute() / self:get_max_brightness_absolute()
end

-- Set the device's brightness in its own units
-- @param brightness number the new brightness value
function backlight:set_brightness_absolute(brightness)
    local f = io.open(self.base_path .. "/brightness", "w")
    if not f then
        error("failed to open file '" .. self.base_path .. "/brightness'")
    end

    f:write(tostring(brightness))
    f:close()
end

-- Set the device's brightness
-- @param brightness number [0.0, 1.0] the new brightness
function backlight:set_brightness(brightness)
    self:set_brightness_absolute(math.ceil(brightness * self:get_max_brightness_absolute()))
end

return backlight