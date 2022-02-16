local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi
local clickable_container = require("widget.clickable-container")

local tag_list = require("widget.tag-list")
function bars_toggle(hide)
  for s in screen do
    hide = hide or false
    s.bottom_panel.visible = not hide
  end
end
local build_widget = function(widget)
  return wibox.widget({
    {
      widget,
      bg = beautiful.groups_title_bg,
      shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
      end,
      widget = wibox.container.background,
    },
    top = dpi(10),
    bottom = dpi(10),
    widget = wibox.container.margin,
  })
end

local bottom_panel = function(s)
  s.systray = wibox.widget({
    {
      base_size = dpi(30),
      horizontal = true,
      screen = "primary",
      widget = wibox.widget.systray,
    },
    visible = false,
    top = dpi(2),
    widget = wibox.container.margin,
  })

  s.search = require("widget.search-apps")()
  s.tray_toggler = build_widget(require("widget.tray-toggle"))
  s.bluetooth = build_widget(require("widget.bluetooth")())
  s.network = build_widget(require("widget.network")())
  s.battery = build_widget(require("widget.battery")())
  local layout_box = build_widget(require("widget.layoutbox")(s))

  local separator = wibox.widget({
    orientation = "vertical",
    forced_height = dpi(1),
    forced_width = dpi(1),
    span_ratio = 0.55,
    widget = wibox.widget.separator,
  })

  local bottom_panel_height = dpi(48)
  local bottom_panel_margins = dpi(5)

  s.panel = awful.popup({
    widget = {
      {
        layout = wibox.layout.fixed.horizontal,
        s.search,
        separator,
        tag_list(s),
        require("widget.xdg-folders")(),
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(3),
          s.systray,
          s.tray_toggler,
          s.network,
          s.bluetooth,
          s.battery,
          layout_box,
          separator,
        },
        require("widget.xdg-folders.trash")(),
      },
      bg = beautiful.background,
      shape = function(cr, w, h)
        gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, beautiful.groups_radius)
      end,
      widget = wibox.container.background,
    },
    type = "dock",
    screen = s,
    ontop = true,
    visible = true,
    height = bottom_panel_height,
    maximum_height = bottom_panel_height,
    placement = awful.placement.bottom,
    shape = gears.shape.rectangle,
    bg = beautiful.transparent,
  })

  -- This prevent other windows take up the places
  -- s.panel:struts({
  --   bottom = bottom_panel_height,
  -- })
  -- Add toggling functionalities
  s.docktimer = gears.timer({ timeout = 3 })
  s.docktimer:connect_signal("timeout", function()
    local sc = awful.screen.focused()

    if sc.panel then
      sc.panel.maximum_height = dpi(4)
    end

    if sc.top_panel then
      sc.top_panel.maximum_height = dpi(4)
    end
    if sc.docktimer.started then
      sc.docktimer:stop()
    end
  end)
  tag.connect_signal("property::selected", function(t)
    local sc = t.screen or awful.screen.focused()
    sc.panel.visible = true

    sc.panel.maximum_height = dpi(bottom_panel_height)
    if not sc.docktimer.started then
      sc.docktimer:start()
    end
  end)

  s.panel:connect_signal("mouse::leave", function()
    local sc = awful.screen.focused()
    if sc.panel then
      sc.panel.maximum_height = dpi(4)
    end
  end)

  s.panel:connect_signal("mouse::enter", function()
    local sc = awful.screen.focused()
    sc.panel.maximum_height = dpi(bottom_panel_height)
  end)
  return s.panel
end

return bottom_panel
