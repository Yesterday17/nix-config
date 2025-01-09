{
  inputs,
  config,
  pkgs,
  ...
}:

{
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;

  services.displayManager.sddm = {
    enable = true;
    #enableHidpi = true;
    #wayland.enable = true;
  };

  # services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;

  #i18n.inputMethod.fcitx5.plasma6Support = true;
}
