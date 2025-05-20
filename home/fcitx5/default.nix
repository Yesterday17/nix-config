{ inputs, pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;
      # plasma6Support = true;
      addons = with pkgs; [
        rime-data
        fcitx5-gtk
        fcitx5-mozc
        # japanese input
        fcitx5-rime
      ];

      ignoreUserConfig = false;
      settings = {
        globalOptions = {
          Behavior = {
            # 默认状态为激活
            ActiveByDefault = false;
          };
          Hotkey = {
            # 反复按切换键时进行轮换
            EnumerateWithTriggerKeys = true;
            # 轮换输入法时跳过第一个输入法
            EnumerateSkipFirst = false;
            # 触发修饰键快捷键的时限 (毫秒)
            ModifierOnlyKeyTimeout = 250;
          };
          "HotKey/TriggerKeys"."0" = "Control+space";
          "HotKey/AltTriggerKeys"."0" = "Super+Super_L";
          "Hotkey/PrevPage"."0" = "Up";
          "Hotkey/NextPage"."0" = "Down";
        };
        inputMethod = {
          GroupOrder = {
            "0" = "Default";
          };
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0".Name = "rime";
          "Groups/0/Items/1".Name = "keyboard-us";
          "Groups/0/Items/2".Name = "mozc";
        };
      };
    };
  };
}
