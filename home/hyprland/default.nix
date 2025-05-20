{ inputs, pkgs, ... }:
{
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
        inactive_opacity = 0.95;

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
      "$rawMod" = "ALT";
      bind =
        [
          "$mod SHIFT, K, exec, kitty"
          "$mod, Q, killactive"
          # "$mod, M, exit"
          "$mod, E, exec, dolphin"
          "$mod SHIFT, V, togglefloating"
          "$mod SHIFT, S, exec, hyprshot --mode=region --clipboard-only"

          "$rawMod, Tab, layoutmsg, cyclenext"
          "$rawMod SHIFT, Tab, layoutmsg, cycleprev"
          "$rawMod, L, layoutmsg, swapwithmaster master"

          # "$mod, mouse_down, workspace, e-1"
          "$mod SHIFT, M, fullscreen"
          "$mod SHIFT, N, layoutmsg, orientationcycle"

          "$rawMod, space, exec, albert toggle"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
      # https://github.com/hyprwm/Hyprland/blob/3cec45d82113051d35e846e5d80719d8ea0f7002/example/hyprland.conf#L134-L145
      # TODO: use loop
      # workspace = [
      #   "w[t1], gapsout:0, gapsin:0"
      #   "w[tg1], gapsout:0, gapsin:0"
      #   "f[1], gapsout:0, gapsin:0"
      # ];

      layerrule = [
        # "noanim, wofi"
      ];
      windowrulev2 = [
        "noanim, class:^.*(pinentry).*$"
        "noborder, title:^.*(Albert).*$"
        "nodim, title:^.*(Albert).*$"
      ];
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
}
