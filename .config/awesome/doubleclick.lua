local gears = require("gears")

local doubleclick = {
    _single_click_actions = {}
}

function doubleclick:__call()
    if self._timer then
        self._timer:stop()
        self._timer = nil
        self._single_click_actions = {}

        return true
    end
  
    self._timer = gears.timer.start_new(0.2, function()
        self._timer = nil
        for _, cb in ipairs(self._single_click_actions) do
            cb()
        end

        return false
    end)
    return false
end

-- only call the given function when the double click timer expires
function doubleclick:ensure_single_click(cb)
    table.insert(self._single_click_actions, cb)
end

doubleclick.__index = doubleclick
return setmetatable({ _single_click_actions = {} }, doubleclick)