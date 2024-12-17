{ config, pkgs, ... }:

{
  services.xremap = {
    serviceMode = "user";
    userName = "yesterday17";

    # Enable wlroots-based support
    withWlroots = true;
    # Non-wlroots based hyprland support
    # seems not working though
    # withHypr = true;

    config.modmap = [{
      name = "Global";
      remap = { "CapsLock" = "Esc"; }; # globally remap CapsLock to Esc
    }];

    config.keymap = [{
      name = "Alt-C";
      remap = {
        "M-c" = "C-c";
        "M-v" = "C-v";
        "M-z" = "C-z";
        "M-x" = "C-x";
        "M-t" = "C-t";
        "M-a" = "C-a";
      };
    }];
  };
}
