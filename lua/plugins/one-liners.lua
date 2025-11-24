return {
	{ -- Git integration
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{
				"<leader>gg",
				"<cmd>Git difftool<cr>",
				desc = "Git: Launch difftool",
			},
		},
	},

	{ -- Undo history
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	{ -- Show CSS colors inline
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
}
