return {
	{ -- FIX: fix opening file in vim . or nvim .
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
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
				desc = "Open Oil Float",
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
					show_hidden = false,
					natural_order = true,
					is_always_hidden = function(name)
						return name == ".git"
					end,
				},
				float = {
					padding = 2,
					max_width = 0.9,
					max_height = 0.8,
					border = "rounded",
					win_options = { winblend = 8 },
				},
				keymaps = {
					["<CR>"] = "actions.select",
					["q"] = "actions.close",
					["R"] = "actions.refresh",
					["l"] = "actions.select",
					["h"] = "actions.parent",
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
					OilGitAdded = { fg = "#9ccfd8" },
					OilGitDeleted = { fg = "#eb6f92" },
					OilGitModified = { fg = "#f6c177" },
					OilGitRenamed = { fg = "#c4a7e7" },
					OilGitUntracked = { fg = "#31748f" },
					OilGitIgnored = { fg = "#6e6a86" },
				},
			})
		end,
	},
}
