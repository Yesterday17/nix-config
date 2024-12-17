{ inputs, config, pkgs, ... }:

{
  nix.settings.substituters = ["https://hyprland.cachix.org"];
  nix.settings.trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}