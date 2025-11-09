return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	branch = "master",

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
				selection_caret = " ",
				path_display = { "truncate" },
				layout_strategy = "flex",
				layout_config = {
					prompt_position = "bottom", -- top or bottom
					horizontal = { preview_width = 0.55 },
					vertical = { mirror = false },
				},
				sorting_strategy = "descending", -- ascending or descending
				file_ignore_patterns = { "node_modules", "%.git/", "venv/", "build/" },
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = function(...)
							actions.send_selected_to_qflist(...)
							actions.open_qflist(...)
						end,
						["<Esc>"] = actions.close,
					},
				},
			},

			pickers = {
				find_files = {
					hidden = true,
					previewer = true,
				},
				live_grep = {
					additional_args = function(_)
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

		-- Load extensions safely
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "todo-comments")

		-- Keymaps
		local map = vim.keymap.set
		map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
		map("n", "<leader>fH", builtin.help_tags, { desc = "Help tags" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
		map("n", "<leader>fm", builtin.commands, { desc = "Find commands" })
		map("n", "<leader>fc", builtin.colorscheme, { desc = "Find Colorscheme" })
		map("n", "<leader>fg", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Live grep (manual input)" })

		map("n", "<leader>fp", function()
			local filename = vim.fn.expand("%:t:r")
			builtin.grep_string({ search = filename })
		end, { desc = "Find current file name across project" })

		map("n", "<leader>fs", builtin.grep_string, { desc = "Find current word" })
		map("n", "<leader>fi", function()
			builtin.find_files({ cwd = vim.fn.expand("~/.config/nvim/") })
		end, { desc = "Find in Neovim config" })

		map("n", "<leader>ft", function()
			require("telescope").extensions["todo-comments"].todo()
		end, { desc = "Find TODO comments" })
	end,
}
