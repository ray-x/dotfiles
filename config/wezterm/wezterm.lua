local wezterm = require('wezterm')
local scheme = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']
local act = wezterm.action

local function convert_home_dir(path)
  local cwd = path
  local home = os.getenv('HOME')
  cwd = cwd:gsub('^' .. home .. '/', '~/')
  if cwd == '' then
    return path
  end
  return cwd
end
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function convert_useful_path(dir)
  local cwd = convert_home_dir(dir)
  return basename(cwd)
end
-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-local
local function create_tab_title(tab, tabs, panes, config, hover, max_width)
  local user_title = tab.active_pane.user_vars.panetitle
  if user_title ~= nil and #user_title > 0 then
    return tab.tab_index + 1 .. ':' .. user_title
  end
  -- pane:get_foreground_process_info().status

  local title = wezterm.truncate_right(basename(tab.active_pane.foreground_process_name), max_width)
  if title == '' then
    local dir = string.gsub(tab.active_pane.title, '(.*[: ])(.*)]', '%2')
    dir = convert_useful_path(dir)
    title = wezterm.truncate_right(dir, max_width)
  end

  local copy_mode, n = string.gsub(tab.active_pane.title, '(.+) mode: .*', '%1', 1)
  if copy_mode == nil or n == 0 then
    copy_mode = ''
  else
    copy_mode = copy_mode .. ': '
  end
  return copy_mode .. tab.tab_index + 1 .. ':' .. title
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = create_tab_title(tab, tabs, panes, config, hover, max_width)

  -- selene: allow(undefined_variable)
  local solid_left_arrow = utf8.char(0x2590)
  -- selene: allow(undefined_variable)
  local solid_right_arrow = utf8.char(0x258c)
  -- https://github.com/wez/wezterm/issues/807
  -- local edge_background = scheme.background
  -- https://github.com/wez/wezterm/blob/61f01f6ed75a04d40af9ea49aa0afe91f08cb6bd/config/src/color.rs#L245
  local edge_background = '#2e3440'
  local background = scheme.ansi[1]
  local foreground = scheme.ansi[5]

  if tab.is_active then
    background = scheme.brights[1]
    foreground = scheme.brights[8]
  elseif hover then
    background = scheme.cursor_bg
    foreground = scheme.cursor_fg
  end
  local edge_foreground = background

  return {
    { Attribute = { Intensity = 'Bold' } },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = solid_left_arrow },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = solid_right_arrow },
    { Attribute = { Intensity = 'Normal' } },
  }
end)

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(wezterm.format({
    { Foreground = { AnsiColor = 'Blue' } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = pane:get_domain_name() },
  }))
end)

wezterm.on('toggle-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.9
  else
    overrides.window_background_opacity = nil
    -- overrides.window_background_opacity = overrides.window_background_opacity + 0.2
    -- if overrides.window_background_opacity > 1.0 then
    --   overrides.window_background_opacity = nil
    -- end
  end
  window:set_config_overrides(overrides)
end)

