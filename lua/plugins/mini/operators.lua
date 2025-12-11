return {
	"nvim-mini/mini.operators",
	event = "VeryLazy",
	config = function()
		require("mini.operators").setup()
	end,
}
