{
  inputs,
  config,
  pkgs,
  ...
}:

{
  # Enable the KDE Plasma Desktop Environment.

  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  i18n.inputMethod.fcitx5.plasma6Support = true;

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  # ];

  # If you want to use the KDE Plasma 5 Desktop Environment, use the following
  # services.xserver.desktopManager.plasma5.enable = true;
}
