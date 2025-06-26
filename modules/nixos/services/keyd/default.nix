{ ... }:

{
  services.keyd = {
    enable = true;

    keyboards = {
      default = {
        ids = [ "*" ];

        settings = {
          main = {
            leftalt = "layer(meta_mac)";
            # leftmeta = "alt";

            capslock = "layer(caps_super)";
          };
          "meta_mac:C" = {
            # Switch directly to an open tab (e.g. Firefox, VS code)
            # "1" = "A-1";
            # 2 = A-2
            # 3 = A-3
            # 4 = A-4
            # 5 = A-5
            # 6 = A-6
            # 7 = A-7
            # 8 = A-8
            # 9 = A-9

            # Copy
            c = "C-insert";
            # Paste
            v = "S-insert";
            # Cut
            x = "S-delete";

            # Some shortcuts are not mapped to Ctrl-*
            # Used as `$rawMod` in hyprland
            l = "A-l";
            # f = "A-f";
            j = "A-j";
            i = "A-i";
            space = "A-space";

            # on hyprland:
            # tab = "A-tab";
            # on kde:
            tab = "swapm(app_switch_state, A-tab)";
          };
          "app_switch_state:A" = {
            "tab" = "A-tab";
            "right" = "A-tab";
            "`" = "A-S-tab";
            "esc" = "A-S-tab";
          };
          "caps_super:M" = {
            #
          };
        };
      };
    };
    # config.modmap = [
    #   {
    #     name = "Global";
    #     remap = { "CapsLock" = "Esc"; }; # globally remap CapsLock to Esc
    #   }
    # ];

    # config.keymap = [
    #   {
    #     name = "Alt-C";
    #     remap = {
    #       "M-c" = "C-c";
    #       "M-v" = "C-v";
    #       "M-z" = "C-z";
    #       "M-x" = "C-x";
    #       "M-t" = "C-t";
    #       "M-a" = "C-a";
    #     };
    #   }
    # ];
  };
}
