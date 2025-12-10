return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"rachartier/tiny-code-action.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},

	config = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("blink.cmp").get_lsp_capabilities()
		)

		vim.diagnostic.config({
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
			severity_sort = true,
			signs = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		local servers = {
			lua_ls = {
				cmd = { "/usr/bin/lua-language-server" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						completion = { callSnippet = "Replace" },
					},
				},
			},

			html = {
				filetypes = { "html", "php" },
			},

			tailwindcss = {
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"html",
					"css",
					"scss",
					"sass",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"php",
					"twig",
					"jsx",
					"tsx",
				},
				root_dir = vim.fs.root(0, {
					"tailwind.config.js",
					"tailwind.config.cjs",
					"postcss.config.js",
					"package.json",
					".git",
				}),
				settings = {
					tailwindCSS = {
						includeLanguages = {
							typescript = "javascript",
							typescriptreact = "javascript",
							html = "html",
							php = "html",
						},
						experimental = {
							classRegex = {
								'class\\s*[:=]\\s*"([^"]*)"',
								'className\\s*[:=]\\s*"([^"]*)"',
							},
						},
						validate = true,
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidScreen = "error",
							invalidVariant = "error",
							invalidConfigPath = "error",
						},
					},
				},
			},

			cssls = {
				settings = {
					css = { validate = true },
					less = { validate = true },
					scss = { validate = true },
				},
			},

			ts_ls = {
				filetypes = {
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"html",
				},
				root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
						},
					},
				},
			},

			intelephense = {
				cmd = { "intelephense", "--stdio" },
				filetypes = { "php", "html" },
				root_dir = vim.fs.root(0, { "composer.json", ".git" }),
				settings = {
					intelephense = {
						files = { maxSize = 5000000 },
					},
				},
			},

			-- pyright = {
			-- 	cmd = { "pyright-langserver", "--stdio" },
			-- 	filetypes = { "python" },
			-- 	root_dir = vim.fs.root(0, {
			-- 		"pyproject.toml",
			-- 		"setup.py",
			-- 		"requirements.txt",
			-- 		".git",
			-- 	}),
			-- },

			-- dartls = {},

			-- omnisharp = {},

			emmet_ls = {
				cmd = { "emmet-language-server", "--stdio" },
				filetypes = {
					"html",
					"css",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"php",
					"vue",
					"xml",
					"svelte",
					"astro",
					"twig",
				},
				root_dir = vim.fs.root(0, { ".git", "package.json", "composer.json" }),
				settings = {
					emmet = {
						showExpandedAbbreviation = "always",
						showAbbreviationSuggestions = true,
						syntaxProfiles = {
							html = { attr_quotes = "double" },
						},
						variables = { lang = "en" },
					},
				},
			},
		}

		for name, config in pairs(servers) do
			config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-modern", { clear = true }),
			callback = function(event)
				local buf = event.buf
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
				end

				map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
				map("n", "K", vim.lsp.buf.hover, "Show Hover Docs")
				map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
				map("n", "gr", vim.lsp.buf.references, "List References")
				map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
				map({ "n", "v" }, "<leader>ca", function()
					require("tiny-code-action").code_action()
				end, "Code Action (Tiny)")
				map("n", "<leader>gl", function()
					vim.lsp.buf.format({ async = true })
				end, "Format Buffer (LSP)")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument_inlayHint") then
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
					end, "Toggle Inlay Hints")
				end
			end,
		})
	end,
}
