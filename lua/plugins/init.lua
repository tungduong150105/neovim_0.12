vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim.git" },
  -- { src = "https://github.com/craftzdog/solarized-osaka.nvim" },
  { src = "https://github.com/tungduong150105/solarized.nvim.git" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/b0o/incline.nvim.git" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.pairs" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/folke/noice.nvim.git" },
  { src = "https://github.com/MunifTanjim/nui.nvim.git" },
  { src = "https://github.com/zbirenbaum/copilot.lua.git" },
  { src = "https://github.com/nvim-mini/mini.diff.git" },
  { src = "http://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/vim-test/vim-test" },
  { src = "https://github.com/ludovicchabant/vim-gutentags" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require("plugins.snacks")
-- require("plugins.solarized-osaka")
require("plugins.solarized-nvim")
require("plugins.nvim-treesitter")
require("plugins.mini-icons")
require("plugins.lualine")
require("plugins.incline")
require("plugins.nvim-lspconfig")
require("plugins.blink-pairs")
require("plugins.blink-cmp")
require("plugins.noice")
require("plugins.copilot")
require("plugins.mini-diff")
require("plugins.gitsigns")
require("plugins.vim-test")
require("plugins.gutentags")
require("plugins.render-markdown")
