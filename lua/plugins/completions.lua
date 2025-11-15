return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		{
			"zbirenbaum/copilot.lua",
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

		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		local auto_select = true

		cmp.setup({
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
			completion = {
				completeopt = auto_select and "menu,menuone,noinsert" or "menu,menuone,noinsert,noselect",
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered({
					border = "none",
					side_padding = 1,
					col_offset = -3,
					scrollbar = true,
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
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
				-- FIXME: maybe fix this ghost_text
				ghost_text = false,
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})
	end,
}
