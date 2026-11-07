local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Appearance
config.font_size = 14
config.color_scheme = "Tokyo Night" -- matches LazyVim's default theme
config.window_decorations = "RESIZE"
config.window_padding = { left = 4, right = 4, top = 4, bottom = 0 }

-- tmux handles tabs and panes
config.enable_tab_bar = false

-- Left Option acts as Alt in nvim/tmux, right Option still types special characters
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

config.scrollback_lines = 10000
config.audible_bell = "Disabled"

return config
