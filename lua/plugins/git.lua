return {
	{
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
			current_line_blame = true,
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

				map("n", "<leader>hs", gs.stage_hunk, opts)
				map("n", "<leader>hu", gs.undo_stage_hunk, opts)
				map("n", "<leader>hr", gs.reset_hunk, opts)
				map("n", "<leader>hp", gs.preview_hunk, opts)
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, opts)
			end,
		},
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
		},
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.g.lazygit_floating_window_use_plenary = 0
			vim.g.lazygit_use_neovim_remote = 1
		end,
	},
}
