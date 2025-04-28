{ pkgs, ... }:

{
  imports = [
    ./copilot.nix
    ./cmp.nix
  ];

  programs.nixvim = {
    opts.laststatus = 3;

    plugins.avante = {
      enable = true;

      settings = {
        # provider = "claude";
        auto_suggestions_frequency = "copilot";
        hints.enabled = true;

        # https://github.com/yetone/avante.nvim/issues/733#issuecomment-2566145668
        provider = "copilotclaude";
        vendors = {
          copilotclaude = {
            __inherited_from = "copilot";
            api_key_name = "<GITHUB_TOKEN>";
            model = "claude-3.7-sonnet";
            max_tokens = 4096;
          };
        };
      };
    };
  };
}
