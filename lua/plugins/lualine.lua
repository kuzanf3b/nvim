return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local function short_mode()
			local map = {
				n = "N",
				i = "I",
				v = "V",
				V = "V-L",
				["\22"] = "V-B",
				c = "C",
				s = "S",
				S = "S-L",
				R = "R",
				Rv = "R-V",
				t = "T",
			}
			return "" .. (map[vim.fn.mode()] or vim.fn.mode()) .. ""
		end

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "netrw", "dashboard", "NvimTree", "alpha", "starter", "oil" },
			},

			sections = {
				-- lualine_a = { short_mode },
				lualine_a = {
					"branch",
				},

				lualine_b = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},

				lualine_c = {
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
						symbols = { added = " ", modified = " ", removed = " " },
					},

					-- "filetype",
					-- "encoding",
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
}
