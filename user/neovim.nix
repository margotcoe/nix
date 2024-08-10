{ config, pkgs, lib, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = "1.0";  # Add a version string or commit hash here
    src = pkgs.fetchFromGitHub {
      owner = "sts10";
      repo = "vim-pink-moon";
      rev = "master";  # You can specify a commit hash or tag here if needed
      sha256 = "1rfcqi43y9vk5cb8412q5zdjv8i74s9a0y7j8qv262p8c4xnzqsj";  # Replace with your generated hash
    };
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
      mini-nvim
     (fromGitHub "main" "sts10/vim-pink-moon")
    ];
  };
}