return {
  scrollback_lines = 36000,
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.2,
  },
  color_scheme = 'Catppuccin Mocha',
  font = wezterm.font_with_fallback({
    { family = 'Victor Mono', weight = 'Medium' },
    'VictorMono Nerd Font Mono',
  }),
  -- tab_bar_at_bottom = true,
  font_size = 14,
  prefer_egl = true,
  inactive_pane_hsb = {
    hue = 1.03,
    saturation = 1.0,
    brightness = 1.0,
  },
  initial_rows = 300,
  initial_cols = 300,
  animation_fps = 30,
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_ease_in = 'Linear',
  cursor_blink_ease_out = 'Linear',
  cursor_blink_rate = 1666,
  window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 1,
  },
  use_fancy_tab_bar = true,
  colors = {
    tab_bar = {
      background = scheme.background,
      new_tab = { bg_color = '#2e3440', fg_color = scheme.ansi[8], intensity = 'Bold' },
      new_tab_hover = {
        bg_color = scheme.ansi[1],
        fg_color = scheme.brights[8],
        intensity = 'Bold',
      },
      -- format-tab-title
      -- active_tab = { bg_color = "#121212", fg_color = "#FCE8C3" },
      -- inactive_tab = { bg_color = scheme.background, fg_color = "#FCE8C3" },
      -- inactive_tab_hover = { bg_color = scheme.ansi[1], fg_color = "#FCE8C3" },
    },
  },
  -- color_scheme = 'Molokai',
  leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 1000 }, -- default
  -- leader = { key = 'a', mods = 'CMD' }, -- default
  -- defaults ActivateCommandPalette C-S-P
  keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
      key = '-',
      mods = 'LEADER',
      action = wezterm.action({ SplitVertical = { domain = 'CurrentPaneDomain' } }),
    },
    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = wezterm.action({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }),
    },
    { key = 'z', mods = 'LEADER', action = 'TogglePaneZoomState' },
    { key = 't', mods = 'LEADER', action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) }, -- new tab
    { key = 'LeftArrow', mods = 'CMD', action = wezterm.action({ ActivateTabRelative = -1 }) },
    { key = 'RightArrow', mods = 'CMD', action = wezterm.action({ ActivateTabRelative = 1 }) },
    { key = 'F9', mods = 'ALT', action = wezterm.action.ShowTabNavigator },
    {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action({ ActivatePaneDirection = 'Left' }),
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = wezterm.action({ ActivatePaneDirection = 'Down' }),
    },
    { key = 'k', mods = 'LEADER|CTRL', action = wezterm.action({ ActivatePaneDirection = 'Up' }) },
    {
      key = 'l',
      mods = 'LEADER',
      action = wezterm.action({ ActivatePaneDirection = 'Right' }),
    },
    {
      key = 'h',
      mods = 'LEADER|CTRL',
      action = wezterm.action({ ActivatePaneDirection = 'Left' }),
    },
    {
      key = 'j',
      mods = 'LEADER|CTRL',
      action = wezterm.action({ ActivatePaneDirection = 'Down' }),
    },
    { key = 'k', mods = 'LEADER|CTRL', action = wezterm.action({ ActivatePaneDirection = 'Up' }) },
    {
      key = 'l',
      mods = 'LEADER|CTRL',
      action = wezterm.action({ ActivatePaneDirection = 'Right' }),
    },
    {
      key = 'H',
      mods = 'LEADER|SHIFT',
      action = wezterm.action({ AdjustPaneSize = { 'Left', 5 } }),
    },
    {
      key = 'J',
      mods = 'LEADER|SHIFT',
      action = wezterm.action({ AdjustPaneSize = { 'Down', 5 } }),
    },
    {
      key = 'K',
      mods = 'LEADER|SHIFT',
      action = wezterm.action({ AdjustPaneSize = { 'Up', 5 } }),
    },
    {
      key = 'L',
      mods = 'LEADER|SHIFT',
      action = wezterm.action({ AdjustPaneSize = { 'Right', 5 } }),
    },
    { key = '1', mods = 'LEADER', action = wezterm.action({ ActivateTab = 0 }) },
    { key = '2', mods = 'LEADER', action = wezterm.action({ ActivateTab = 1 }) },
    { key = '3', mods = 'LEADER', action = wezterm.action({ ActivateTab = 2 }) },
    { key = '4', mods = 'LEADER', action = wezterm.action({ ActivateTab = 3 }) },
    { key = '5', mods = 'LEADER', action = wezterm.action({ ActivateTab = 4 }) },
    { key = '6', mods = 'LEADER', action = wezterm.action({ ActivateTab = 5 }) },
    { key = '7', mods = 'LEADER', action = wezterm.action({ ActivateTab = 6 }) },
    { key = '8', mods = 'LEADER', action = wezterm.action({ ActivateTab = 7 }) },
    { key = '9', mods = 'LEADER', action = wezterm.action({ ActivateTab = 8 }) },
    -- -- { key = "9", mods = "LEADER", action = wezterm.action({ ActivateTabRelativeTab = -1 }) },
    {
      key = '&',
      mods = 'LEADER|SHIFT',
      action = wezterm.action({ CloseCurrentTab = { confirm = true } }),
    },
    {
      key = 'x',
      mods = 'LEADER',
      action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
    },
    { key = 'n', mods = 'SHIFT|CTRL', action = 'ToggleFullScreen' },
    { key = 'F4', mode = 'LEADER', action = act.EmitEvent('toggle-opacity') },
    -- { key = 's', mods = 'SUPER', action = act.SendString([[:execute 'normal <d-s>']]) },
    { key = 'p', mods = 'SUPER', action = act.SendString([[:execute "normal \<d-p>"]] .. '\x0d') },
    { key = 'F3', action = act.SendString([[:execute "normal \<d-f>"]] .. '\x0d') },
    -- { key = 'w', mods = 'SUPER', action = act.SendString(':execute "normal <d-w>"') },
    -- { key = "f", mods = "SUPER", act.SendString("\x1fd") },
    -- -- { key = "f", mods = "SUPER|SHIFT", act.SendString("\x1fd") },
    -- { key = 'p', mods = 'SUPER|SHIFT', action = act.SendString(':execute "normal <d-p>"') },
    -- { key = 't', mods = 'SUPER', action = act.SendString(':execute "normal <d-T>"') },
    { key = '/', mods = 'SUPER', action = act.SendString('\\c\x20') },
  },
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  -- window_background_opacity = 0.9,
}
