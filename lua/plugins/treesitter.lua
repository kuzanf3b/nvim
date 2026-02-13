return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	priority = 1000,

	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"windwp/nvim-ts-autotag",
	},

	opts = {
		ensure_installed = {
			"bash",
			"c",
			"css",
			"html",
			"javascript",
			"typescript",
			"tsx",
			"json",
			"lua",
			"python",
			"yaml",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"sql",
			"dockerfile",
			"gitignore",
			"regex",
			"toml",
			"cmake",
			"make",
			"nix",
			"graphql",
			"query",
		},

		auto_install = true,

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
	},

	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

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
