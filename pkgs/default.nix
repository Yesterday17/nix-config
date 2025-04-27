# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # larksuite = pkgs.callPackage ./larksuite.nix { };
  # zed-editor = pkgs.callPackage ./zed { };
  navicat = pkgs.callPackage ./navicat.nix { };
}
