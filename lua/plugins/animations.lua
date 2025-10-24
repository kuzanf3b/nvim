return {
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			local neoscroll = require("neoscroll")

			neoscroll.setup({
				mappings = {},
				easing_function = "sine",
				hide_cursor = true,
				performance_mode = true,
				stop_eof = true,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
			})

			local keymap = {
				["<C-u>"] = function()
					neoscroll.ctrl_u({ duration = 250 })
				end,
				["<C-d>"] = function()
					neoscroll.ctrl_d({ duration = 250 })
				end,
				["<C-b>"] = function()
					neoscroll.ctrl_b({ duration = 450 })
				end,
				["<C-f>"] = function()
					neoscroll.ctrl_f({ duration = 450 })
				end,
				["<A-y>"] = function()
					neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
				end,
				["<A-e>"] = function()
					neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
				end,
				["zt"] = function()
					neoscroll.zt({ half_win_duration = 250 })
				end,
				["zz"] = function()
					neoscroll.zz({ half_win_duration = 250 })
				end,
				["zb"] = function()
					neoscroll.zb({ half_win_duration = 250 })
				end,
			}
			keymap["{"] = function()
				local before = vim.fn.line("w0")
				vim.cmd("normal! {")
				local after = vim.fn.line("w0")
				local diff = after - before
				if diff ~= 0 then
					neoscroll.scroll(diff, { move_cursor = false, duration = 150 })
				end
			end

			keymap["}"] = function()
				local before = vim.fn.line("w0")
				vim.cmd("normal! }")
				local after = vim.fn.line("w0")
				local diff = after - before
				if diff ~= 0 then
					neoscroll.scroll(diff, { move_cursor = false, duration = 150 })
				end
			end

			local modes = { "n", "v", "x" }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func, { silent = true })
			end
		end,
	},

	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {
			stiffness = 0.6,
			trailing_stiffness = 0.6,
			matrix_pixel_threshold = 0.6,
			vertical_bar_cursor_insert_mode = true,
		},
		config = function()
			require("smear_cursor").setup({
				smear_length = 12,
				smear_fade = 35,
			})
		end,
	},
}
