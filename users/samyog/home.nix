{ lib, pkgs, ... }: 
let
  mod = "Mod4";
in
{

  xdg = {
    enable = true;
    configFile = {
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
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = mod;
    };
  };
}
