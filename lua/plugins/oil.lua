return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "Oil", "OilToggle" },
	keys = {
		{ "<leader>e", "<cmd>Oil<CR>", desc = "Toggle Oil Explorer" },
		{
			"<leader>fe",
			function()
				require("oil").open_float()
			end,
			desc = "Open Oil Float",
		},
	},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon" },
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			constrain_cursor = "editable",
			view_options = {
				show_hidden = false,
				natural_order = true,
			},
			keymaps = {
				["<CR>"] = "actions.select",
				["l"] = "actions.select",
				["h"] = "actions.parent",
				["R"] = "actions.refresh",
				["q"] = "actions.close",
				["Y"] = "actions.yank_entry",
				["gx"] = "actions.open_external",
			},
			float = {
				padding = 2,
				max_width = 0.9,
				max_height = 0.8,
				border = "rounded",
				win_options = { winblend = 8 },
			},
		})
	end,
}
