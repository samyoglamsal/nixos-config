{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs = {	
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { 
      	inherit system; 
	config.allowUnfree = true;
      };
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system pkgs;
        modules = [ 
	  ./modules/nixos/configuration.nix 
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit inputs; };
	    home-manager.users.samyog = ./users/samyog/home.nix;
	  }
	];
      };
    };
  };
}
