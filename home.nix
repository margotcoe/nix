{ config, pkgs, ... }:

{
  home.username = "margot";
  home.homeDirectory = "/home/margot";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  programs.git.enable = true;
  editorconfig.enable = true;

  imports = [
    ./user/sh.nix
   # ./user/neovim.nix
  ];

  home.packages = [
    pkgs.hello
    # Uncomment and add more packages if needed
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # Uncomment and add more files if needed
    # ".screenrc".source = ./dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # Uncomment and set environment variables if needed
    # EDITOR = "emacs";
  };
}
