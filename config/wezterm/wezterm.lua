local wezterm = require("wezterm")
return {
  scrollback_lines = 36000,
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.2,
  },
  font = wezterm.font_with_fallback({
     "VictorMono Nerd Font",
     "Noto Sans Mono CJK SC",
   }),
  tab_bar_at_bottom = true,
  font_size = 12,
  font_end = "OpenGL",
  prefer_egl = true,
  inactive_pane_hsb = {
      hue = 1.0,
      saturation = 1.0,
      brightness = 1.0,
  },
  initial_rows = 300,
  initial_cols = 300,
  color_scheme = "Molokai",
  leader = { key="s", mods="CMD" },
  keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "c", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "t", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "h", mods = "LEADER|CTRL",  action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER|CTRL",  action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER|CTRL",  action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER|CTRL",  action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "h", mods = "LEADER",  action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER",  action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER",  action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER",  action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
    { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
    { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
    { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
    { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
    { key = "n", mods = "SHIFT|CTRL", action="ToggleFullScreen"},
  },
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  window_background_opacity = 0.9,
  ratelimit_output_bytes_per_second = 20000000,
  colors = {
    -- The default text color
    foreground = "white",
    -- The default background color
    background = "black",
    ansi = {"#ffffff","#b21818", "#24e324", "#cccc38","#1e1ee7", "#b218b2", "#00bbbb","#bbbbbb"},
    brights = {"#838383", "#ff080c","#54ff54", "#ffff54" ,"#4284ff", "#ff55ff","#55ffff","#ffffff"}
  }
}