return {
	{ -- Clipboard integration (OS copy)
		"ojroques/vim-oscyank",
		ft = { "php", "javascript", "html" },
	},

	{ -- Git integration
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
	},

	{ -- Undo history
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{ -- Show CSS colors inline
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{
		"olrtg/nvim-emmet",
		event = "InsertEnter",
		config = function()
			vim.keymap.set(
				{ "n", "v" },
				"<leader>xe",
				require("nvim-emmet").wrap_with_abbreviation,
				{ desc = "Wrap with Emmet abbreviation" }
			)
			vim.g.user_emmet_settings = {
				html = {
					extends = "html",
				},
				css = {
					extends = "css",
				},
				scss = {
					extends = "css",
				},
				javascript = {
					extends = "jsx",
				},
				typescript = {
					extends = "tsx",
				},
				javascriptreact = {
					extends = "jsx",
				},
				typescriptreact = {
					extends = "tsx",
				},
				php = {
					extends = "html",
				},
				xml = {
					extends = "html",
				},
				vue = {
					extends = "html",
				},
			}
		end,
	},
}
