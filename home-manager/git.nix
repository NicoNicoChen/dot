{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
