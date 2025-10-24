return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
		{ "<leader>be", "<cmd>Neotree source=buffers toggle<CR>", desc = "Buffer Explorer" },
		{ "<leader>ge", "<cmd>Neotree source=git_status toggle<CR>", desc = "Git Explorer" },
	},
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		close_if_last_window = true,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = false,

		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
				highlight = "NeoTreeIndentMarker",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				highlight = "NeoTreeFileIcon",
			},
			git_status = {
				symbols = {
					unstaged = "󰄱",
					staged = "󰱒",
					added = "✚",
					deleted = "",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					conflict = "",
				},
			},
			name = {
				highlight = "NeoTreeFileName",
			},
		},

		window = {
			position = "float",
			popup = {
				size = {
					height = "80%",
					width = "70%",
				},
				position = "50%",
				border = "rounded",
				win_options = {
					winblend = 15,
				},
			},
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						vim.fn.setreg("+", node:get_id(), "c")
					end,
					desc = "Copy Path",
				},
				["O"] = {
					function(state)
						vim.fn.jobstart({ "xdg-open", state.tree:get_node().path }, { detach = true })
					end,
					desc = "Open in System",
				},
				["R"] = "refresh",
				["q"] = "close_window",
			},
		},

		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_hidden = true,
			},
		},

		buffers = {
			follow_current_file = { enabled = true },
			group_empty_dirs = true,
			show_unloaded = true,
			window = {
				position = "float",
				popup = {
					size = { height = "70%", width = "60%" },
					border = "rounded",
					win_options = { winblend = 15 },
				},
				mappings = {
					["bd"] = "buffer_delete",
					["l"] = "open",
					["h"] = "close_node",
					["R"] = "refresh",
				},
			},
		},

		git_status = {
			window = {
				position = "float",
				popup = {
					size = { height = "70%", width = "60%" },
					border = "rounded",
					win_options = { winblend = 15 },
				},
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				},
			},
		},
	},

	config = function(_, opts)
		require("neo-tree").setup(opts)
	end,
}
