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
				terminal = "#73daca",
			},
		}

		require("heirline").load_colors(colors)

		--------------------------------------------------------
		-- SPACER HELPER
		--------------------------------------------------------
		local OneSpacer = { provider = " " }
		local TwoSpacer = { provider = "  " }
		local Align = { provider = "%=" }

		--------------------------------------------------------
		-- MODE INDICATOR (BUBBLE)
		--------------------------------------------------------
		local mode_color = {
			-- Normal variants
			["n"] = colors.mode.normal,
			["no"] = colors.mode.normal,
			["nov"] = colors.mode.normal,
			["noV"] = colors.mode.normal,
			["no\22"] = colors.mode.normal,
			["niI"] = colors.mode.normal,
			["niR"] = colors.mode.normal,
			["niV"] = colors.mode.normal,

			-- Insert variants
			["i"] = colors.mode.insert,
			["ic"] = colors.mode.insert,
			["ix"] = colors.mode.insert,

			-- Visual variants
			["v"] = colors.mode.visual,
			["V"] = colors.mode.visual,
			["\22"] = colors.mode.visual, -- CTRL-V

			-- Select
			["s"] = colors.mode.visual,
			["S"] = colors.mode.visual,
			["\19"] = colors.mode.visual,

			-- Replace
			["R"] = colors.mode.replace,
			["Rc"] = colors.mode.replace,
			["Rx"] = colors.mode.replace,
			["Rv"] = colors.mode.replace,
			["Rvc"] = colors.mode.replace,
			["Rvx"] = colors.mode.replace,

			-- Command-line modes
			["c"] = colors.mode.command,
			["cv"] = colors.mode.command,
			["ce"] = colors.mode.command,

			-- Prompt / More
			["!"] = colors.mode.command,
			["r"] = colors.mode.command,
			["rm"] = colors.mode.command,
			["r?"] = colors.mode.command,

			-- Terminal
			["t"] = colors.mode.terminal,
		}

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode()
			end,

			provider = function(self)
				-- Kalau butuh ikon mode, bisa tambah di sini
				return " "
			end,

			hl = function(self)
				local color = mode_color[self.mode] or colors.mode.command
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

		local HelpFileName = {
			condition = function()
				return vim.bo.filetype == "help"
			end,
			provider = function()
				local filename = vim.api.nvim_buf_get_name(0)
				return vim.fn.fnamemodify(filename, ":t")
			end,
			hl = { fg = colors.blue },
		}

		--------------------------------------------------------
		-- GIT
		--------------------------------------------------------
		local Git = {
			condition = conditions.is_git_repo,

			init = function(self)
				local g = vim.b.gitsigns_status_dict or {}
				self.head = g.head or nil
				self.added = g.added or 0
				self.changed = g.changed or 0
				self.removed = g.removed or 0
			end,

			-- entire git segment
			{
				-- icon + branch
				condition = function(self)
					return self.head ~= nil
				end,

				provider = function(self)
					return " " .. self.head
				end,
				hl = { fg = colors.orange, bold = true },
			},

			update = { "BufEnter", "BufWritePost", "User" },
		}

		--------------------------------------------------------
		-- DIAGNOSTICS
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
			hl = { fg = colors.green, bold = true },
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
				else
					self.search = { current = "", total = "", maxcount = "" }
				end
			end,
			provider = function(self)
				local s = self.search
				return string.format("[%d/%d]", s.current, math.min(s.total, s.maxcount))
			end,
			hl = { fg = colors.red },
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

		local DefaultStatusline = {
			-- LEFT
			ViMode,
			MacroRec,
			OneSpacer,
			FileIcon,
			FileName,
			FileFlags,
			TwoSpacer,
			Git,
			TwoSpacer,
			Diagnostics,

			-- CENTER
			{ provider = "%=" },

			-- RIGHT
			LSPActive,
			TwoSpacer,
			FileType,
			OneSpacer,
			SearchCount,
			OneSpacer,
			Ruler,
			OneSpacer,
			ScrollBar,
			OneSpacer,
		}

		local InactiveStatusline = {
			condition = conditions.is_not_active,
			FileType,
			OneSpacer,
			FileName,
			Align,
		}

		local TerminalStatusline = {

			condition = function()
				return conditions.buffer_matches({ buftype = { "terminal" } })
			end,

			hl = { bg = "dark_red" },

			-- Quickly add a condition to the ViMode to only show it when buffer is active!
			{ condition = conditions.is_active, ViMode, Space },
			FileType,
			OneSpacer,
			Align,
		}

		local SpecialStatusline = {
			condition = function()
				return conditions.buffer_matches({
					buftype = { "nofile", "prompt", "help", "quickfix" },
					filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "netrw" },
				})
			end,

			FileType,
			OneSpacer,
			HelpFileName,
			Align,
		}

		--------------------------------------------------------
		-- STATUSLINE
		--------------------------------------------------------
		local Statusline = {
			fallthrough = false,
			hl = function()
				if conditions.is_active() then
					return "StatusLine"
				else
					return "StatusLineNC"
				end
			end,

			SpecialStatusline,
			DefaultStatusline,
			InactiveStatusline,
			TerminalStatusline,
		}

		--------------------------------------------------------
		-- SETUP
		--------------------------------------------------------
		require("heirline").setup({
			statusline = Statusline,
			tabline = nil,
			winbar = nil,
			opts = {
				disable_statusline_cb = function(args)
					return require("heirline.conditions").buffer_matches({
						buftype = { "nofile", "prompt", "help", "quickfix" },
						filetype = {
							"^git.*",
							"fugitive",
							"Trouble",
							"dashboard",
							"alpha",
							"starter",
							"lazy",
							"neotree",
						},
					}, args.buf)
				end,
			},
		})
	end,
}
