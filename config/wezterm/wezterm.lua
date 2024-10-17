local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Gruvbox dark, hard (base16)"

local font = wezterm.font({ family = "BigBlueTerm437 Nerd Font" })
local font_size = 12

config.font = font
config.font_size = font_size
config.line_height = 1.5

config.window_decorations = "RESIZE"
config.window_frame = {
	font_size = 14,
}

config.colors = {
	background = "black",
}

local home = os.getenv("HOME")
local background_image = home .. "/.local/share/wezterm.png"
config.background = {
	{
		source = {
			File = background_image,
		},
		hsb = { brightness = 0.2 },
		height = "Cover",
		horizontal_align = "Left",
	},
}

local act = wezterm.action
config.scrollback_lines = 3500
config.leader = { key = "a", mods = "SUPER" }
config.keys = {
	{ key = "-", mods = "SHIFT|SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "SHIFT|SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{ key = "z", mods = "SUPER", action = act.TogglePaneZoomState },

	{ key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },

	{ key = "p", mods = "SUPER", action = act.ActivateCommandPalette },
	{ key = "d", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },

	{ key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
	{ key = "[", mods = "SHIFT|SUPER", action = act.MoveTabRelative(-1) },
	{ key = "]", mods = "SHIFT|SUPER", action = act.MoveTabRelative(1) },

	{
		key = "h",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "k", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "l",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
}

return config
