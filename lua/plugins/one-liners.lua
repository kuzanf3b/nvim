return {
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
