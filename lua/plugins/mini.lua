return {
	"echasnovski/mini.nvim",
	version = "*",
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

		-- AI (textobjects)
		require("mini.ai").setup({
			n_lines = 500,
			search_method = "cover_or_next",
		})

		-- Files (file explorer)
		require("mini.files").setup({
			windows = {
				max_number = 2,
				preview = true,
				width_focus = 40,
				width_nofocus = 50,
			},
			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},
		})

		vim.keymap.set("n", "<leader>e", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0))
		end, { desc = "MiniFiles open" })

		vim.keymap.set("n", "<leader>E", function()
			require("mini.files").open()
		end, { desc = "MiniFiles (cwd)" })

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap(
			{ "n", "x" },
			"sa",
			"<cmd>lua MiniSurround.add()<CR>",
			vim.tbl_extend("force", opts, { desc = "Add surround" })
		)
		keymap(
			"n",
			"sd",
			"<cmd>lua MiniSurround.delete()<CR>",
			vim.tbl_extend("force", opts, { desc = "Delete surround" })
		)
		keymap(
			"n",
			"sr",
			"<cmd>lua MiniSurround.replace()<CR>",
			vim.tbl_extend("force", opts, { desc = "Replace surround" })
		)
		keymap(
			"n",
			"sf",
			"<cmd>lua MiniSurround.find()<CR>",
			vim.tbl_extend("force", opts, { desc = "Find surround (right)" })
		)
		keymap(
			"n",
			"sF",
			"<cmd>lua MiniSurround.find_left()<CR>",
			vim.tbl_extend("force", opts, { desc = "Find surround (left)" })
		)
		keymap(
			"n",
			"sh",
			"<cmd>lua MiniSurround.highlight()<CR>",
			vim.tbl_extend("force", opts, { desc = "Highlight surround" })
		)
		keymap(
			"n",
			"sn",
			"<cmd>lua MiniSurround.update_n_lines()<CR>",
			vim.tbl_extend("force", opts, { desc = "Update n_lines" })
		)

		local function gen_leader_clues()
			local clues = {}
			for _, map in ipairs(vim.api.nvim_get_keymap("n")) do
				if map.lhs:match("^" .. vim.g.mapleader) and map.desc then
					table.insert(clues, { mode = "n", keys = map.lhs, desc = map.desc })
				end
			end
			for _, map in ipairs(vim.api.nvim_get_keymap("x")) do
				if map.lhs:match("^" .. vim.g.mapleader) and map.desc then
					table.insert(clues, { mode = "x", keys = map.lhs, desc = map.desc })
				end
			end
			return clues
		end

		local clue = require("mini.clue")

		clue.setup({
			triggers = {
				-- leader
				{ mode = "n", keys = "<leader>" },
				{ mode = "x", keys = "<leader>" },

				-- g, z, windows, dsb.
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
				{ mode = "n", keys = "<C-w>" },

				-- plugin-related triggers
				{ mode = "n", keys = "s" },
				{ mode = "x", keys = "s" },
			},

			clues = vim.list_extend({}, {
				gen_leader_clues(),

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
	end,
}
