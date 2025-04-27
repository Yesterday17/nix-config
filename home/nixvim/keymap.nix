{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        key = "<C-e>";
        action = "5<C-e>";
      }
      {
        key = "<C-y>";
        action = "5<C-y>";
      }
    ];
  };
}
