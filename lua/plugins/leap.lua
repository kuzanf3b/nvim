return {
	"ggandor/leap.nvim",
	event = "VeryLazy",
	config = function()
		local leap = require("leap")
		local leapUser = require("leap.user")

		local map = vim.keymap.set
		-- map({ "n", "x", "o" }, "s", "<Plug>(leap)")
		-- map("n", "S", "<Plug>(leap-from-window)")

		leap.opts.safe_labels = ""

		leap.opts.preview = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
		end

		leap.opts.equivalence_classes = {
			" \t\r\n", -- whitespace group
			"([{", -- opening brackets group
			")]}", -- closing brackets group
			"'\"`", -- quote group
		}

		leapUser.set_repeat_keys(";;", ",,")

		-- clever-f / clever-t like mappings
		do
			local function as_ft(key_specific_args)
				local common_args = {
					inputlen = 1,
					inclusive = true,
					opts = {
						labels = "",
						safe_labels = vim.fn.mode(1):match("[no]") and "" or nil,
					},
				}
				return vim.tbl_deep_extend("keep", common_args, key_specific_args)
			end

			local clever = require("leap.user").with_traversal_keys
			local clever_f = clever("f", "F")
			local clever_t = clever("t", "T")

			for key, key_specific_args in pairs({
				f = { opts = clever_f },
				F = { backward = true, opts = clever_f },
				t = { offset = -1, opts = clever_t },
				T = { backward = true, offset = 1, opts = clever_t },
			}) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					require("leap").leap(as_ft(key_specific_args))
				end)
			end
		end

		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("LeapColorTweaks", {}),
			callback = function()
				leap.init_hl(true)
			end,
		})
	end,
}
