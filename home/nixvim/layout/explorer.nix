# https://github.com/mikavilpas/yazi.nvim
# https://github.com/nix-community/nixvim/blob/main/plugins/by-name/yazi/default.nix
{ ... }:
{
  programs.nixvim = {
    plugins.yazi = {
      enable = true;
      settings = {
        open_for_directories = true;
        enable_mouse_support = true;
        floating_window_scaling_factor = 0.7; # default is 0.9

        use_ya_for_events_reading = true;
        use_yazi_client_id_flag = true;

        keymaps = {
          open_file_in_tab = "<CR>";
        };
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        action = ":Yazi toggle<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle Yazi";
        };
      }
    ];
  };

  programs.yazi = {
    enable = true;
    keymap = {
      manager.prepend_keymap = [
        # use <leader>e to toggle yazi
        {
          run = "quit";
          on = [
            " "
            "e"
          ];
        }
      ];
    };
  };
}
