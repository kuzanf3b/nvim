-- return {}

return {
	"rebelot/heirline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		--------------------------------------------------------
		-- SAFE COLOR EXTRACTOR
		--------------------------------------------------------
		local function hl_fg(name, fallback)
			local ok, hl = pcall(utils.get_highlight, name)
			return (ok and hl and hl.fg) and hl.fg or fallback or "#aaaaaa"
		end

		local function hl_bg(name, fallback)
			local ok, hl = pcall(utils.get_highlight, name)
			return (ok and hl and hl.bg) and hl.bg or fallback or "#333333"
		end

		local colors = {
			bright_bg = hl_bg("Folded"),
			bright_fg = hl_fg("Folded"),

			red = hl_fg("DiagnosticError"),
			green = hl_fg("String"),
			blue = hl_fg("Function"),
			gray = hl_fg("NonText"),
			orange = hl_fg("Constant"),
			purple = hl_fg("Statement"),
			cyan = hl_fg("Special"),

			diag_error = hl_fg("DiagnosticError"),
			diag_warn = hl_fg("DiagnosticWarn"),
			diag_info = hl_fg("DiagnosticInfo"),
			diag_hint = hl_fg("DiagnosticHint"),

			git_add = hl_fg("DiffAdd", hl_fg("Special")),
			git_del = hl_fg("DiffDelete", hl_fg("DiagnosticError")),
			git_change = hl_fg("DiffChange", hl_fg("DiagnosticWarn")),

			mode = {
				normal = "#7aa2f7",
				insert = "#9ece6a",
				visual = "#bb9af7",
				replace = "#f7768e",
				command = "#e0af68",
			},
		}

		require("heirline").load_colors(colors)

		--------------------------------------------------------
		-- SPACER HELPER
		--------------------------------------------------------
		local Spacer = { provider = " " }

		--------------------------------------------------------
		-- MODE INDICATOR (BUBBLE)
		--------------------------------------------------------
		local ModeIndicator = {
			init = function(self)
				self.mode = vim.fn.mode()
			end,

			provider = " ", -- bubble kecil

			hl = function(self)
				local m = self.mode:sub(1, 1)
				local color = colors.mode.command
				if m == "n" then
					color = colors.mode.normal
				end
				if m == "i" then
					color = colors.mode.insert
				end
				if m == "v" or m == "V" or m == "\22" then
					color = colors.mode.visual
				end
				if m == "R" then
					color = colors.mode.replace
				end
				return { bg = color }
			end,

			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		--------------------------------------------------------
		-- FILE ICON + NAME
		--------------------------------------------------------
		local FileIcon = {
			init = function(self)
				local filename = vim.api.nvim_buf_get_name(0)
				local ext = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, ext, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			init = function(self)
				local filename = vim.api.nvim_buf_get_name(0)
				self.filename = (filename ~= "" and vim.fn.fnamemodify(filename, ":t")) or "[No Name]"
			end,
			provider = function(self)
				return self.filename
			end,
			hl = { bold = true },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "[+] ",
				hl = { fg = colors.green },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "  ",
				hl = { fg = colors.orange },
			},
		}

		local FileType = {
			provider = function()
				return string.upper(vim.bo.filetype)
			end,
			hl = { fg = hl_fg("Type"), bold = true },
		}

		--------------------------------------------------------
		-- GIT
		--------------------------------------------------------
		-- FIXME: later fix the git issue
		local Git = {
			condition = conditions.is_git_repo,

			init = function(self)
				-- branch
				self.branch = vim.trim(vim.fn.system("git branch --show-current"))

				-- stats
				local ok, stats = pcall(MiniDiff.get_buf_stats, 0)
				stats = ok and stats or { added = 0, changed = 0, removed = 0 }

				self.added = stats.added or 0
				self.changed = stats.changed or 0
				self.removed = stats.removed or 0
			end,

			provider = function(self)
				return string.format(" %s +%d ~%d -%d ", self.branch, self.added, self.changed, self.removed)
			end,

			hl = { fg = colors.orange, bold = true },
		}

		--------------------------------------------------------
		-- DIAGNOSTICS (CLEAN VSCode-ish)
		--------------------------------------------------------
		local Diagnostics = {
			condition = conditions.has_diagnostics,
			on_click = {
				callback = function()
					require("trouble").toggle({ mode = "diagnostics" })
					-- or
					-- vim.diagnostic.setqflist()
				end,
				name = "heirline_diagnostics",
			},
			init = function(self)
				local d = vim.diagnostic
				self.errors = #d.get(0, { severity = d.severity.ERROR })
				self.warns = #d.get(0, { severity = d.severity.WARN })
				self.info = #d.get(0, { severity = d.severity.INFO })
				self.hints = #d.get(0, { severity = d.severity.HINT })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			{
				condition = function(self)
					return self.errors > 0
				end,
				provider = function(self)
					return " " .. self.errors .. " "
				end,
				hl = { fg = colors.diag_error },
			},
			{
				condition = function(self)
					return self.warns > 0
				end,
				provider = function(self)
					return " " .. self.warns .. " "
				end,
				hl = { fg = colors.diag_warn },
			},
			{
				condition = function(self)
					return self.info > 0
				end,
				provider = function(self)
					return " " .. self.info .. " "
				end,
				hl = { fg = colors.diag_info },
			},
			{
				condition = function(self)
					return self.hints > 0
				end,
				provider = function(self)
					return "󰌶 " .. self.hints .. " "
				end,
				hl = { fg = colors.diag_hint },
			},
		}

		--------------------------------------------------------
		-- LSP ACTIVE
		--------------------------------------------------------
		local LSPActive = {
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LspInfo")
					end, 100)
				end,
				name = "heirline_LSP",
			},
			condition = conditions.lsp_attached,
			provider = " [LSP]",
			hl = { fg = colors.cyan, bold = true },
		}

		--------------------------------------------------------
		-- RULER + SCROLLBAR
		--------------------------------------------------------
		local Ruler = {
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

				return string.format("%d:%d  %s", line, col, percent)
			end,

			update = { "CursorMoved", "WinScrolled" },
		}

		local ScrollBar = {
			static = { sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" } },
			provider = function(self)
				local curr = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr - 1) / math.max(1, lines) * #self.sbar) + 1
				i = math.max(1, math.min(i, #self.sbar))
				return string.rep(self.sbar[i], 2)
			end,
			hl = { fg = colors.cyan, bg = colors.bright_bg },
		}

		--------------------------------------------------------
		-- SEARCH COUNT
		--------------------------------------------------------
		local SearchCount = {
			condition = function()
				return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
			end,
			init = function(self)
				local ok, search = pcall(vim.fn.searchcount)
				if ok and search.total then
					self.search = search
				end
			end,
			provider = function(self)
				local s = self.search
				return string.format("[%d/%d]", s.current, math.min(s.total, s.maxcount))
			end,
			hl = { fg = colors.purple },
		}

		--------------------------------------------------------
		-- MACRO RECORDING
		--------------------------------------------------------
		local MacroRec = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,

			provider = function()
				return "  " .. vim.fn.reg_recording()
			end,

			hl = { fg = colors.orange, bold = true },

			update = {
				"RecordingEnter",
				"RecordingLeave",
			},
		}

		--------------------------------------------------------
		-- FINAL STATUSLINE
		--------------------------------------------------------
		local Statusline = {
			fallthrough = false,
			{
				-- LEFT
				ModeIndicator,
				MacroRec,
				Spacer,
				Spacer,
				FileIcon,
				FileName,
				FileFlags,
				Spacer,
				Git,
				Spacer,
				Diagnostics,

				-- CENTER
				{ provider = "%=" },

				-- RIGHT
				LSPActive,
				Spacer,
				FileType,
				Spacer,
				SearchCount,
				Spacer,
				Ruler,
				Spacer,
				ScrollBar,
				Spacer,
			},
		}

		--------------------------------------------------------
		-- SETUP
		--------------------------------------------------------
		require("heirline").setup({
			statusline = Statusline,
			tabline = nil,
			winbar = nil,
		})
	end,
}
