local cursorHyprTheme = "Nordzy-hyprcursors-white"
local cursorXTheme = "Nordzy-cursors-white"
local cursorSize = 32

--- Autostart ---
hl.on("hyprland.start", function()
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)
	hl.exec_cmd("qs & awww-daemon")
end)

--- Environment variables ---
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Adwaita:light")
hl.env("HYPRCURSOR_THEME", cursorHyprTheme)
hl.env("XCURSOR_THEME", cursorXTheme)
hl.env("XCURSOR_SIZE", "" .. cursorSize)
hl.env("HYPRCURSOR_SIZE", "" .. cursorSize)
