return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},

	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		mason.setup()
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"ts_ls",
				"intelephense",
				"pyright",
				"jdtls",
			},
			automatic_installation = true,
		})

		-- Diagnostic visuals
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 4,
			},
			severity_sort = true,
			float = { border = "rounded" },
			signs = false,
		})

		-- Floating border override
		local orig = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig(contents, syntax, opts, ...)
		end

		-- Keymaps when LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local bufnr = event.buf
				local map = vim.keymap.set
				local opts = { buffer = bufnr, silent = true }

				map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
				map("n", "K", vim.lsp.buf.hover, { desc = "Show Hover Documentation" })
				map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
				map("n", "gr", vim.lsp.buf.references, { desc = "List References" })
				map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
				map("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "Format File" })
			end,
		})

		-- Manual server configs
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			},

			html = { filetypes = { "html" } },

			cssls = {
				settings = {
					css = { validate = true },
					less = { validate = true },
					scss = { validate = true },
				},
			},

			ts_ls = {
				filetypes = {
					"typescript",
					"typescriptreact",
					"javascript",
					"javascriptreact",
				},
				root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
				settings = {
					typescript = {
						inlayHints = { includeInlayParameterNameHints = "all" },
					},
					javascript = {
						inlayHints = { includeInlayParameterNameHints = "all" },
					},
				},
			},

			intelephense = {
				cmd = { "intelephense", "--stdio" },
				filetypes = { "php" },
				root_dir = vim.fs.root(0, { "composer.json", ".git" }),
				settings = {
					intelephense = {
						files = { maxSize = 5000000 },
					},
				},
			},

			pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
			},

			jdtls = {
				cmd = { "jdtls" },
				filetypes = { "java" },
				root_dir = vim.fs.root(0, { "pom.xml", "build.gradle", ".git" }),
			},
		}

		-- Mason callback to setup each server manually
		mason_lspconfig.setup_handlers = nil -- make sure it’s gone

		mason_lspconfig.get_installed_servers(function(servers_list)
			for _, server_name in ipairs(servers_list) do
				local opts = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
				}, servers[server_name] or {})
				if lspconfig[server_name] then
					lspconfig[server_name].setup(opts)
				end
			end
		end)
	end,
}
