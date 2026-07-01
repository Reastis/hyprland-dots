--- Window rules ---
hl.window_rule({
	-- Hyprland-run windowrule
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	-- Ignore maximize requests from all apps
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = {
		class = "xwaylandvideobridge",
	},
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = 0.0,
})

hl.window_rule({
	name = "launch-discord-in-workspace",
	match = { class = "^(discord|vesktop)$" },
	workspace = "special:discord silent",
})

--- Workspace rules ---
hl.workspace_rule({ workspace = "special:pindesk", layout = "scrolling", layout_opts = { direction = "right" } })
