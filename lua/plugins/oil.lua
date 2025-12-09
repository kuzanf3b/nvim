-- return {}

return {
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"benomahony/oil-git.nvim",
		"JezerM/oil-lsp-diagnostics.nvim",
	},
	cmd = { "Oil", "OilToggle" },
	keys = {
		{
			"<leader>e",
			function()
				local oil = require("oil")
				if vim.bo.filetype == "oil" then
					vim.cmd("bd!")
				else
					oil.open()
				end
			end,
			desc = "Toggle Oil Explorer",
		},
		{
			"<leader>fe",
			function()
				require("oil").open_float()
			end,
			desc = "Toggle Floating Oil Explorer",
		},
	},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			constrain_cursor = "editable",
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name)
					return name == ".git", name == ".."
				end,
			},
			columns = { "icon" },
			float = {
				padding = 2,
				max_width = 0.9,
				max_height = 0.8,
				border = "rounded",
			},
			keymaps = {
				["<CR>"] = "actions.select",
				["q"] = "actions.close",
				["R"] = "actions.refresh",
			},
			win_options = {
				cursorcolumn = false,
			},
		})

		require("oil-git").setup({
			ignore_git_signs = true,
			highlights = {
				OilGitDeleted = { fg = "#eb6f92" },
				OilGitAdded = { fg = "#9ccfd8" },
				OilGitModified = { fg = "#f6c177" },
				OilGitRenamed = { fg = "#c4a7e7" },
				OilGitUntracked = { fg = "#31748f" },
				OilGitIgnored = { fg = "#6e6a86" },
			},
		})
	end,
}
