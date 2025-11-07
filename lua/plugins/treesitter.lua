return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")

		-- Treesitter setup
		configs.setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			},
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
			ensure_installed = {
				"json",
				"python",
				"javascript",
				"query",
				"typescript",
				"tsx",
				"php",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"c",
				"dockerfile",
				"gitignore",
				"astro",
				"toml",
				"ini",
				"conf",
				"sh",
				"kdl",
				"make",
				"cmake",
				"sql",
				"regex",
				"graphql",
				"nix",
			},
			auto_install = false,
		})

		-- Treesitter Context setup
		require("treesitter-context").setup({
			enable = true,
			max_lines = 2,
			multiline_threshold = 4,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
			line_numbers = false,
			zindex = 20,
		})
	end,
}
