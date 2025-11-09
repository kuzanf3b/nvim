function MyCrayon(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE" })
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
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
					transparency = true,
				},
			})

			MyCrayon()
		end,
	},

	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
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
	},

	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
		config = function()
			require("kanagawa").setup({
				colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
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
						VertSplit = { fg = colors.fujiGray },
					}
				end,
			})
		end,
	},

	{
		"wtfox/jellybeans.nvim",
		name = "jellybeans",
		lazy = true,
		config = function()
			require("jellybeans").setup({
				transparent = true,
				italics = true,
				bold = true,
				flat_ui = true,
				on_highlights = function(hl, c)
					hl.Normal = { bg = "none", fg = c.fg }
					hl.NormalFloat = { bg = "none" }
					hl.SignColumn = { bg = "none" }
					hl.VertSplit = { fg = c.comment }
				end,
			})
		end,
	},
}
