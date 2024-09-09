{
  description = "My First Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux"; # Define your system type
    pkgs = nixpkgs.legacyPackages.${system};  
    lib = nixpkgs.lib; # Add this line to import lib
  in rec {
    nixosConfigurations = {
      Media = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          ./media.nix
          ({ pkgs, lib, ... }: {
            # Add your options here
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.channel.enable = false;
            environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
            nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
          })
        ];
      };
    homeConfigurations = {
      margot = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
 };
}
