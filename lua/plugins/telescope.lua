return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		"folke/todo-comments.nvim",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				path_display = { "truncate" },

				layout_strategy = "flex",
				layout_config = {
					prompt_position = "top",
					horizontal = { preview_width = 0.55 },
					vertical = { mirror = false },
				},

				sorting_strategy = "ascending",
				file_ignore_patterns = { "node_modules", "%.git/", "venv/", "build/" },

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-q>"] = function(prompt_bufnr)
							actions.send_selected_to_qflist(prompt_bufnr)
							actions.open_qflist()
						end,
					},
				},

				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			},

			pickers = {
				find_files = {
					theme = "ivy",
					hidden = true,
					previewer = true,
				},

				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},

			extensions = {
				["ui-select"] = require("telescope.themes").get_dropdown({
					previewer = true,
					layout_config = { width = 0.4, height = 0.3 },
				}),
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "todo-comments")

		local map = vim.keymap.set

		map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
		map("n", "<leader>fm", builtin.commands, { desc = "Find commands" })
		map("n", "<leader>fc", builtin.colorscheme, { desc = "Find colorscheme" })

		map("n", "<leader>fb", function()
			builtin.buffers({
				sort_mru = true,
				ignore_current_buffer = true,
			})
		end, { desc = "Find buffers (MRU)" })
		map("n", "<leader>fg", function()
			builtin.live_grep({ prompt_title = "Live Grep (manual input)" })
		end, { desc = "Live Grep input" })

		map("n", "<leader>fp", function()
			local filename = vim.fn.expand("%:t:r")
			builtin.grep_string({ search = filename })
		end, { desc = "Search current filename" })

		map("n", "<leader>fs", builtin.grep_string, { desc = "Search word under cursor" })

		map("n", "<leader>fi", function()
			builtin.find_files({ cwd = vim.fn.expand("~/.config/nvim/") })
		end, { desc = "Find in Neovim config" })

		map("n", "<leader>ft", function()
			telescope.extensions["todo-comments"].todo()
		end, { desc = "Find TODOs" })
	end,
}
