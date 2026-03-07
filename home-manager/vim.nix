{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = false;
  };
  programs.vim-vint = {
    enable = true;
  };
  home.file.".vim/vimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dot/config/vim/init.vim";
}
