# This file defines overlays
{ inputs, pkgs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs inputs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    avante = prev.vimPlugins.avante-nvim.overrideAttrs (_: {
      src = prev.fetchFromGitHub {
        owner = "yetone";
        repo = "avante.nvim";
        rev = "bd8afce3b0cac6e3d5e1a409692975199be38b81";
        sha256 = "sha256-wlqLxYB6QjFOf81/OjW6fg4xsAnueu+6qUmwkvMMk90=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
