-- Tags picker
vim.keymap.set("n", ";t", function() Snacks.picker.tags() end, { desc = "Tags" })

-- gf: tags picker pre-filtered by the word under the cursor.
-- Set per buffer after FileType so it overrides ftplugin `gf` mappings.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TagsGf", { clear = true }),
  callback = function(args)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end
      vim.keymap.set("n", "gf", function()
        local word = vim.fn.expand("<cword>")
        if word ~= "" then
          Snacks.picker.tags({ pattern = word })
        else
          pcall(vim.cmd, "normal! gf")
        end
      end, { buffer = args.buf, desc = "Go to tag" })
    end)
  end,
})

-- gutentags needs Universal Ctags (macOS /usr/bin/ctags is BSD ctags)
---@return string?
local function universal_ctags()
  for _, exe in ipairs({ "/opt/homebrew/bin/ctags", vim.fn.exepath("ctags") }) do
    if exe ~= "" and vim.fn.executable(exe) == 1 then
      local out = vim.system({ exe, "--version" }, { text = true }):wait()
      if out.code == 0 and out.stdout:find("Universal Ctags", 1, true) then
        return exe
      end
    end
  end
end

local ctags = universal_ctags()
vim.g.gutentags_enabled = ctags and 1 or 0
if not ctags then
  return
end

vim.g.gutentags_ctags_executable = ctags
vim.g.gutentags_project_root = { ".git", "Gemfile", "Makefile", "package.json" }
vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/nvim/ctags")
vim.g.gutentags_ctags_extra_args = { "--extras=+q", "--languages=ruby" }
