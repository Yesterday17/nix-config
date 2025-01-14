{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp-format.enable = true;

    plugins.lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        bashls.enable = true;
        nixd.enable = true;

        lua_ls.enable = true;
        markdown_oxide.enable = true;

        html.enable = true;
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };

    extraPackages = with pkgs; [ vtsls ];
    extraConfigLua = ''
      require("lspconfig").vtsls.setup({})
    '';
  };
}
