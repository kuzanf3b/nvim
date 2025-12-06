-- return {}

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
		},
		signs_staged_enable = true,
		current_line_blame = false,
		current_line_blame_opts = {
			delay = 500,
			virt_text_pos = "eol",
		},
		preview_config = {
			border = "rounded",
			style = "minimal",
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local map = vim.keymap.set
			local opts = { buffer = bufnr, silent = true }

			-- Navigation between hunks
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, opts)

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, opts)

			map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk", unpack(opts) })
			map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk", unpack(opts) })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk", unpack(opts) })
			map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk", unpack(opts) })
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame line", unpack(opts) })
		end,
	},
}
