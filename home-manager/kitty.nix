{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    autoThemeFiles = {
      light = "GitHub";
      dark = "Tomorrow_Night_Bright";
      noPreference = "OneDark";
    };
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 14;
    };
    settings = {
      modify_font = "cell_width 90%";
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      window_padding_width = 12;
      macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = "yes";
      background_opacity = 0.90;
      background_blur = 15;
      wayland_enable = true;
      linux_display_server = "wayland";
      allow_remote_control = "yes";
      disable_compositor_software_fallback = "yes";
    };
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      mode = "no-cursor";
    };
  };
}
