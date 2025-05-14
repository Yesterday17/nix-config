{ inputs, ... }:
{
  imports = [ inputs.gauntlet.homeManagerModules.default ];
  programs.gauntlet = {
    enable = true;
    service.enable = true;
    config = { };
  };
}
