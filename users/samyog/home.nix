{ config, lib, pkgs, inputs, ... }: 
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles";
in
{

  xdg = {
    enable = true;
    configFile = {
      nvim.source = "${dotfiles}/nvim";
      sway.source = "${dotfiles}/sway";
      tmux.source = "${dotfiles}/tmux";
      ghostty.source = "${dotfiles}/ghostty";
      xoszsh.source = "${dotfiles}/zsh";
    };
  };

  home = {
    username = "samyog";
    homeDirectory = "/home/samyog";
    stateVersion = "26.05";

    packages = with pkgs; [
      claude-code 
      ripgrep
      fd
      wmenu
      clang-tools
      gcc
      swaybg
      ghostty
      fzf
      nerd-fonts.caskaydia-mono
    ];
  };
}
