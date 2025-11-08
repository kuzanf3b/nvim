return {
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- list todo comments in the project
			-- FIX, FiXME, NOTE, TODO, BUG, HACK
			-- WARN, WARNING, PERF, OPTIMIZE, INFO, TEST, CHANGED, CHANGEME
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
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>xS",
				"<cmd>Trouble lsp toggle focus=false<cr>",
				desc = "LSP references/definitions/... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

			-- Navigation integration
			{
				"[q",
				function()
					local trouble = require("trouble")
					if trouble.is_open() then
						trouble.prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					local trouble = require("trouble")
					if trouble.is_open() then
						trouble.next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
}
