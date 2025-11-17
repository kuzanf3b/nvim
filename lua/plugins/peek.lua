return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup({
			filetype = { "markdown", "conf", "txt" },
			app = "floorp",
		})
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

		-- Keymaps for Peek
		vim.keymap.set("n", "<leader>po", function()
			require("peek").open()
		end, { desc = "Open Peek Preview" })

		vim.keymap.set("n", "<leader>pc", function()
			require("peek").close()
		end, { desc = "Close Peek Preview" })
	end,
}
