{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.transparent.enable = true;

    extraPlugins = with pkgs.vimPlugins; [ nvim-solarized-lua ];
    colorscheme = "solarized-flat";

    opts = {
      background = "light";
      cursorline = true;

      # n  Normal mode
      # v  Visual mode
      # ve Visual mode with 'selection' "exclusive" (same as 'v', if not specified)
      # o  Operator-pending mode
      # i  Insert mode
      # r  Replace mode
      # c  Command-line Normal (append) mode
      # ci Command-line Insert mode
      # cr Command-line Replace mode
      # sm showmatch in Insert mode
      # t  Terminal mode
      # a  all modes
      guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor-blinkwait300-blinkon200-blinkoff200";
    };

    highlight = {
      Cursor = {
        fg = "grey";
        bg = "grey";
      };
    };
  };
}
