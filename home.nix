{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./home/gauntlet
    ./home/hyprland
    ./home/fcitx5
    # ./home/nixvim
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Allow unfree packages
    config = {
      allowUnfree = true;
      # cudaSupport = true;
    };
  };

  home.username = "yesterday17";
  home.homeDirectory = "/home/yesterday17";

  home.stateVersion = "24.11";
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
  #programs.plasma = {
  #  enable = true;
  #};

  home.packages = with pkgs; [
    htop
    fastfetch
    telegram-desktop
    prismlauncher
    jdk17

    unrar

    # nvchad

    gigafile

    # Required by Zed-Editor
    #
    # TODO: use extraPackages
    # https://github.com/nix-community/home-manager/blob/master/modules/programs/zed-editor.nix
    nixd

    bruno

    albert # Raycast alternative
    just
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
  };
  programs.nushell = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Yesterday17";
    userEmail = "mmf@mmf.moe";
    signing = {
      signByDefault = true;
      key = "E730A010ECDFB4890FF198983CB3DFA9524C0B90";
    };
    lfs.enable = true;
  };

  programs.vscode = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.kitty = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-4"
          "DP-5"
        ];
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "wlr/taskbar"
        ];
        modules-center = [ ];
        modules-right = [ "temperature" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    # package = pkgs.zed-editor;
    # extraPackages = with pkgs; [
    #   nixd
    #   nodejs
    # ];
    extensions = [
      "nix"
      "toml"
      "html"
      "dockerfile"
      "git-firefly"
      "sql"
      "svelte"
      "emmet"
      "astro"
      "graphql"
      "prisma"
      "biome" # not working
      "xml"
      "log"

      "tokyo-night"
      "night-owl-theme"
      "neosolarized"
    ];

    userSettings = {
      assistant = {
        enable = true;
        version = "2";
        default_open_ai_model = null;

        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
      };
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      hour_format = "hour24";
      auto_update = false;

      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
            # path_lookup = true;
          };
        };
        nix = {
          binary = {
            path = lib.getExe pkgs.nil;
            # path_lookup = true;
          };
        };
      };
      vim_mode = true;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "system";
        light = "NeoSolarized Light";
        dark = "One Dark";
      };
      show_whitespaces = "all";

      ui_font_family = "Noto Sans Mono";
      ui_font_size = 16;
      ui_font_weight = 500;

      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 16;
      buffer_font_weight = 500;
      buffer_font_features = {
        calt = true;
      };
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };
  programs.ghostty = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
  };
}
