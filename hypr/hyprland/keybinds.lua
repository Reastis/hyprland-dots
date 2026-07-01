local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun"

local mainMod = "SUPER"
local scripts = "$HOME/.config/hypr/hyprland/scripts/"

--- Session shutdown ---
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

--- Hyprland config reload ---
hl.bind(mainMod .. " + SHIFT + R", function()
	hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
	hl.dispatch(hl.dsp.exec_cmd("notify-send 'Hyprland config' 'Config has been reloaded.'"))
end)

--- Launch main programs ---
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

--- Basic window manipulations ---
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

--- Window fullscreen switching ---
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

--- Move focus with mainMod + arrow keys ---
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

--- Workspaces 0-9 + window movement ---
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

--- Special workspaces (pindesk + discord) ---
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("pindesk"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:pindesk" }))

hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(
	mainMod .. " + SHIFT + D",
	hl.dsp.window.move({ workspace = "special:discord", follow = false, window = "class:^(discord|vesktop)$" })
)

--- Scroll through main workspaces with mouse ---
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

--- Move/resize windows with LMB/RMB and drag ---
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--- Dwindle keybinds ---
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

--- Local layout toggle bind (dwindle <-> scrolling) ---
hl.bind(mainMod .. " + L", function()
	local workspace = hl.get_active_workspace()
	local workspace_id = workspace.id
	local workspace_layout = workspace.tiled_layout
	local layout_switch = workspace_layout == "dwindle" and "scrolling" or "dwindle"
	hl.dispatch(
		hl.dsp.exec_cmd(
			"notify-send 'Layout change' 'Workspace " .. workspace_id .. " layout set to " .. layout_switch .. ".'"
		)
	)
	hl.workspace_rule({ workspace = workspace_id, layout = layout_switch })
end)

--- Laptop multimedia keys for volume and LCD brightness ---
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

--- Play,next,previous,pause ---
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--- Screenshots using grim + slurp ---
hl.bind("print", hl.dsp.exec_cmd(scripts .. "screenshot c"))
hl.bind("SHIFT + print", hl.dsp.exec_cmd(scripts .. "screenshot cf"))
hl.bind("CTRL + print", hl.dsp.exec_cmd(scripts .. "screenshot rc"))
hl.bind("CTRL + SHIFT + print", hl.dsp.exec_cmd(scripts .. "screenshot rcf"))
