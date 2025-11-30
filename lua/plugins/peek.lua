return {
	"toppair/peek.nvim",
	keys = {
		{
			"<leader>po",
			function()
				require("peek").open()
			end,
			desc = "Open Peek Preview",
		},
		{
			"<leader>pc",
			function()
				require("peek").close()
			end,
			desc = "Close Peek Preview",
		},
	},
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup({
			filetype = { "markdown", "conf", "txt" },
			app = "firefox",
		})

		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
}
