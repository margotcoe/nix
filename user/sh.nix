{ config, pkgs, ... }:
let

  myAliases = {
    la = "ls -la";
    dotdot = "cd ~/.dotfiles";

  };
in {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
      PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
       %F{green}→%f "
      RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    '';
  };

  home.packages = with pkgs; [
    bottom
    tree

  ];

  programs.nix-index.enableZshIntegration = true;

}
