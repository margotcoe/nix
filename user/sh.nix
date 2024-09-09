{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    shellAliases = {
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      dotdot = "cd ~/.dotfiles";
    };

# Other configurations...
    plugins = with pkgs; [
    {
      name = "agkozak-zsh-prompt";
      src = fetchFromGitHub {
        owner = "agkozak";
        repo = "agkozak-zsh-prompt";
        rev = "v3.7.0";
        sha256 = "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed";
      };
      file = "agkozak-zsh-prompt.plugin.zsh";
    }
    {
      name = "formarks";
      src = fetchFromGitHub {
        owner = "wfxr";
        repo = "formarks";
        rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
        sha256 = "c0218091002b990111585c60d05bce719b2fb5248e7631cb9d52566e047967be";
      };
      file = "formarks.plugin.zsh";
    }
    {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "e69db483e20228b72ccfa401e9ad6cf80d6edb48c68acca9102b50b311821b84";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "fa744fa30e26d587b98d799675b828ba20aa8242002a91054113cb0333aac529";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "18100902019c2eb2399d21b109790808cf545ebdf08ffb94598b9a32466323f0";
        };
        file = "autopair.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "ccd97fe9d7250b634683c651ef8a2fe3513ea917d1b491e8696a2a352b714f08";
        };
        file = "zsh-autosuggestions.zsh";
      }
    ];
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.oh-my-posh;  # Ensure this package is available

    # Option to use built-in theme
    useTheme = "catppuccin";

    # Option to use custom settings file (comment out if using a built-in theme)
    # settings = {
    #   configFile = "${config.home.homeDirectory}/.config/oh-my-posh/themes/catppuccin.omp.json";
    # };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    extraOptions = [ "--group-directories-first" "--header" ];
  };

  # Uncomment and configure fzf if needed
  # programs.fzf = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  # Scripts (Uncomment and configure if needed)
  # home.file.".config/zsh/scripts".source = ./files/scripts;
  # home.file.".config/zsh/scripts".recursive = true;
}
