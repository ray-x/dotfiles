local wezterm = require('wezterm')
local scheme = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']
local act = wezterm.action
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local home_dir = wezterm.home_dir
  if pane.domain_name == 'dkfz-workstation' then
    home_dir = '/home/t974t'
  end
  local title = string.gsub(pane.current_working_dir, home_dir, '~')
  title = string.gsub(title, '~/Projects', '~p')
  title = string.gsub(title, 'file://', '')
  title = pane.title .. ' - ' .. title
  title = wezterm.truncate_right(title, max_width - 4)
  title = title
  return wezterm.format({
    { Background = { Color = scheme.tab_bar.background } },
    { Text = ' ' },
    'ResetAttributes',
    { Attribute = { Italic = true } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = ' ' },
    { Text = title },
    { Text = ' ' },
    { Background = { Color = scheme.tab_bar.background } },
    { Text = ' ' },
  })
end)

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(wezterm.format({
    { Foreground = { AnsiColor = 'Blue' } },
    { Attribute = { Intensity = 'Bold' } },
    { Text = pane:get_domain_name() },
  }))
end)

return {
  scrollback_lines = 36000,
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.2,
  },
  color_scheme = 'Catppuccin Mocha',
  -- font = wezterm.font('VictorMono Nerd Font', { weight = 'Bold', italic = true }),
  font = wezterm.font_with_fallback({
    'VictorMono Nerd Font',
    'Noto Sans Mono CJK SC',
  }),
  tab_bar_at_bottom = true,
  font_size = 14,
  prefer_egl = true,
  inactive_pane_hsb = {
    hue = 1.03,
    saturation = 1.0,
    brightness = 1.0,
  },
  initial_rows = 300,
  initial_cols = 300,
  -- color_scheme = "Molokai",
  leader = { key = 'm', mods = 'CMD' }, -- default
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
    { key = 't', mods = 'LEADER', action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) },
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
    { key = 'h', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Left' }) },
    { key = 'j', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Down' }) },
    { key = 'k', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Up' }) },
    { key = 'l', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Right' }) },
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
    { key = 's', mods = 'SUPER', action = act.SendString([[:execute 'normal <d-s>']]) },
    { key = 'p', mods = 'SUPER', action = act.SendString(':execute "normal <d-p>"') },
    { key = 'w', mods = 'SUPER', action = act.SendString(':execute "normal <d-w>"') },
    -- -- { key = "f", mods = "SUPER", act.SendString("\x1fd") },
    -- -- { key = "f", mods = "SUPER|SHIFT", act.SendString("\x1fd") },
    { key = 'p', mods = 'SUPER|SHIFT', action = act.SendString(':execute "normal <d-p>"') },
    { key = 't', mods = 'SUPER', action = act.SendString(':execute "normal <d-T>"') },
    { key = '/', mods = 'SUPER', action = act.SendString('application \\c\x20') },
  },
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  window_background_opacity = 0.9,
}
