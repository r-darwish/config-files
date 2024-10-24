local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux
local act = wezterm.action

config.color_scheme = "rose-pine-moon"
config.enable_tab_bar = true

local font = wezterm.font({ family = "CaskaydiaCove Nerd Font", weight = "DemiBold" })
local font_size = 13

if not (wezterm.target_triple == "x86_64-pc-windows-msvc") then
	config.font = font
	config.font_size = font_size
	config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
	config.native_macos_fullscreen_mode = true
	config.line_height = 1.3
	config.window_frame = {
		font_size = 14,
		active_titlebar_bg = "#393552",
		inactive_titlebar_bg = "#393552",
	}
else
	config.font_size = 10
end

config.default_cursor_style = "BlinkingBar"

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

local home = wezterm.home_dir
local background_image = home .. "/.local/share/wezterm.png"
config.background = {
	{
		source = {
			File = background_image,
		},
		hsb = { brightness = 0.1 },
		height = "Cover",
		horizontal_align = "Center",
	},
}
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.6,
}
config.audible_bell = "Disabled"
config.notification_handling = "SuppressFromFocusedTab"

config.scrollback_lines = 3500
config.leader = { key = "a", mods = "SUPER" }

config.keys = {
	{ key = "-", mods = "SHIFT|SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "SHIFT|SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{
		key = "o",
		mods = "SUPER",
		action = act.PaneSelect({
			mode = "SwapWithActiveKeepFocus",
			show_pane_ids = true,
		}),
	},

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

	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },

	{ key = "h", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "SUPER", action = act.ActivatePaneDirection("Down") },

	{
		key = "r",
		mods = "SUPER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
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
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },

		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
