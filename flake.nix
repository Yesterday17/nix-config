{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gauntlet = {
      url = "github:project-gauntlet/gauntlet/v18";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (self) outputs;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays {
        inherit inputs;
        pkgs = nixpkgs;
      };

      nixosConfigurations.nixos =
        let
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
        in
        nixpkgs.lib.nixosSystem rec {
          inherit system specialArgs;

          modules = [
            ./configuration.nix
            ./desktop/hyprland.nix
            ./desktop/kde5.nix

            # home-manager
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users.yesterday17 = import ./home.nix;
              };
            }

            ./keyd.nix
          ];
        };
    };
}
