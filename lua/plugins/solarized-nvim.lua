require("solarized").setup({})

vim.opt.background = "light"
vim.cmd[[colorscheme solarized]]

-- Tabline (colors come from the solarized palette, so set it up after the colorscheme)
Neovim.tabline.setup()

vim.o.showtabline = 1
vim.o.tabline = "%!v:lua.require('utils.tabline').render()"
