--- Input device default settings ---
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
			clickfinger_behavior = true,
			disable_while_typing = true,
			drag_lock = true,
		},
	},
})
--- Cursor input devices ---
hl.device({
	name = "your-epic-mouse-v1",
	sensitivity = -0.5,
})
--- Gestures ---
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
