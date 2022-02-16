local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local icons = require("theme.icons")
local clickable_container = require("widget.clickable-container")
local task_list = require("widget.task-list")

local top_panel = function(s)
  s.tpanel = wibox({
    ontop = true,
    screen = s,
    type = "dock",
    height = dpi(28),
    width = s.geometry.width,
    x = s.geometry.x,
    y = s.geometry.y,
    stretch = false,
    bg = beautiful.background,
    fg = beautiful.fg_normal,
  })

  -- s.tpanel:struts({
  --   top = dpi(28),
  -- })

  s.tpanel:connect_signal("mouse::enter", function()
    local w = mouse.current_wibox
    if w then
      w.cursor = "left_ptr"
    end

    local sc = awful.screen.focused()
    sc.tpanel.height = dpi(28)
  end)

  s.tdocktimer = gears.timer({ timeout = 3 })
  s.tdocktimer:connect_signal("timeout", function()
    local sc = awful.screen.focused()
    if sc.tpanel then
      sc.tpanel.height = dpi(2)
    end
    if sc.tdocktimer.started then
      sc.tdocktimer:stop()
    end
  end)

  s.tpanel:connect_signal("mouse::leave", function()
    local sc = awful.screen.focused()
    if sc.tpanel then
      sc.tpanel.height = dpi(2)
    end
  end)

  local add_button = require("widget.open-default-app")(s)
  local clock = require("widget.clock")(s)

  s.updater = require("widget.package-updater")()
  s.bluetooth = require("widget.bluetooth")()
  s.screen_rec = require("widget.screen-recorder")()
  s.cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
  -- s.tray = require("widget.tray-toggle")()

  s.ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
  s.docker_widget = require("awesome-wm-widgets.docker-widget.docker")

  s.volume_widget = require("awesome-wm-widgets.volume-widget.volume")
  -- s.mpd = require("widget.mpd")()
  s.end_session = require("widget.end-session")()
  s.global_search = require("widget.global-search")()
  s.tray = wibox.layout.margin(wibox.widget.systray(), dpi(5), dpi(5), dpi(5), dpi(5))
  s.tpanel:setup({
    layout = wibox.layout.align.horizontal,
    expand = "none",
    {
      layout = wibox.layout.fixed.horizontal,
      task_list(s),
      add_button,
    },
    clock,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(5),
      s.updater,
      s.bluetooth,
      s.screen_rec,
      s.global_search,
      s.cpu_widget,
      s.ram_widget({ timeout = 15, color_used = "red" }),
      s.docker_widget,
      s.volume_widget,
      -- s.tray,
      s.tray,
      s.end_session,
    },
  })
  return s.tpanel
end

return top_panel
