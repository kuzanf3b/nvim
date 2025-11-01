return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "moon",
			dark_variant = "moon",
			disable_background = false,
			dim_nc_background = false,
			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},
		})

		vim.cmd.colorscheme("rose-pine")

		local function set_transparency()
			local lineNrColor = "#44415a"

			-- TODO: Maybe fix later
			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", fg = lineNrColor })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE", fg = "#2a273f" })

			-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
			-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "NONE", fg = "#e0def4" })
			-- vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "NONE" })
			-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
			-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
		end

		set_transparency()
	end,
}
