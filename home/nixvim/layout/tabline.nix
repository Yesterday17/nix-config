{ pkgs, ... }:
{
  programs.nixvim = {
    # Always show the tabline
    opts.showtabline = 2;

    # https://nixos.wiki/wiki/Neovim#Note_on_Lua_plugins
    # https://github.com/nanozuki/tabby.nvim
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = tabby-nvim;
        config = ''
          packadd! tabby.nvim
          lua << END
          require('tabby').setup({
            preset = 'active_wins_at_tail',
            option = {
              lualine_theme = 'rose-pine',
            },
          })
          END
        '';
      }
    ];
  };
}
