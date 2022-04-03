local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local gdebug = gears.debug
-- local beautiful = require("beautiful")
local cairo = require("lgi").cairo

--- Collect the client focus history in an ordered list starting with the most recently focused (index 1) 
--
---@param screen nil | awful.screen.object the screen thats history should be counted.
---@param filter nil | fun(c) `awful.client.focus.filter`-like function for filtering the history
---@return table clients a list of clients from the focus history, on `screen`, filtered with `filter`
local function collect_focus_history(screen, filter)
    local index = 0
    local list = {}
    while true do
        local client = awful.client.focus.history.get(screen, index, filter)
        if client then
            list[index + 1] = client
            index = index + 1
        else
            break
        end
    end

    return list
end


local client_preview = { mt = { } }
client_preview.mt.__call = function(client, fill)
    local widget = wibox.widget.base.make_widget(nil, "client_preview", { enable_properties = true })
    gears.table.crush(widget, client_preview, true)

    widget._private.client = client
    widget._private.fill = fill

    return widget
end

function client_preview.set_client(self, client)
    self._private.client = client
    self:emit_signal("widget::redraw_needed")
end

function client_preview.set_fill(self, fill)
    self._private.fill = fill
    self:emit_signal("widget::redraw_needed")
end

function client_preview.get_client(self) return self._private.client end
function client_preview.get_fill(self) return self._private.fill end

function client_preview.fit(_self, _context, width, height)
    return width, height
end

local function calc_scale_and_zoom(target, other_target, actual, other_actual)
    local scale_factor = target/actual
    local zoom = math.abs((other_target - (scale_factor * other_actual))/other_target)
    return scale_factor, zoom
end

function client_preview.draw(self, context, cr, width, height)
    local max_zoom = .1

    local content = gears.surface(self._private.client.content)
    local content_cr = cairo.Context(content)

    local _x, _y, w, h = content_cr:clip_extents()
    local max_w = width
    local max_h = height

    if self._private.fill then
        local r, g, b, a = gears.color.parse_color(self._private.fill)
        cr:rectangle(0, 0, width, height)
        cr:set_source_rgba(r, g, b, a)
        cr:fill()
    end

    local ideal_h_scale, ideal_h_zoom = calc_scale_and_zoom(max_h, max_w, h, w)
    local ideal_w_scale, ideal_w_zoom = calc_scale_and_zoom(max_w, max_h, w, h)

    local best_scale, best_zoom = nil, nil
    if ideal_h_zoom > ideal_w_zoom then
        best_scale = ideal_h_scale
        best_zoom = ideal_h_zoom
    else
        best_scale = ideal_w_scale
        best_zoom = ideal_w_zoom
    end

    if max_zoom < best_zoom then
        if w > h then
            best_scale = (max_w * (1 - max_zoom)) / w
        else
            best_scale = (max_h * (1 - max_zoom)) / h
        end
    end

    cr:translate(max_w/2, max_h/2)
    cr:scale(best_scale, best_scale)
    cr:translate(-.5 * w, -.5 * h)
    -- cr.operator = cairo.Operator.SOURCE
    cr:set_source_surface(content, 0, 0)
    cr:paint()
end


setmetatable(client_preview, client_preview.mt)


local window_switcher = { mt = { } }

local function make_client_preview(client, w, h)
    return wibox.widget {
        {
            {
                client = client,
                fill = "#00000099",

                widget = client_preview,
            },

            shape_border_color = "#ffffffff",
            shape_border_width = 2,
            shape = gears.shape.rectangle,

            forced_width = w,
            forced_height = h,

            widget = wibox.widget.background,
        },

        {
            {
                markup = "<span foreground='white'>" .. gears.string.xml_escape(client.name) .. "</span>",
                font = "Montserrat Bold",
                font_size = 14,
                align = "center",
                fg = "#ffffff",
                ellipsize = "end",

                widget = wibox.widget.textbox
            },

            forced_width= w,
            left = 15,
            right = 15,

            widget = wibox.container.margin,
        },

        spacing = 10,
        layout = wibox.layout.fixed.vertical,
    }
end

-- Init method, the object itself is callable and returns a new instance of itself.
-- This is done in order to make using the widget declaratively more ergonomic.
-- i.e.
-- ```lua
-- wibox.widget {
--    -- (...)
--    widget = window_switcher.new
-- }
-- ```
-- vs.
-- ```lua
-- wibox.widget {
--    -- (...)
--    widget = window_switcher
-- }
-- ```
window_switcher.mt.__call = function()
    local clients_previews = wibox.layout.fixed.horizontal()
    clients_previews:set_spacing(10)
    local widget = wibox.widget.base.make_widget(clients_previews, "window_switcher", { enable_properties = true })
    gears.table.crush(widget, window_switcher, true)

    widget._private.container = clients_previews

    widget:refresh()
    return widget
end


---------------------------------------
-- Navigation

--- Get the current index
---@return integer index 
function window_switcher.get_index(self)
    return self._private.index
end


--- Move to the client at the given index
--
---@param index integer index to move to
function window_switcher.set_index(self, index)
    assert(math.type(index) == "integer", "WindowSwitcher:set_index() index must be an integer!")

    -- theres a faster way to do a wrapping add in a single statement, but I think this is more clear
    local clients_count = #self._private.clients
    if clients_count == 0 then
        index = 0
        return
    end
    if index > clients_count then
        index = index % clients_count
    end
    while index < 0 do
        index = index + clients_count
    end

    self._private.index = index

    -- this could brea very, very easily
    -- FIXME: use something a little more stable
    local children = self._private.container:get_all_children()
    bg_index = 1
    for i, c in ipairs(children) do
        if c.widget_name == "wibox.container.background" then
            if bg_index == self._private.index then
                c:set_shape_border_color("#ffffff")
            else
                c:set_shape_border_color("#00000000")
            end
            bg_index = bg_index + 1
        end
    end
end


function window_switcher.refresh(self)
    local screen = awful.screen.focused()
    self._private.clients = collect_focus_history(screen)
    if #self._private.clients == 0 then
        self._private.container:set_children({})
    end

    local PAD = 100

    local work_aspect_ratio = screen.workarea.width / screen.workarea.height
    local height = screen.workarea.height / 5
    local allocated_width = (screen.workarea.width - PAD * 2)
    local expected_width = math.min(allocated_width, work_aspect_ratio * height * #self._private.clients)
    local preview_width = expected_width / #self._private.clients 
    local preview_height = preview_width / work_aspect_ratio

    children = {}
    for i, client in ipairs(self._private.clients) do
        children[i] = make_client_preview(client, preview_width, height)
    end
    self._private.container:set_children(children)
    self:set_index(0)
end

--- Shift by the given offset
--
---@param offset integer amount to shift the window selection.
function window_switcher.shift(self, offset)
    self:set_index(self._private.index + offset)
end

--- Return the currently selected client
---@return awful.client.object
function window_switcher.selected(self)
    return self._private.clients[self._private.index]
end

--- Move to the previous client
function window_switcher.prev(self)
    self:shift(-1)
end

--- Advance to the next client
function window_switcher.next(self)
    self:shift(1)
end

return setmetatable(window_switcher, window_switcher.mt)
