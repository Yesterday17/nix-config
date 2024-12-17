{ inputs, config, pkgs, pkgs-unstable, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

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
  ];
  programs.bash.enable = true;
  programs.zsh = { enable = true; };
  programs.nushell = { enable = true; };

  programs.git = {
    enable = true;
    userName = "Yesterday17";
    userEmail = "mmf@mmf.moe";
    signing = {
      signByDefault = true;
      key = "E730A010ECDFB4890FF198983CB3DFA9524C0B90";
    };
  };

  programs.vscode = { enable = true; };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.kitty = { enable = true; };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "DP-4" "DP-5" ];
        modules-left =
          [ "hyprland/workspaces" "hyprland/submap" "wlr/taskbar" ];
        modules-center = [ ];
        modules-right = [ "temperature" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
      };
    };
  };

  programs.wofi = { enable = true; };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprtrails
    ];

    settings = {
      general = {
        layout = "master";

        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1;
        inactive_opacity = 0.9;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # Monitor structure
      #
      #  [DP5]
      #  [DP4]----mirror----[HDMI-A-1(TV)]
      monitor = [
        "DP-4, 3840x2160, 0x0, 2"
        "DP-5, 3840x2160, 0x-1080, 2"
        "HDMI-A-1, preferred, auto, 3, mirror, DP-4"
      ];

      # Using ALT as $mod
      "$mod" = "CTRL";
      bind = [
        "$mod SHIFT, K, exec, kitty"
        "$mod, Q, killactive"
        # "$mod, M, exit"
        "$mod, E, exec, dolphin"
        "$mod SHIFT, V, togglefloating"
        "$mod SHIFT, S, exec, hyprshot --mode=region --clipboard-only"

        # "$mod, L, "
        "$mod SHIFT, J, layoutmsg, cyclenext"
        "$mod SHIFT, K, layoutmsg, cycleprev"
        "$mod SHIFT, L, layoutmsg, swapwithmaster master"
        "$mod SHIFT, M, fullscreen"
        "$mod SHIFT, N, layoutmsg, orientationcycle"

        "$mod, space, exec, pkill wofi || wofi --show drun"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));
      # https://github.com/hyprwm/Hyprland/blob/3cec45d82113051d35e846e5d80719d8ea0f7002/example/hyprland.conf#L134-L145
      # TODO: use loop
      # workspace = [
      #   "w[t1], gapsout:0, gapsin:0"
      #   "w[tg1], gapsout:0, gapsin:0"
      #   "f[1], gapsout:0, gapsin:0"
      # ];

      layerrule = [ "noanim, wofi" ];
      # windowrulev2 = [
      #   "bordersize 0, floating:0, onworkspace:w[t1]"
      #   "rounding 0, floating:0, onworkspace:w[t1]"
      #   "bordersize 0, floating:0, onworkspace:w[tg1]"
      #   "rounding 0, floating:0, onworkspace:w[tg1]"
      #   "bordersize 0, floating:0, onworkspace:f[1]"
      #   "rounding 0, floating:0, onworkspace:f[1]"
      # ];

      master = {
        #new_is_master = true;
        #no_gaps_when_only = true;
        mfact = 0.7;
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;
    extensions = [ "nix" "toml" ];

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
            # path = lib.getExe pkgs.rust-analyzer;
            path_lookup = true;
          };
        };
        nix = { binary = { path_lookup = true; }; };
      };
      vim_mode = true;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "system";
        light = "Solarized Light";
        dark = "Solarized Dark";
      };
      show_whitespaces = "all";
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };
}
