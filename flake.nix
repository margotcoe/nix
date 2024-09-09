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
  in rec {
    nixosConfigurations = {
      Media = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./media.nix ];
        specialArgs = { inherit pkgs; };
  #      configuration = { media_server.enable = true; };
      };
    };

    homeConfigurations = {
      margot = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
