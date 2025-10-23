return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = { "help", "dashboard", "lazy", "NvimTree", "Trouble" },
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			local c = require("tokyonight.colors").setup()
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = c.blue, bold = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "dashboard", "lazy", "mason", "NvimTree", "Trouble" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")

			notify.setup({
				stages = "fade_in_slide_out",
				timeout = 3000,
				render = "default",
				fps = 60,
				top_down = true,
				background_colour = "#1e2030",
				minimum_width = 40,
				max_width = 60,
			})

			vim.notify = notify

			vim.cmd([[
          hi NotifyINFOBorder guifg=#7aa2f7 guibg=#1e2030
          hi NotifyINFOTitle  guifg=#7aa2f7 guibg=#1e2030
          hi NotifyINFOBody   guifg=#c0caf5 guibg=#1e2030

          hi NotifyWARNBorder guifg=#e0af68 guibg=#1e2030
          hi NotifyWARNTitle  guifg=#e0af68 guibg=#1e2030
          hi NotifyWARNBody   guifg=#c0caf5 guibg=#1e2030

          hi NotifyERRORBorder guifg=#f7768e guibg=#1e2030
          hi NotifyERRORTitle  guifg=#f7768e guibg=#1e2030
          hi NotifyERRORBody   guifg=#c0caf5 guibg=#1e2030

          hi NotifyDEBUGBorder guifg=#565f89 guibg=#1e2030
          hi NotifyDEBUGTitle  guifg=#565f89 guibg=#1e2030
          hi NotifyDEBUGBody   guifg=#c0caf5 guibg=#1e2030
    ]])
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.icons",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			preset = "modern",
			notify = true,
			win = {
				border = "rounded",
				no_overlap = true,
				padding = { 1, 1 },
				zindex = 1000,
				wo = { winblend = 10 },
			},
			layout = {
				width = { min = 20, max = 50 },
				spacing = 4,
				align = "center",
			},
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
				ellipsis = "…",
				mappings = true,
				colors = true,
				keys = {
					Up = " ",
					Down = " ",
					Left = " ",
					Right = " ",
					C = "󰘴 ",
					M = "󰘵 ",
					D = "󰘳 ",
					S = "󰘶 ",
					CR = "󰌑 ",
					Esc = "󱊷 ",
					Space = "󱁐",
					Tab = "󰌒 ",
				},
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				--  FIND
				{ "<leader>f", group = "Find" },
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
				{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
				{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
				{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },

				--  LSP
				{ "<leader>l", group = "LSP" },
				{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
				{ "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart" },
				{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
				{ "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
				{ "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References" },

				--  DIAGNOSTICS
				{ "<leader>d", group = "Diagnostics" },
				{ "<leader>db", "<cmd>Telescope diagnostics<cr>", desc = "All Diagnostics" },
				{ "<leader>dc", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Current Line" },
				{ "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next" },
				{ "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev" },

				--  RECENT
				{ "<leader>r", group = "Recent" },
				{ "<leader>rr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

				--  CONFIG
				{ "<leader>c", group = "Config" },
				{ "<leader>cl", "<cmd>Lazy<cr>", desc = "Lazy" },
				{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
				{ "<leader>ci", "<cmd>Inspect<cr>", desc = "Inspect Highlight" },

				--  MULTICURSOR / MOTIONS
				{ "<leader>m", group = "Multicursor" },
				{ "<leader>mm", "<cmd>MCstart<cr>", desc = "Start multicursor" },

				--  UTILITIES
				{ "<leader>x", "!chmod +x %<cr>", desc = "Make file executable" },
				{ "<leader>y", '"+y', desc = "Yank to clipboard" },
			})
		end,
	},
}
