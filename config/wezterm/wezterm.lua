local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux
local act = wezterm.action

config.color_scheme = "Gruvbox dark, hard (base16)"

local font = wezterm.font({ family = "BigBlueTerm437 Nerd Font" })
local font_size = 12

config.font = font
config.font_size = font_size
config.line_height = 1.5
config.default_cursor_style = "BlinkingBar"
config.window_decorations = "RESIZE"
config.window_frame = {
	font_size = 14,
}

config.colors = {
	background = "black",
}

config.quick_select_patterns = {
	"wiz-[a-z0-9-]+",
}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)
wezterm.on("gui-attached", function(_)
	mux.get_window():gui_window():maximize()
end)

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
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.5,
}

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
	{ key = "`", mods = "CTRL", action = act.ActivatePaneDirection("Next") },

	{ key = "p", mods = "SUPER", action = act.ActivateCommandPalette },
	{ key = "d", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },

	{ key = "s", mods = "SUPER", action = act.QuickSelect },
	{
		key = "n",
		mods = "SUPER",
		action = wezterm.action_callback(function()
			local _, _, window = mux.spawn_window({})
			window:gui_window():maximize()
		end),
	},

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
	{
		key = "b",
		mods = "SUPER",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_tab()
		end),
	},
	{
		key = "/",
		mods = "SUPER",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 25 },
			command = { args = { "/opt/homebrew/bin/aichat" } },
			top_level = true,
		}),
	},
}

local copy_mode = nil
local search_mode = nil

copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(
	copy_mode,
	{ key = "/", mods = "NONE", action = wezterm.action({ Search = { CaseInSensitiveString = "" } }) }
)
table.insert(
	copy_mode,
	{ key = "?", mods = "NONE", action = wezterm.action({ Search = { CaseInSensitiveString = "" } }) }
)
table.insert(copy_mode, { key = "n", mods = "NONE", action = wezterm.action({ CopyMode = "NextMatch" }) })
table.insert(copy_mode, { key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) })

search_mode = wezterm.gui.default_key_tables().search_mode
table.insert(search_mode, { key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) })
table.insert(search_mode, { key = "Enter", mods = "NONE", action = "ActivateCopyMode" })

config.key_tables = {
	copy_mode = copy_mode,
	search_mode = search_mode,
}

return config
