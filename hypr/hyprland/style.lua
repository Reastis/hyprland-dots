local default_layout = "dwindle"

--- Style settings ---
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 0,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(dc143cff)", "rgba(f75270ff)" }, angle = 90 },
			inactive_border = "rgba(33788e00)",
		},

		resize_on_border = false,

		allow_tearing = false,

		layout = default_layout,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	decoration = {
		rounding = 15,
		rounding_power = 3,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0x1a1a1aff,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})
