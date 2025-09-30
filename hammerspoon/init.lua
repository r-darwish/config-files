local HyperShortcuts = {
	{ "S", "Slack" },
	{ "B", "Vivaldi" },
	{ "N", "Neovide" },
	{ "T", "Ghostty" },
	{ "W", "WhatsApp" },
	{ "M", "Spotify" },
	{ "G", "Signal" },
	{ "Z", "zoom.us" },
	{ "O", "Obsidian" },
}

for _, shortcut in ipairs(HyperShortcuts) do
	hs.hotkey.bind({ "ctrl", "alt", "shift", "cmd" }, shortcut[1], function()
		hs.application.launchOrFocus(shortcut[2])
	end)
end
