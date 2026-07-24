{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs = {	
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./modules/nixos/configuration.nix ];
      };
    };
  };
}
