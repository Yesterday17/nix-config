{ inputs, pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.plasma6Support = true;
    fcitx5.addons = with pkgs; [
      rime-data
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-rime
    ];
  };
}
