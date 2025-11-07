local function set_transparency()
	local lineNrColor = "#44415a"

	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", fg = lineNrColor })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE", fg = "#2a273f" })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- 'rose', 'dawn', 'moon'
				dark_variant = "moon",
				disable_background = false,
				dim_nc_background = false,
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
			})

			vim.cmd.colorscheme("tokyonight")
			set_transparency()
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "moon", --  'storm', 'night', 'day', 'moon'
			transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		set_transparency(),
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				theme = "wave", -- wave, dragon, lotus
				background = {
					dark = "wave",
					light = "lotus",
				},
				overrides = function(colors)
					return {
						Normal = { bg = "none" },
						NormalFloat = { bg = "none" },
						SignColumn = { bg = "none" },
						VertSplit = { fg = colors.fujiGray },
					}
				end,
			})
		end,
	},
}
