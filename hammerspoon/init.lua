local HyperShortcuts = {
	{ "S", "Slack" },
	{ "V", "Vivaldi" },
	{ "B", "Mullvad Browser" },
	{ "H", "Gemini" },
	{ "T", "Ghostty" },
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
