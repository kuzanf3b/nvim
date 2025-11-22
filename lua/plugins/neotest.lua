return {
	"nvim-neotest/neotest",
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run tests in current file",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/nvim-nio",
		"haydenmeade/neotest-jest",
		"nvim-neotest/neotest-vim-test",
	},

	config = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "npx jest --",
					jestConfigFile = "jest.config.js",
					env = { CI = true },
					cwd = function(path)
						return require("neotest-jest").root(path)
					end,
				}),
			},
			diagnostic = { enabled = true },
			summary = { enabled = true, expand_errors = true },
			output = { enabled = true, open_on_run = true },
		})
	end,
}
