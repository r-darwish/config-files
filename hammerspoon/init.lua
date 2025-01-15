local HyperShortcuts = {
	{ "S", "Slack" },
	{ "F", "Firefox" },
	{ "T", "Kitty" },
	{ "W", "WhatsApp" },
	{ "M", "Spotify" },
	{ "G", "Signal" },
}

for _, shortcut in ipairs(HyperShortcuts) do
	hs.hotkey.bind({ "ctrl", "alt", "shift", "cmd" }, shortcut[1], function()
		hs.application.launchOrFocus(shortcut[2])
	end)
end
