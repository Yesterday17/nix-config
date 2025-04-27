{ ... }:
{
  imports = [
    ./theme.nix
    ./dressing.nix # UI beautify
    ./which-key.nix
    ./telescope.nix
  ];

  programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;

      # tab width
      shiftwidth = 2; # TODO: move to editor settings
    };
  };
}
