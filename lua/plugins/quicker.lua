return {
	"stevearc/quicker.nvim",
	event = "VeryLazy",
	keys = {
		{
			">",
			function()
				require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
			end,
			desc = "Expand quickfix context",
		},
		{
			"<",
			function()
				require("quicker").collapse()
			end,
			desc = "Collapse quickfix context",
		},
	},

	config = function()
		require("quicker").setup({})
		local map = vim.keymap.set

		-- Keymaps recommended by repo
		map("n", "<leader>qq", function()
			require("quicker").toggle()
		end, { desc = "Toggle quickfix" })

		map("n", "<leader>ql", function()
			require("quicker").toggle({ loclist = true })
		end, { desc = "Toggle loclist" })

		map("n", "<leader>qg", function()
			local input = vim.fn.input("Grep > ")
			if input ~= "" then
				vim.fn.setloclist(0, {}, "r", {
					title = "Ripgrep",
					lines = vim.fn.systemlist("rg --vimgrep " .. vim.fn.shellescape(input)),
				})
				require("quicker").toggle({ loclist = true }) -- buka quickfix via quicker
			end
		end, { desc = "Search with ripgrep (to quicker)" })
	end,
}
