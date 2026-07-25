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

  services.kanshi = {
    enable = true;

    profiles = {
      nixos = {
	outputs = [
	  {
	    criteria = "DP-2";
	    mode = "2560x1440@165Hz";
	    position = "1920,0";
	  }
	  {
	    criteria = "DP-1";
	    mode = "1920x1080@165Hz";
	    position = "0,0";
	  }
	];
      };
    };
  };
}
