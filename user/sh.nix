{ config, pkgs, ... }:
let
  myAliases = {
    la = "ls -la";
    dotdot = "cd ~/.dotfiles";
  };
in {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
      autoload -Uz vcs_info
      precmd() {
        vcs_info
        PROMPT="◉ %F{pink}%n%f@%F{cyan}%m%f:%F{magenta}%~%f ${vcs_info_msg_0_} %F{lightgreen}→%f "
      }
      RPROMPT="%F{lightyellow}%D{%H:%M:%S}%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    '';
  };

  home.packages = with pkgs; [
    bottom
    tree
    zsh-autosuggestions
  ];

  programs.nix-index.enableZshIntegration = true;
}
