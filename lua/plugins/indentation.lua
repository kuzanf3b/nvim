return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "▏", highlight = "IblIndent" },
			scope = { enabled = false },
			exclude = {
				filetypes = { "help", "dashboard", "lazy", "NvimTree", "Trouble" },
				buftypes = { "terminal", "nofile", "prompt" },
			},
		},
		config = function(_, opts)
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4252" })
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#88C0D0" })

			require("ibl").setup(opts)
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "dashboard", "lazy", "mason", "NvimTree", "Trouble" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#88C0D0" })
			require("mini.indentscope").setup(opts)
		end,
	},
}
