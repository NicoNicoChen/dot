local wezterm = require("wezterm")
local config = wezterm.config_builder()

if wezterm.target_triple:find("x86_64-pc-windows-msvc") then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
	config.font_size = 9
	config.freetype_load_target = "HorizontalLcd"
	config.freetype_render_target = "HorizontalLcd"
elseif wezterm.target_triple:find("x86_64-unknown-linux-gnu") then
	config.font_size = 10
elseif wezterm.target_triple:find("x86_64-apple-darwin") or wezterm.target_triple:find("aarch64-apple-darwin") then
	config.font_size = 15
	config.front_end = "OpenGL"
	config.freetype_load_target = "Light"
	config.freetype_render_target = "HorizontalLcd"
	config.cell_width = 0.9
end

config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "Bold" },
	"Sarasa Term TC",
	"Microsoft JhengHei",
	"Noto Sans TC",
	"PingFang TC",
})
config.line_height = 1.1
config.initial_cols = 120
config.initial_rows = 30
config.color_scheme = "Tomorrow Night Bright"
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = true

return config
