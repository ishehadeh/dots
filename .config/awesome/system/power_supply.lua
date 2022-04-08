local lfs = require("lfs")

local power_supply = {}

-- Create a new battery from a directory
-- Exampe: `power_supply.open("/sys/class/power_supply/BAT0")`
--
-- @param path string a path to power_supply sysfs directory
-- @returns a new `power_supply` object
function power_supply.open(path)
    local new = { base_path = path }
    setmetatable(new, power_supply)
    power_supply.__index = power_supply
    return new
end

-- Create a new battery from a directory
-- Exampe: `power_supply.open("BAT0")`
--
-- @param name string the name of a power supply device
-- @returns a new `power_supply` object
function power_supply.new(name)
    return power_supply.open("/sys/class/power_supply/" .. name)
end

-- Get a list of available power supplies power_supply from `base` or the default sysfs class path.
--
-- @param base string [default: "/sys/class/power_supply"] the directory to search for power supply devices
-- @returns a list of `power_supply` objects
function power_supply.list(base)
    local base = base or "/sys/class/power_supply"

    local i = 1
    local power_supplies = {}
    for device in lfs.dir(base) do
        if device ~= '.' and device ~= '..' then
            power_supplies[i] = power_supply.open(base .. "/" .. device)
            i = i + 1
        end
    end

    return power_supplies
end

-- open `path` and read a single number from it then close it.
-- @returns the number read 
local function read_number_file(path)
    local f = io.open(path)
    if not f then
        -- error("failed to open file '" .. path .. "'")
        return nil -- not all measurements are supported on every device so return nil if its not found
    end

    local n = f:read("n")
    f:close()

    return n
end

-- Get the maximum energy the device can currently hold
--
-- @returns int the device's max energy
function power_supply:get_energy_full()
    return read_number_file(self.base_path .. "/energy_full")
end

-- Get the max energy the device was designed to hold
--
-- @returns int the device's intended max energy
function power_supply:get_energy_full_design()
    return read_number_file(self.base_path .. "/energy_full_design")
end


-- Get the device's current energy
--
-- @returns int the device's current energy
function power_supply:get_energy()
    require("gears.debug").dump(self)
    return read_number_file(self.base_path .. "/energy_now")
end


-- Get the device's current status.
--
-- @returns string one of "Unknown", "Charging", "Discharging", "Not charging", "Full"
function power_supply:get_status()
    local f = io.open(self.base_path .. "/status")
    if not f then
        return nil -- no status on this device
    end

    local n = f:read("l")
    f:close()
    -- see: https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-power for possible return values
    return n
end



return power_supply