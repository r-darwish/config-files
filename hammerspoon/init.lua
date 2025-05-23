local HyperShortcuts = {
	{ "S", "Slack" },
	{ "B", "Vivaldi" },
	{ "H", "Gemini" },
	{ "T", "Kitty" },
	{ "W", "WhatsApp" },
	{ "M", "Spotify" },
	{ "G", "Signal" },
	{ "Z", "zoom.us" },
	{ "N", "Neovide" },
	{ "O", "Obsidian" },
}

for _, shortcut in ipairs(HyperShortcuts) do
	hs.hotkey.bind({ "ctrl", "alt", "shift", "cmd" }, shortcut[1], function()
		hs.application.launchOrFocus(shortcut[2])
	end)
end
