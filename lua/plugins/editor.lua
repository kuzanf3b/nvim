return {
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- list todo comments in the project
			-- FIX
			-- FiXME
			-- NOTE
			-- TODO
			-- BUG
			-- HACK
			-- WARN
			-- WARNING
			-- PERF
			-- OPTIMIZE
			-- INFO
			-- TEST
			-- CHANGED
			-- CHANGEME
			--
			colors = {
				error = { "DiagnosticError", "ErrorMsg" },
				warning = { "DiagnosticWarn", "WarningMsg" },
				info = { "DiagnosticInfo" },
				hint = { "DiagnosticHint" },
				default = { "Identifier" },
				test = { "Identifier" },
			},
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		keys = {
			{
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				desc = "Incremental rename",
				mode = "n",
				noremap = true,
				expr = true,
			},
		},
		config = true,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup({})
			local refactor = require("refactoring")

			vim.keymap.set("x", "<leader>re", function()
				refactor.refactor("Extract Function")
			end, { desc = "Extract Function" })

			vim.keymap.set("x", "<leader>rv", function()
				refactor.refactor("Extract Variable")
			end, { desc = "Extract Variable" })

			vim.keymap.set("n", "<leader>ri", function()
				refactor.refactor("Inline Variable")
			end, { desc = "Inline Variable" })
		end,
	},

	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar" },
		opts = {},
		keys = {
			{ "<leader>fr", "<cmd>GrugFar<cr>", desc = "Find & Replace Project" },
		},
	},
}
