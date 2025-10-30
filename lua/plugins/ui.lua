return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = function(_, opts)
			opts = opts or {}

			-- Basic presets
			opts.presets = vim.tbl_extend("force", opts.presets or {}, {
				bottom_search = true,
				command_palette = true,
				lsp_doc_border = true,
			})

			opts.routes = opts.routes or {}
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})

			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			return opts
		end,
	},

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")

			notify.setup({
				stages = "fade_in_slide_out",
				timeout = 4000,
				render = "wrapped-compact",
				fps = 60,
				top_down = true,
				background_colour = "#000000",
				minimum_width = 40,
				max_width = 60,
				level = vim.log.levels.INFO,
			})

			-- Override bawaan vim.notify biar seragam
			vim.notify = function(msg, log_level, opts)
				opts = opts or {}
				opts.level = opts.level or log_level or vim.log.levels.INFO
				notify(msg, opts.level, opts)
			end
		end,
	},
}
