return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- Neovim runtime
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = vim.fn.stdpath("config"), words = { "vim" } },
		},
	},
}
