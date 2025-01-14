{ ... }:
{
  imports = [
    ./dressing.nix # UI beautify
    ./theme.nix
  ];

  options = {
    number = true;
    relativenumber = true;

    # tab width
    shiftwidth = 2; # TODO: move to editor settings
  };
}
