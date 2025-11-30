return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true,
			map_cr = true,
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

			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				before_key = "h",
				after_key = "l",
				cursor_pos_before = true,
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				manual_position = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		require("nvim-autopairs").setup({})
	end,
}
