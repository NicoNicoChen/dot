{ pkgs, username, ... }:
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
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
    packages = with pkgs; [ ];
    stateVersion = "25.11";
  };
}
