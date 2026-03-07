{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    mise = {
      enable = true;
    };
    nix-direnv = {
      enable = true;
    };
  };
}
