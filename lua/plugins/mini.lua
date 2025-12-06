return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		-- Surround
		require("mini.surround").setup({
			mappings = {
				add = "sa",
				delete = "sd",
				replace = "sr",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				update_n_lines = "sn",
			},
		})

		-- Textobjects
		require("mini.ai").setup({
			n_lines = 500,
			search_method = "cover_or_next",
		})

		-- require("mini.diff").setup({
		-- 	view = {
		-- 		style = "sign",
		-- 		signs = {
		-- 			add = "▎",
		-- 			change = "▎",
		-- 			delete = "",
		-- 		},
		-- 	},
		-- })

		-- Splitjoin
		require("mini.splitjoin").setup()

		-- Operators
		require("mini.operators").setup()

		-- Notify
		require("mini.notify").setup({
			content = {
				format = function(notif)
					return notif.msg
				end,
			},

			window = {
				winblend = 0,

				config = function()
					return {
						border = "rounded",
						title = "",
					}
				end,
			},
		})

		vim.notify = require("mini.notify").make_notify()

		-- Clue
		local clue = require("mini.clue")
		clue.setup({
			triggers = {
				{ mode = "n", keys = "<leader>" },
				{ mode = "x", keys = "<leader>" },
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
				{ mode = "n", keys = "<C-w>" },
				{ mode = "n", keys = "s" },
				{ mode = "x", keys = "s" },
			},

			clues = vim.list_extend({}, {
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),
			}),

			window = {
				config = { border = "rounded", width = 40 },
				delay = 100,
				scroll_down = "<C-d>",
				scroll_up = "<C-u>",
			},
		})

		-- Keymaps
		local keymap = vim.keymap.set

		keymap("n", "gS", function()
			require("mini.splitjoin").toggle()
		end, { desc = "Toggle split/join" })
	end,
}
