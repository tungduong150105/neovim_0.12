if vim.loader then
  vim.loader.enable()
end

_G.Neovim = require("utils")

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("plugins")
