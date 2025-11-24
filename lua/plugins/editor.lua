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
}
