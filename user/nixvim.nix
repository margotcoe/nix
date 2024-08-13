{ pkgs, lib, ... }:
{
    # ...
    inputs.nixvim = {
       url = "github:nix-community/nixvim/nixos-24.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
}
