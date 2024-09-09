{
  description = "My First Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        Media = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
          #  ./media.nix
            {
              # Add your configuration options here
           #   media_server.enable = true;
           #   nixpkgs.config.allowUnfree = true;
            }
          ];
          specialArgs = {
            inherit pkgs;
          };
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
