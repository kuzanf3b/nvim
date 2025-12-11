local hl = require("heirline-components.core.hl")
local c = hl.get_colors()

local M = {}

M.Ruler = {
	provider = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		local line = pos[1]
		local col = pos[2] + 1
		local total = vim.api.nvim_buf_line_count(0)

		local percent
		if line == 1 then
			percent = "Top"
		elseif line == total then
			percent = "Bot"
		else
			percent = string.format("%d%%%%", math.floor(line / total * 100))
		end

		return string.format("   %d:%d %s ", line, col, percent)
	end,

	update = { "CursorMoved", "WinScrolled" },
}

M.ScrollBar = {
	static = {
		sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
	},

	provider = function(self)
		local curr = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr - 1) / math.max(1, lines) * #self.sbar) + 1
		i = math.max(1, math.min(i, #self.sbar))
		return string.rep(self.sbar[i], 2)
	end,

	hl = {
		fg = c.scrollbar,
	},
}

return M
