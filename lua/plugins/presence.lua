return {
	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
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
	},
}
