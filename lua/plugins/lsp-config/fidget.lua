return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	tag = "legacy",
	config = function()
		require("fidget").setup({
			text = {
				spinner = "dots",
			},
			window = {
				blend = 0,
			},
		})
	end,
}
