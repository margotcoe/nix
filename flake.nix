{
  description = "My First Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        hallelujah = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./media.nix  # Include your media module here
          ];
          # This should be removed as it's causing the error
          # configuration = {
          #   media_server.enable = true;  # Enable media server services
          # };
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
