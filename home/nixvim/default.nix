{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymap.nix
    ./layout
    ./ui
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # colorschemes.dracula.enable = true;
    plugins.web-devicons.enable = true;

    diagnostics = {
      virtual_lines.only_current_line = true;
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
  };
}
