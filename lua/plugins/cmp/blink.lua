return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	build = "cargo build --release",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
	},
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
		},
		completion = {
			menu = {
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind", gap = 5 } },
				},
			},
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
		},
		signature = { enabled = true },
		fuzzy = { implementation = "prefer_rust" },
		sources = {
			default = {
				"lazydev",
				"copilot",
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					async = true,
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},
	},
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").load()
		require("blink.cmp").setup(opts)
	end,
}
