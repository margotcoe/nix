{ config, pkgs, ... }:
let
  myAliases = {
    la = "eza -la";
    ls = "eza";
    dotdot = "cd ~/.dotfiles";
  };
in {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
      PROMPT=" ◉ %F{pink}%n%f@%U%F{blue}%m%f%u:%F{yellow}%~%f
       %F{green}→%f "
      RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

      # Load zsh-autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    '';
  };

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
    extraOptions = 
      [
      "--group-directories-first"
      
      ];
   };
}
