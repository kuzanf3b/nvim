return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
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
				"scss",
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
				"kdl",
				"make",
				"cmake",
				"sql",
				"regex",
				"graphql",
				"nix",
			},
			auto_install = true,
		})

		local ok, context = pcall(require, "treesitter-context")
		if ok then
			context.setup({
				enable = true,
				max_lines = 2,
				multiline_threshold = 4,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
			})
		end
	end,
}
