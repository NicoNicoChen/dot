{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      nerd-fonts.noto
      nerd-fonts.hack
      nerd-fonts.ubuntu
      nerd-fonts.iosevka
      nerd-fonts.zed-mono
      nerd-fonts.mononoki
      nerd-fonts.meslo-lg
      nerd-fonts.monaspace
      nerd-fonts.fira-mono
      nerd-fonts.fira-code
      nerd-fonts.blex-mono
      nerd-fonts.victor-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.roboto-mono
      nerd-fonts.symbols-only
      nerd-fonts.terminess-ttf
      nerd-fonts.jetbrains-mono
      sarasa-gothic
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
      noto-fonts-color-emoji
      font-awesome
    ];
  };
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "Sarasa Mono TC"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans"
          "Sarasa Gothic TC"
          "Noto Color Emoji"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK TC"
          "Noto Color Emoji"
        ];
        emoji = [
          "Noto Color Emoji"
          "Noto Emoji"
        ];
      };
    };
  };
}
