require("nvim-treesitter").install({
  "lua",
  "ruby",
  "json",
  "yaml",
  "markdown",
  "javascript",
  "vue",
  "pug",
  "css",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
   "lua",
    "json",
    "yaml",
    "markdown",
    "javascript",
    "vue",
    "pug",
    "css",
  },
  callback = function(args)
    vim.treesitter.start(args.buf)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function(args)
    vim.treesitter.start(args.buf)
    vim.opt_local.indentkeys:remove(".")
  end,
})
