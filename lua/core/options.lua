-- ╭──────────────────────────────────────────────╮
-- │ OPTIONS - ZenVim Core Settings               │
-- ╰──────────────────────────────────────────────╯
local opt = vim.opt
local g = vim.g

-- ╭──────────────────────────────────────────────╮
-- │ LEADER KEYS                                  │
-- ╰──────────────────────────────────────────────╯
g.mapleader = " "
g.maplocalleader = "\\"

-- ╭──────────────────────────────────────────────╮
-- │ LINE NUMBERS                                 │
-- ╰──────────────────────────────────────────────╯
opt.number = true
opt.relativenumber = true

-- ╭──────────────────────────────────────────────╮
-- │ TABS & INDENTATION                           │
-- ╰──────────────────────────────────────────────╯
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- ╭──────────────────────────────────────────────╮
-- │ SEARCH                                        │
-- ╰──────────────────────────────────────────────╯
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "nosplit" -- live substitution preview

-- ╭──────────────────────────────────────────────╮
-- │ APPEARANCE                                   │
-- ╰──────────────────────────────────────────────╯
opt.termguicolors = true
opt.cursorline = true
opt.colorcolumn = "120"
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- ╭──────────────────────────────────────────────╮
-- │ STATUSLINE / CMDLINE                         │
-- ╰──────────────────────────────────────────────╯
opt.laststatus = 3 -- global statusline
opt.showcmdloc = "statusline"
opt.ruler = true
opt.cmdheight = 1
opt.statuscolumn = "%s %C %=%{v:relnum?v:relnum:v:lnum} "

-- ╭──────────────────────────────────────────────╮
-- │ CLIPBOARD                                    │
-- ╰──────────────────────────────────────────────╯
-- Disable clipboard sync over SSH for safety
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- ╭──────────────────────────────────────────────╮
-- │ UNDO / SWAP / BACKUP                         │
-- ╰──────────────────────────────────────────────╯
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.updatetime = 100 -- faster CursorHold events

-- ╭──────────────────────────────────────────────╮
-- │ MOUSE                                        │
-- ╰──────────────────────────────────────────────╯
opt.mouse = "a"

-- ╭──────────────────────────────────────────────╮
-- │ COMPLETION                                   │
-- ╰──────────────────────────────────────────────╯
opt.completeopt = { "menuone", "noselect" }
opt.pumblend = 10
opt.pumheight = 10

-- ╭──────────────────────────────────────────────╮
-- │ SPLITS                                       │
-- ╰──────────────────────────────────────────────╯
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- ╭──────────────────────────────────────────────╮
-- │ CURSOR & SCROLLING                           │
-- ╰──────────────────────────────────────────────╯
opt.virtualedit = "block"
opt.jumpoptions = "view"

-- ╭──────────────────────────────────────────────╮
-- │ FOLDING                                      │
-- ╰──────────────────────────────────────────────╯
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldtext = ""
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- ╭──────────────────────────────────────────────╮
-- │ MISC                                         │
-- ╰──────────────────────────────────────────────╯
opt.iskeyword:append("-")
opt.backspace = "indent,eol,start"
opt.spelllang = { "en" }

-- ╭──────────────────────────────────────────────╮
-- │ DISABLE NETRW (for modern file explorers)    │
-- ╰──────────────────────────────────────────────╯
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
