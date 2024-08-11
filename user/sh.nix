{ config, pkgs, ... }:
let
  myAliases = {
    la = "eza -la";
    ls = "eza";
    dotdot = "cd ~/.dotfiles";
    tree = "eza -T";
  };
in {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

    # Enable oh-my-zsh
    oh-my-zsh.enable = true;

    # Configure oh-my-zsh plugins
    oh-my-zsh.plugins = [ "git" "thefuck" ];

    # Set a theme for oh-my-zsh
    oh-my-zsh.theme = "robbyrussell";

    # Optionally, add custom configuration
    oh-my-zsh.custom = ''
      # Custom oh-my-zsh configurations
    '';

    # Optionally, specify a custom package if needed
    oh-my-zsh.package = pkgs.oh-my-zsh;

    # Optionally, provide additional configuration files
    oh-my-zsh.extraConfig = ''
      # Additional configuration
    '';



  home.packages = with pkgs; [
    bottom
    tree
    zsh-autosuggestions

  ];

  programs.nix-index.enableZshIntegration = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    # icons = true;
    extraOptions = [ "--group-directories-first" "--header" ];
  };
}
