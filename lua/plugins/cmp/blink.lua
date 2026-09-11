return {
	"saghen/blink.cmp",
	dependencies = {
		"saghen/blink.lib",
		-- optional: provides snippets for the snippet source
		"fang2hou/blink-copilot",
		"rafamadriz/friendly-snippets",
	},
	build = function()
		-- build the fuzzy matcher, wait up to 60 seconds
		-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
		require("blink.cmp").build():wait(60000)
	end,

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
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

		fuzzy = { implementation = "lua" }, -- change "lua" if dont wanna exercise
	},
}
