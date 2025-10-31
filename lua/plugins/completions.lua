return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		-- Core completion
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp-signature-help",

		-- Copilot
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		},
		{
			"zbirenbaum/copilot-cmp",
			dependencies = { "copilot.lua" },
			config = function()
				require("copilot_cmp").setup()
			end,
		},
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- LSP capability binding ala LazyVim
		vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

		-- Load snippets
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})

		-- Highlight ghost text
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		local auto_select = true

		cmp.setup({
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
			completion = {
				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered({
					border = "none",
					scrollbar = false,
					side_padding = 1,
					col_offset = -3,
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = auto_select }),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "luasnip" },
				{ name = "path" },
			}, {
				{ name = "buffer", keyword_length = 3 },
			}),

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local lspkind = require("lspkind")

					vim_item = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 300,
						ellipsis_char = "…",
						show_labelDetails = true,
						symbol_map = { Copilot = "" },
						menu = {
							buffer = "[Buf]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							path = "[Path]",
							copilot = "[AI]",
							nvim_lsp_signature_help = "[Sig]",
						},
					})(entry, vim_item)

					vim_item.abbr = " " .. vim_item.abbr
					vim_item.menu = vim_item.menu and ("   " .. vim_item.menu) or ""

					return vim_item
				end,
			},

			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		})

		-- Command-line completion
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})

		-- Search completion
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
	end,
}
