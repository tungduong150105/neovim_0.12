require("snacks").setup({
  indent = { enabled = true },
  scroll = { enabled = false },
  picker = {
    enabled = true,
    sources = {
      files = { hidden = true },
      grep = { hidden = true },
      explorer = { hidden = true, ignored = true },
    },
    layouts = {
      default = { layout = { width = 0.9, height = 0.9 } },
    }
  },
  notifier = { enabled = true },
  statuscolumn = { enabled = false },
  words = { enabled = true },
  explore = { enabled = true },
  input = { enabled = true },
  lazygit = {
    enabled = true,
		configure = true,
  },
})

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end)
vim.keymap.set("n", ";f", function() Snacks.picker.files() end)
vim.keymap.set("n", ";r", function() Snacks.picker.grep() end)
vim.keymap.set("n", ";d", function() Snacks.picker.diagnostics_buffer() end)

vim.keymap.set("n", "<C-b>", function() Snacks.explorer() end)

vim.keymap.set("n", ";g", function() Snacks.lazygit() end)
