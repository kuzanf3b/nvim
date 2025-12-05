return {
	"ggandor/leap.nvim",
	event = "VeryLazy",
	config = function()
		local map = vim.keymap.set

		map({ "n", "x", "o" }, "f", "<Plug>(leap)")
		map("n", "F", "<Plug>(leap-from-window)")

		require("leap").opts.safe_labels = ""
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("LeapColorTweaks", {}),
			callback = function()
				if vim.g.colors_name == "bad_color_scheme" then
					-- Forces using the defaults: sets `IncSearch` for labels,
					-- `Search` for matches, removes `LeapBackdrop`, and updates the
					-- look of concealed labels.
					require("leap").init_hl(true)
				end
			end,
		})
	end,
}
