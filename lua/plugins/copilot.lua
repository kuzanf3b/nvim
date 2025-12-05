return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = { enabled = true },
		panel = { enabled = true },
		filetypes = {
			markdown = true,
			help = true,
		},

		should_attach = function(bufnr)
			local ft = vim.bo[bufnr].filetype
			return not vim.tbl_contains({ "markdown", "text", "help" }, ft)
		end,
	},
}
