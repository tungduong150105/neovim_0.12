-- Let lua_ls see the Neovim runtime and every active vim.pack plugin.
-- Without the plugins, `require("snacks")` gets matched by file name against
-- lua/plugins/snacks.lua and lua_ls reports `different-requires`.
local library = { vim.env.VIMRUNTIME }
for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
  if plugin.active then
    library[#library + 1] = plugin.path
  end
end

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        -- Resolve modules the way Neovim does: <root>/lua/<module>.lua
        path = { "lua/?.lua", "lua/?/init.lua" },
      },
      workspace = {
        checkThirdParty = false,
        library = library,
      },
    },
  },
}
