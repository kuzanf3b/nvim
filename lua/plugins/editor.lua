return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#f7768e" },
				warning = { "DiagnosticWarn", "WarningMsg", "#e0af68" },
				info = { "DiagnosticInfo", "#7aa2f7" },
				hint = { "DiagnosticHint", "#7dcfff" },
				default = { "Identifier", "#bb9af7" },
				test = { "Identifier", "#9ece6a" },
			},
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)

			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},

	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvimtools/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create multicursor selection (normal/visual)",
			},
		},
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		keys = {
			{
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				desc = "Incremental rename",
				mode = "n",
				noremap = true,
				expr = true,
			},
		},
		config = true,
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
