require("blink.cmp").build():pwait()

require("blink.cmp").setup({
	snippets = {
		preset = "default",
	},
	completion = {
		menu = {
			border = "none",
			draw = {
				padding = 1, -- blink default; its type marks this field as required
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			enabled = vim.g.ai_cmp,
		},
	},

	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<Right>"] = false,
			["<Left>"] = false,
		},
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
			ghost_text = { enabled = true },
		},
	},

	keymap = {
		preset = "enter",
		["c-y"] = { "select_and_accept" },
	},

	appearance = {
		kind_icons = Neovim.icons.kinds,
	},

  signature = { enabled = false },
})
