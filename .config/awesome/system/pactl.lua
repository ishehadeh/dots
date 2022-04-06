local pactl = {
    pactl = "pactl"
}

-- run pactl with the given args, return stdout
local function pactl_run(...)
    local proc = io.popen("'" .. pactl.pactl .. "' '" .. table.concat({...}, "' '") .. "' 2>&1")
    local resp = proc:read("a")
    for err in string.gmatch(resp, "^Failure: (.*)\n") do
        error(err)
    end
    return string.gsub(resp, "\n$", "")
end


for _, obj_name in ipairs({ "sink", "source" }) do
    local default = "@DEFAULT_" .. string.upper(obj_name) .. "@"

    pactl[obj_name] = {}
    pactl[obj_name].default = function ()
        return pactl_run("get-default-" .. obj_name):match("%S+")
    end

    pactl[obj_name].set_default = function (name)
        return pactl_run("set-default-" .. obj_name, name)
    end

    pactl[obj_name].get_mute = function (name)
        return pactl_run("get-" .. obj_name .. "-mute", name or default) == "Mute: yes"
    end

    pactl[obj_name].set_mute = function (mute, name)
        return pactl_run("set-" .. obj_name .. "-mute", name or default, mute and "1" or "0")
    end

    pactl[obj_name].toggle_mute = function (name)
        return pactl_run("set-" .. obj_name .. "-mute", name or default, "toggle")
    end

    pactl[obj_name].get_volume = function (name)
        local volume_info = pactl_run("get-" .. obj_name .. "-volume", name or default)
        local retval = {}
        local has_common_percent = nil
        for location, _unknown, percent, db in string.gmatch(volume_info, "([%w-]+):%s*(%d+)%s*/%s*(%d+)%%%s*/%s*([%+%-]?[inf%d%.]*)%s*dB") do
            retval[location] = {
                percent = tonumber(percent),
                db = tonumber(db) 
            }
            if has_common_percent == nil then
                has_common_percent = percent
            elseif has_common_percent ~= percent then
                has_common_percent = false
            end
        end

        if has_common_percent then
            retval["percent"] = has_common_percent
        end

        local balance = string.match(volume_info, "\n%s*balance%s*([%+%-]?%d*%.%d*)")
        if balance then
            retval.balance = tonumber(balance)
        end

        return retval
    end

    pactl[obj_name].set_volume = function (volume_str, name)
        return pactl_run("set-" .. obj_name .. "-volume", name or default, volume_str)
    end
end


return pactl