return {
	"nvim-neotest/neotest",
	event = { "CmdlineEnter", "VeryLazy" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/nvim-nio",

		"haydenmeade/neotest-jest",
		"nvim-neotest/neotest-vim-test",
		-- "Issafalcon/neotest-dotnet",
		-- "nvim-neotest/neotest-plenary",
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
				-- require("neotest-dotnet")({
				-- 	discovery_root = "tests",
				-- }),
				-- require("neotest-plenary").setup(),
				-- require("neotest-vim-test")({
				-- 	ignore_file_types = { "python", "rust" },
				-- }),
			},
			diagnostic = {
				enabled = true,
			},
			summary = {
				enabled = true,
				expand_errors = true,
			},
			output = {
				enabled = true,
				open_on_run = true,
			},
		})

		-- Keymap sederhana
		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run()
		end, { desc = "Run nearest test" })

		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run tests in current file" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "Toggle test summary" })
	end,
}
