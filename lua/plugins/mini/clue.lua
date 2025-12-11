return {
	"nvim-mini/mini.clue",
	event = "VeryLazy",
	config = function()
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
			clues = {
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),
			},
			window = {
				config = { border = "rounded", width = 40 },
				delay = 100,
				scroll_down = "<C-d>",
				scroll_up = "<C-u>",
			},
		})
	end,
}
