return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
				format = function(diagnostic)
					local icons = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
					}
					return string.format("%s%s", icons[diagnostic.severity], diagnostic.message)
				end,
			},
			float = {
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- === LSP Servers ===
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { library = { vim.env.VIMRUNTIME } },
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("pyright", { capabilities = capabilities })
		vim.lsp.enable("pyright")

		vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.enable("ts_ls")

		vim.lsp.config("intelephense", { capabilities = capabilities })
		vim.lsp.enable("intelephense")

		vim.lsp.config("jdtls", { capabilities = capabilities })
		vim.lsp.enable("jdtls")

		vim.lsp.config("html", { capabilities = capabilities })
		vim.lsp.enable("html")

		vim.lsp.config("cssls", { capabilities = capabilities })
		vim.lsp.enable("cssls")

		vim.lsp.config("jsonls", { capabilities = capabilities })
		vim.lsp.enable("jsonls")

		-- === Keymaps per buffer ===
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local opts = { buffer = event.buf }
				local map = vim.keymap.set

				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "K", vim.lsp.buf.hover, opts)
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				map("n", "gi", vim.lsp.buf.implementation, opts)
				map("n", "gr", vim.lsp.buf.references, opts)
				map("n", "<F2>", vim.lsp.buf.rename, opts)
			end,
		})
	end,
}
