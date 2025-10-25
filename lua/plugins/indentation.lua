return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = { "help", "dashboard", "lazy", "NvimTree", "Trouble" },
			},
		},
		config = function(_, opts)
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
			local c = require("tokyonight.colors").setup()
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = c.blue, bold = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "dashboard", "lazy", "mason", "NvimTree", "Trouble" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
