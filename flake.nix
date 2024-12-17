{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations.nixos = let
      system = "x86_64-linux";
      special-args = { 
        inherit inputs;

        pkgs-unstable = import nixpkgs-unstable {
          system = sys;
          config.allowUnfree = true;
        };
      }; in nixpkgs.lib.nixosSystem rec {
      inherit system;

      specialArgs = special-args;
      modules = [
        ./configuration.nix
        ./desktop/hyprland.nix

        # home-manager
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = special-args;
          home-manager.users.yesterday17 = import ./home.nix;
        }

        # xremap
        # inputs.xremap-flake.nixosModules.default
        ./keyd.nix
      ];
    };
  };
}
