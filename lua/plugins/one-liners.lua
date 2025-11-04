return {
	{ -- PHP/HTML indentation support
		"captbaritone/better-indent-support-for-php-with-html",
	},

	{ -- Clipboard integration (OS copy)
		"ojroques/vim-oscyank",
		ft = { "php", "javascript", "html" },
	},

	{ -- Generate docblocks
		"kkoomen/vim-doge",
		build = ":call doge#install()",
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
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
			vim.g.user_emmet_settings = {
				javascript = {
					extends = "jsx",
				},
				typescript = {
					extends = "tsx",
				},
			}
		end,
	},
}
