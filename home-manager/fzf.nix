{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--border"
      "--height 48%"
    ];
  };
}
