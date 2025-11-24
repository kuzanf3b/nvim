return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
			top_down = true,
			level = vim.log.levels.TRACE,
			icons = {
				error = " ",
				warn = " ",
				info = " ",
				debug = " ",
				trace = " ",
			},
			fps = 60,
			render = "minimal",
			max_width = 60,
			max_height = 10,
			merge_duplicates = false,
			background_colour = "#000000",
		},
	},

	config = function(_, opts)
		require("snacks").setup(opts)

		-- LSP PROGRESS NOTIFIER
		vim.api.nvim_create_autocmd("LspProgress", {
			---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			callback = function(ev)
				local spinner = {
					"⠋",
					"⠙",
					"⠹",
					"⠸",
					"⠼",
					"⠴",
					"⠦",
					"⠧",
					"⠇",
					"⠏",
				}

				vim.notify(vim.lsp.status(), "info", {
					id = "lsp_progress",
					title = "LSP Progress",
					opts = function(notif)
						local value = ev.data.params.value
						local done = value and value.kind == "end"

						notif.icon = done and " " or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
					end,
				})
			end,
		})
	end,
}
