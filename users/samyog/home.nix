{ lib, pkgs, ... }: {

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
}
