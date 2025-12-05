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
					columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
		},
		signature = { enabled = true },
		fuzzy = { implementation = "prefer_rust" },
		sources = {
			default = {
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
			},
		},
	},
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").load()
		require("blink.cmp").setup(opts)
	end,
}
