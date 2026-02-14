local function MyCrayon(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- 'main', 'dawn', 'moon'
				dark_variant = "main",
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
			style = "moon", -- 'storm', 'night', 'day', 'moon'
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
		"olimorris/onedarkpro.nvim",
		name = "onedark",
		lazy = false,
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = true,
				},
				highlights = {
					Comment = { italic = true },
					Directory = { bold = true },
					ErrorMsg = { italic = true, bold = true },
				},
				styles = {
					comments = "italic",
					keywords = "bold,italic",
					functions = "italic",
					conditionals = "italic",
				},
			})
		end,
	},
}
