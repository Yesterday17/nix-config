{ ... }:
{
  programs.nixvim = {
    plugins.copilot-lua = {
      enable = true;
      settings = {
        suggestion.enabled = false;
        panel.enabled = false;
      };
    };

    plugins.copilot-cmp = {
      enable = true;
    };
  };
}
