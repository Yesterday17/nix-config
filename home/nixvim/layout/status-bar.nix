{ ... }:
{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
    };

    # I tried lightline but it was not working as expected.
    # 1. It has a builtin tabline, which I don't want.
    # 2. It doesn't change colorscheme when background changes.
    #
    plugins.lightline = {
      enable = true;
      settings = {
        colorscheme = "solarized";
        enable = {
          statusline = true;
          # Do not use tabline provided by lightline
          tabline = false;
        };
      };
    };

    # https://github.com/itchyny/lightline.vim/issues/680#issuecomment-2254283734
    # autocmd OptionSet background
    #       \ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/PaperColor.vim')
    #       \ | call lightline#colorscheme() | call lightline#update()
    # autoCmd = [
    #   {
    #     description = "Change lightline colorscheme when background changes";
    #     event = [ "OptionSet" ];
    #     pattern = [ "background" ];
    #     command = ''
    #       execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/PaperColor.vim') | call lightline#colorscheme() | call lightline#update()
    #     '';
    #   }
    # ];
  };
}
