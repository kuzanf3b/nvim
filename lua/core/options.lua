-- OPTIONS
local opts = vim.opt

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Line numbers
opts.number = true
opts.relativenumber = true

-- Tabs & indentation
opts.tabstop = 4
opts.shiftwidth = 4
opts.expandtab = true
opts.autoindent = true
opts.smartindent = true
opts.shiftround = true

-- Search
opts.ignorecase = true
opts.smartcase = true
opts.incsearch = true
opts.inccommand = "nosplit" -- modern live substitution preview

-- Appearance
opts.termguicolors = true
opts.background = "dark"
opts.cursorline = true
opts.colorcolumn = "120"
opts.signcolumn = "yes"
opts.scrolloff = 4
opts.sidescrolloff = 8
opts.wrap = false

-- Statusline / cmdline
opts.laststatus = 3 -- global statusline
opts.showmode = false
opts.showcmd = false
opts.ruler = false
opts.laststatus = 3
opts.cmdheight = 0
opts.statuscolumn = "%s %C %=%{v:relnum?v:relnum:v:lnum} "

-- Clipboard
opts.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- Undo / Swap / Backup
opts.undofile = true
opts.undodir = os.getenv("HOME") .. "/.vim/undodir"
opts.swapfile = false
opts.backup = false
opts.updatetime = 100 -- responsive CursorHold

-- Mouse
opts.mouse = "a"

-- Completion
opts.completeopt = { "menuone", "noselect" }
opts.pumblend = 10
opts.pumheight = 10

-- Splits
opts.splitbelow = true
opts.splitright = true
opts.splitkeep = "screen"

-- Cursor & scrolling
opts.virtualedit = "block"
opts.scrolloff = 8
opts.sidescrolloff = 8
opts.jumpoptions = "view"

-- Folding
opts.foldmethod = "indent"
opts.foldlevel = 99
opts.foldtext = ""
opts.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Keywords
opts.iskeyword:append("-")

-- Backspace
opts.backspace = "indent,eol,start"

-- Spell
opts.spelllang = { "en" }
