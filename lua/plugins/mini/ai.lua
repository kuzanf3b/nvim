return {
	"nvim-mini/mini.ai",
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup({
			n_lines = 500,
			search_method = "cover_or_next",
		})
	end,
}
