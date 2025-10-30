return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",

		config = function()
			local function short_mode()
				local map = {
					n = "N", -- Normal
					i = "I", -- Insert
					v = "V", -- Visual
					V = "V-L", -- Visual Line
					[""] = "V-B", -- Visual Block (Ctrl+v)
					c = "C", -- Command
					s = "S", -- Select
					S = "S-L", -- Select Line
					[""] = "S-B", -- Select Block
					R = "R", -- Replace
					Rv = "R-V", -- Virtual Replace
					t = "T", -- Terminal
				}
				return "" .. (map[vim.fn.mode()] or vim.fn.mode()) .. ""
			end

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { "dashboard", "NvimTree", "alpha", "starter" },
				},

				sections = {
					lualine_a = { short_mode },
					lualine_b = { "branch" },

					lualine_c = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = { left = 1, right = 0 },
						},
						{
							"filename",
							file_status = true,
							path = 1,
							symbols = { modified = "●", readonly = "" },
						},
					},

					lualine_x = {
						{
							"diff",
							colored = true,
							symbols = { added = " ", modified = " ", removed = " " },
						},
						{ "filetype" },
					},

					lualine_y = { "progress" },
					lualine_z = {
						{
							"location",
							padding = { left = 0, right = 1 },
						},
					},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { { "location", padding = 0 } },
					lualine_y = {},
					lualine_z = {},
				},

				extensions = { "neo-tree", "fugitive", "lazy", "fzf" },
			})
		end,
	},

	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local devicons = require("nvim-web-devicons")

			local function hl_color(name, field)
				local hl = vim.api.nvim_get_hl(0, { name = name })
				local color = hl[field]
				if color then
					return string.format("#%06x", color)
				end
				return nil
			end

			require("incline").setup({
				window = {
					placement = { horizontal = "right", vertical = "top" },
					margin = { horizontal = 1, vertical = 0 },
					padding = { left = 0, right = 0 },
					winhighlight = {
						Normal = "InclineNormal",
						FloatBorder = "InclineNormal",
					},
				},

				render = function(props)
					local buf = props.buf
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end

					local icon, icon_color = devicons.get_icon_color(filename)
					local bg = hl_color("StatusLine", "background") or "#2E3440"
					local fg = hl_color("StatusLine", "foreground") or "#D8DEE9"

					return {
						guibg = bg,
						guifg = fg,
						icon and { icon, " ", guifg = icon_color, guibg = bg } or "",
						{ filename, gui = "bold" },
					}
				end,
			})
		end,
	},
}
