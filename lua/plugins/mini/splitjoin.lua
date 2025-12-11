return {
	"nvim-mini/mini.splitjoin",
	event = "VeryLazy",
	config = function()
		require("mini.splitjoin").setup()
	end,
}
