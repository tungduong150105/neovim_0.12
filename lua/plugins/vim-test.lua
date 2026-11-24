-- Run tests in a snacks terminal at the bottom; reuse one window per run.
---@type snacks.win?
local term

vim.g["test#custom_strategies"] = {
  snacks = function(cmd)
    if term and term:valid() then
      term:close()
    end
    term = Snacks.terminal.open(cmd, {
      interactive = false, -- keep the output open after the run finishes
      win = { position = "bottom", height = 0.3 },
    })
  end,
}
vim.g["test#strategy"] = "snacks"

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test nearest" })
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test file" })
vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "Test suite" })
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test last" })
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "Visit last test file" })
