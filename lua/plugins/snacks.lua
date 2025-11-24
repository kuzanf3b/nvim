return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		bigfile = { enabled = true },
		explorer = {
			replace_netrw = true,
			auto_close = true,
			hidden = true,
		},
		statuscolumn = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		words = {
			enabled = true,
			debounce = 100,
		},
	},

	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},
}
