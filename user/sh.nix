{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      dotdot = "cd ~/.dotfiles";
      source-zsh = "source /home/margot/.config/zsh/.zshrc";
      home-switch = "home-manager switch --flake .";
      flake-switch = "sudo nixos-rebuild switch --flake .#Media";
   };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man"  ];

    };
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.oh-my-posh;  # Ensure this package is available

    # Option to use built-in theme
    useTheme = "catppuccin";

  };




  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    extraOptions = [ "--group-directories-first" "--header" ];
  };

   programs.fzf = {
     enable = true;
     enableZshIntegration = true;
   };

  # Scripts (Uncomment and configure if needed)
  # home.file.".config/zsh/scripts".source = ./files/scripts;
  # home.file.".config/zsh/scripts".recursive = true;
}
