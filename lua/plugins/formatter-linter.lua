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
					python = { "isort", "black" },
					php = { "php-cs-fixer" },
					dart = { "dcm" },
					java = { "google-java-format" },
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
			end, { desc = "Format file" })
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				lua = { "luacheck" },
				sh = { "shellcheck" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "flake8" },
				php = { "phpcs" },
				dart = { "dcm" },
				java = { "checkstyle" },
				csharp = { "roslynator" },
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
		dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
		config = function()
			require("mason-conform").setup({
				ensure_installed = {
					"stylua",
					"beautysh",
					"prettier",
					"isort",
					"black",
					"php-cs-fixer",
					"dcm",
					"google-java-format",
					"csharpier",
					-- "gdtoolkit",
				},
			})
		end,
	},
}
