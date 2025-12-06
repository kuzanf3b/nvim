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
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = false,
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
		"vague-theme/vague.nvim",
		name = "vague",
		lazy = false,
		config = function()
			require("vague").setup({
				transparent = true,
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
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
		"Mofiqul/vscode.nvim",
		name = "vscode",
		lazy = false,
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
				disable_nvimtree_bg = true,
			})
		end,
	},
}
