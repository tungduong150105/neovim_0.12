# Neovim config

Personal Neovim 0.12 config built on the native plugin manager (`vim.pack`), no lazy.nvim.
Light Solarized look, matched by a Ghostty theme.

## Requirements

- Neovim **0.12+**
- A Nerd Font (currently PlemolJP NF)
- [`mise`](https://mise.jdx.dev) for `lua-language-server` (see `mise.toml`)
- Optional:
  - [`lazygit`](https://github.com/jesseduffield/lazygit) for `;g`
  - [`universal-ctags`](https://github.com/universal-ctags/ctags) for gutentags (`brew install universal-ctags`)
    - macOS ships BSD `ctags`, which doesn't work; gutentags stays disabled until Universal Ctags is found

## Install

```sh
git clone <this repo> ~/.config/nvim
mise install   # lua-language-server
nvim           # vim.pack installs the plugins on first start
```

## Structure

```
init.lua                 entry point: options, autocmds, keymaps, then plugins
lua/config/              options, autocmds, keymaps
lua/plugins/init.lua     vim.pack.add(...) list + require of each plugin file
lua/plugins/*.lua        one file per plugin setup
lua/utils/               shared helpers (exposed as the global `Neovim`)
                         icons, lualine components, custom tabline
after/lsp/lua_ls.lua     lua_ls settings (runtime + all vim.pack plugins as library)
```

## Plugins

| Plugin | Used for |
|---|---|
| [solarized.nvim (fork)](https://github.com/tungduong150105/solarized.nvim) | Colorscheme, light variant |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Picker, explorer, indent guides, notifier, input, lazygit, terminal |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Highlighting / indent for lua, ruby, json, yaml, markdown, markdown_inline, javascript, vue, pug, css |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configs (`lua_ls`) |
| [blink.cmp](https://github.com/saghen/blink.cmp) / [blink.pairs](https://github.com/saghen/blink.pairs) | Completion / auto pairs |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Inline AI suggestions |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [incline.nvim](https://github.com/b0o/incline.nvim) | Floating filename per window |
| [noice.nvim](https://github.com/folke/noice.nvim) | Cmdline / messages UI |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) / [mini.diff](https://github.com/nvim-mini/mini.diff) | Git signs, blame, diff overlay |
| [mini.icons](https://github.com/nvim-mini/mini.icons) | Icons |
| [vim-test](https://github.com/vim-test/vim-test) | Run tests (in a snacks terminal) |
| [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags) | Ruby ctags generation |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Render markdown in the buffer (headings, lists, tables, code blocks) |

### Colorscheme fork

`maxmx03/solarized.nvim` is replaced by a fork with fixes for the light theme:

- undercurl for diagnostics and spelling (from upstream PR #108)
- gutter, floats and window separators share the editor background (no darker bands/boxes)
- `snacks` support: tree guides, softer indent guides, visible picker matches

## Keymaps

Leader is `<Space>`.

### Pickers & tools (snacks)

| Key | Action |
|---|---|
| `<leader><space>` | Smart picker |
| `;f` | Find files |
| `;r` | Grep |
| `;d` | Buffer diagnostics |
| `;t` | Tags |
| `gf` | Tags picker, pre-filtered by the word under the cursor |
| `;g` | Lazygit |
| `<C-b>` | Explorer |

### Tests (vim-test)

| Key | Action |
|---|---|
| `<leader>tn` | Nearest test |
| `<leader>tf` | Test file |
| `<leader>ts` | Test suite |
| `<leader>tl` | Last test |
| `<leader>tv` | Visit last test file |

### Git

| Key | Action |
|---|---|
| `<leader>gd` | Toggle mini.diff overlay |

### Copilot (insert mode)

| Key | Action |
|---|---|
| `<C-l>` | Accept |
| `<C-k>` | Accept word |
| `<C-j>` | Accept line |
| `<M-]>` / `<M-[>` | Next / previous suggestion |
| `<C-]>` | Dismiss |

### Editing, windows & tabs

| Key | Action |
|---|---|
| `+` / `-` | Increment / decrement |
| `<C-a>` | Select all |
| `te` | New tab |
| `<Tab>` / `<S-Tab>` | Next / previous tab |
| `ss` / `sv` | Horizontal / vertical split |
| `sh` `sj` `sk` `sl` | Move between windows |
