{ pkgs, ... }:
{
  imports = [
    ./home.nix
    ./direnv.nix
    ./font.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    ./lsd.nix
    ./neovim.nix
    ./vim.nix
    ./vscode.nix
    ./wezterm.nix
    ./yazi.nix
    ./zsh.nix
  ];
  home = {
    username = "cya";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/cya" else "/home/cya";
    packages = with pkgs; [ ];
    stateVersion = "25.11";
  };
}
