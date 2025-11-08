return {
	{
		"tpope/vim-dadbod",
		cmd = { "DB", "DBUI", "DBExec" },
		keys = {
			{ "<leader>db", ":DB<CR>", desc = "Connect to DB" },
			{ "<leader>de", ":DBExec<CR>", desc = "Execute SQL query" },
			{ "<leader>du", ":DBUI<CR>", desc = "Open DBUI" },
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI" },
		dependencies = { "tpope/vim-dadbod" },
		keys = {
			{ "<leader>du", ":DBUI<CR>", desc = "Open DBUI" },
			{ "<leader>dr", ":DBUIRenameBuffer<CR>", desc = "Rename buffer" },
		},
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql" },
		dependencies = { "tpope/vim-dadbod" },
	},
}
