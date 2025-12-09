local opt = vim.opt
local g = vim.g

-- Leader keys
g.mapleader = " "
g.maplocalleader = "\\"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "nosplit"

-- Appearance
opt.termguicolors = true
opt.cursorline = true
opt.colorcolumn = "120"
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.winborder = "rounded"

-- Statusline / command line
opt.laststatus = 3
opt.showcmdloc = "statusline"
opt.ruler = false
opt.cmdheight = 0

-- Clipboard
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- Undo / swap / backup
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.updatetime = 100

-- Mouse
opt.mouse = "a"

-- Completion menu
opt.completeopt = "menu,menuone,noselect,preview"
opt.pumblend = 10
opt.pumheight = 10

-- Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Cursor & scrolling
opt.virtualedit = "block"
opt.jumpoptions = "view"
-- opt.guicursor = ""

-- Misc
opt.iskeyword:append("-")
opt.backspace = "indent,eol,start"
opt.spelllang = { "en" }

-- Disable netrw (optional)
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
