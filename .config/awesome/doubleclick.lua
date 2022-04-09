local gears = require("gears")

local doubleclick = {}

function doubleclick:__call()
    if self._timer then
        self._timer:stop()
        self._timer = nil
        
        return true
    end
  
    self._timer = gears.timer.start_new(0.20, function()
        self._timer = nil
        return false
    end)
    return false
end

return setmetatable({}, doubleclick)