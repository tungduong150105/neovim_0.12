require("mini.diff").setup({})

vim.keymap.set("n", "<leader>gd", function() require("mini.diff").toggle_overlay(0) end) -- 0 = current buffer
