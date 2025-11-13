return {
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local autopairs = require("nvim-autopairs")

			autopairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
					java = false,
					php = { "string", "template_string" },
					html = { "tag", "attribute" },
					css = { "string" },
					c = { "string", "character_literal" },
					cpp = { "string", "character_literal" },
					cs = { "string", "verbatim_string_literal" },
					rust = { "string_literal", "raw_string_literal" },
					typescript = { "template_string", "string" },
					json = { "string" },
					markdown = { "fenced_code_block" },
				},
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
		},
	},
}
