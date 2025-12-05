-- =======================================
--  Autocommands — Hybrid Elevated Version
-- =======================================

local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Reload file when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	desc = "Reload file automatically when changed externally",
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight yank with better visibility
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	desc = "Highlight selection after yank",
	callback = function()
		vim.hl.on_yank({ timeout = 100, visual = true })
	end,
})

-- Restore last cursor position (safe version)
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	desc = "Restore cursor position except for specific filetypes",
	callback = function(ev)
		local skip = { "gitcommit", "gitrebase", "help" }
		if vim.tbl_contains(skip, vim.bo[ev.buf].filetype) then
			return
		end

		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local lines = vim.api.nvim_buf_line_count(ev.buf)

		if mark[1] > 0 and mark[1] <= lines then
			vim.api.nvim_win_set_cursor(0, mark)
			vim.schedule(function()
				pcall(vim.cmd, "normal! zz")
			end)
		end
	end,
})

-- Auto equalize splits on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	desc = "Equalize window splits",
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- Open help vertically (more readable)
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("help_vertical"),
	pattern = "help",
	desc = "Open help in vertical split",
	command = "wincmd L",
})

-- Close quick / special buffers with q
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	desc = "Close special buffers with q",
	pattern = {
		"help",
		"qf",
		"man",
		"lspinfo",
		"checkhealth",
		"neotest-output",
		"neotest-summary",
		"gitsigns-blame",
		"tsplayground",
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", function()
			pcall(vim.cmd, "close")
		end, { buffer = ev.buf, silent = true })
	end,
})

-- dotenv → proper highlighting
vim.api.nvim_create_autocmd("BufRead", {
	group = augroup("dotenv"),
	pattern = { ".env", ".env.*" },
	desc = "Use dosini syntax for dotenv files",
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- Disable auto-comment continuation
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("no_auto_comment"),
	desc = "Disable automatic comment continuation",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Cursorline only on active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = augroup("cursorline_on"),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = augroup("cursorline_on"),
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- Disable conceal for JSON
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("json_clear_conceal"),
	pattern = { "json", "jsonc", "json5" },
	desc = "Show JSON clearly",
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto-create directories before saving
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_mkdir"),
	desc = "Create parent directories if they don’t exist",
	callback = function(ev)
		if ev.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(ev.match) or ev.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Remove the ~ sign on column
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.opt.fillchars:append({ eob = " " })
	end,
})
