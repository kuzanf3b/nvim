return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					sh = { "beautysh" },
					html = { "prettier" },
					css = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					python = { "isort", "black" },
					-- php = { "php-cs-fixer" },
					-- dart = { "dcm" },
					-- java = { "google-java-format" },
					csharp = { "csharpier" },
					gdscript = { "gdformat" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>gf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format buffer (Conform)" })
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				lua = { "luacheck" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "flake8" },
				csharp = { "roslynator" },
				-- dart = { "dcm" },
				-- java = { "checkstyle" },
				-- gdscript = { "gdtoolkit" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{
		"zapling/mason-conform.nvim",
		event = "CmdLineEnter",
		dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
		config = function()
			require("mason-conform").setup({
				ensure_installed = {
					"stylua",
					"beautysh",
					"prettier",
					"isort",
					"black",
					-- "php-cs-fixer",
					-- "google-java-format",
					"csharpier",
					-- "gdtoolkit",
				},
			})
		end,
	},
}
