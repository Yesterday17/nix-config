# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
inputs: pkgs: {
  # larksuite = pkgs.callPackage ./larksuite.nix { };
  # zed-editor = pkgs.callPackage ./zed { };
  navicat = pkgs.callPackage ./navicat.nix { };

  nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
  gigafile = pkgs.callPackage ./gigafile.nix { };
}
