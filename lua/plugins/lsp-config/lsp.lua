return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local mason_lspconfig = require("mason-lspconfig")

		vim.diagnostic.config({
			signs = false,
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
			float = { border = "rounded", source = "always", header = "", prefix = "" },
		})

		local orig_preview = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig_preview(contents, syntax, opts, ...)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local bufnr = event.buf
				local map = vim.keymap.set
				local opts = { buffer = bufnr }

				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "K", vim.lsp.buf.hover, opts)
				map("n", "gi", vim.lsp.buf.implementation, opts)
				map("n", "gr", vim.lsp.buf.references, opts)
				map("n", "<F2>", vim.lsp.buf.rename, opts)
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				map("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, opts)

				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end,
		})

		for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
			local opts = { capabilities = capabilities }

			if server_name == "lua_ls" then
				opts.settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				}
			end

			vim.lsp.config(server_name, opts)
			vim.lsp.enable(server_name)
		end
	end,
}
