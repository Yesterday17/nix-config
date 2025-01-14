{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ nvim-solarized-lua ];
    colorscheme = "solarized";

    opts.background = "light";
  };
}
