return {
	{
		"andweeb/presence.nvim",
		lazy = false,
		opts = {
			neovim_image_text = "Writing code, bending time.",
			main_image = "neovim", -- "neovim" or "file"
			client_id = "793271441293967371",
			log_level = nil, -- "debug", "info", "warn", "error" or nil

			editing_text = "Editing %s",
			file_explorer_text = "Browsing %s",
			git_commit_text = "Committing changes",
			plugin_manager_text = "Configuring plugins",
			reading_text = "Reading %s",
			workspace_text = "Working on %s",
			line_number_text = "Line %s of %s",

			debounce_timeout = 15, -- update every 15s
		},

		{
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup({
					icons = false,
				})

				vim.keymap.set("n", "<leader>tt", function()
					require("trouble").toggle()
				end, { desc = "Toggle Trouble" })

				vim.keymap.set("n", "[t", function()
					require("trouble").next({ skip_groups = true, jump = true })
				end, { desc = "Next Trouble item" })

				vim.keymap.set("n", "]t", function()
					require("trouble").previous({ skip_groups = true, jump = true })
				end, { desc = "Previous Trouble item" })
			end,
		},
	},

	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				filetype = { "markdown", "conf", "txt" },
				app = "brave",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

			-- Keymaps for Peek
			vim.keymap.set("n", "<leader>po", function()
				require("peek").open()
			end, { desc = "Open Peek Preview" })

			vim.keymap.set("n", "<leader>pc", function()
				require("peek").close()
			end, { desc = "Close Peek Preview" })
		end,
	},
}
