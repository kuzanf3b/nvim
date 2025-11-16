return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = { "Oil", "OilToggle" },
		keys = {
			-- {
			-- 	"<leader>fe",
			-- 	function()
			-- 		local oil = require("oil")
			-- 		if vim.bo.filetype == "oil" then
			-- 			vim.cmd("bd!")
			-- 		else
			-- 			oil.open()
			-- 		end
			-- 	end,
			-- 	desc = "Toggle Oil Explorer",
			-- },
			{
				"<leader>e",
				function()
					require("oil").open_float()
				end,
				desc = "Toggle Oil Explorer",
			},
		},
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = { "icon" },
				skip_confirm_for_simple_edits = true,
				delete_to_trash = true,
				constrain_cursor = "editable",
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name)
						return name == ".git"
					end,
					is_hidden_file = function(name)
						return name:match("^%.") ~= nil
					end,
				},
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
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
					signcolumn = "no",
					cursorcolumn = false,
				},
			})
		end,
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
		config = function()
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
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
}
