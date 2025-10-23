-- OPTIONS
local opts = vim.opt

-- line numbers
opts.number = true
opts.relativenumber = true

-- indentation and tabs
opts.tabstop = 4
opts.shiftwidth = 4
opts.autoindent = true
opts.expandtab = true

-- search settings
opts.ignorecase = true
opts.smartcase = true
opts.incsearch = true -- highlight while typing search

-- appearance
opts.termguicolors = true
opts.background = "dark"
opts.signcolumn = "yes"
opts.cursorline = true
opts.colorcolumn = "120"

-- clipboard
opts.clipboard:append("unnamedplus")

-- backspace
opts.backspace = "indent,eol,start"

-- split windows
opts.splitbelow = true
opts.splitright = true

-- dw/diw/ciw works on full-word
opts.iskeyword:append("-")

-- keep cursor at least 8 rows from top/bot
opts.scrolloff = 8

-- undo/swap/backup settings
opts.swapfile = false
opts.backup = false
opts.undodir = os.getenv("HOME") .. "/.vim/undodir"
opts.undofile = true

-- faster cursor hold
opts.updatetime = 50

opts.showmode = false
opts.showcmd = false
opts.ruler = false
opts.laststatus = 3
opts.cmdheight = 0

opts.mouse = "a"
opts.completeopt = { "menuone", "noselect" }
