{
  nixvim,
  ...
}:
nixvim.plugins.mkNeovimPlugin {
  name = "tabby";
  packPathName = "tabby.nvim";
  url = "https://github.com/nanozuki/tabby.nvim";
  package = "tabby-nvim";

  description = "A declarative, highly configurable, and neovim style tabline plugin. Use your nvim tabs as a workspace multiplexer!";

  settingsOptions = {

  };

  settingsExample = {
  };
}
