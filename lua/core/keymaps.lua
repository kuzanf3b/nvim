-- KEYBINDS
vim.g.mapleader = " "
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local tble = vim.tbl_extend

--  MOVE LINES
map("n", "<leader>e", vim.cmd.Ex)

--  MOVE LINES
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected up" })

--  SMOOTHER NAVIGATION
map("n", "J", "mzJ`z", tble("force", opts, { desc = "Join lines" }))
map("n", "<C-d>", "<C-d>zz", tble("force", opts, { desc = "Scroll down" }))
map("n", "<C-u>", "<C-u>zz", tble("force", opts, { desc = "Scroll up" }))
map("n", "n", "nzzzv", tble("force", opts, { desc = "Next search result" }))
map("n", "N", "Nzzzv", tble("force", opts, { desc = "Prev search result" }))

--  PASTE & DELETE WITHOUT OVERWRITING CLIPBOARD
map("x", "<leader>p", [["_dP]], { desc = "Paste keep buf" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete keep buf" })

--  INSERT MODE
map("i", "<C-c>", "<Esc>", tble("force", opts, { desc = "Exit insert mode" }))

--  QUICKFIX NAVIGATION
map("n", "<C-j>", "<cmd>cnext<CR>zz", tble("force", opts, { desc = "Next quickfix" }))
map("n", "<C-k>", "<cmd>cprev<CR>zz", tble("force", opts, { desc = "Previous quickfix" }))

--  DISABLE EX MODE
map("n", "Q", "<nop>", tble("force", opts, { desc = "Disable Ex mode" }))

--  LOCATION LIST NAVIGATION
map("n", "<leader>k", "<cmd>lnext<CR>zz", tble("force", opts, { desc = "Next location list" }))
map("n", "<leader>j", "<cmd>lprev<CR>zz", tble("force", opts, { desc = "Previous location list" }))

--  DOGE DOCGEN
map("n", "<leader>dg", "<cmd>DogeGenerate<cr>", tble("force", opts, { desc = "Generate documentation" }))

--  PHP FIXER
map("n", "<leader>cc", "<cmd>!php-cs-fixer fix % --using-cache=no<cr>", { desc = "Run PHP-CS-Fixer" })

--  SUBSTITUTE UNDER CURSOR
map("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

--  PERMISSIONS
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Chmod +x" })

--  CLIPBOARD (OSC52)
map("n", "<leader>y", "<Plug>OSCYankOperator", { desc = "Yank to clipboard" })
map("v", "<leader>y", "<Plug>OSCYankVisual", { desc = "Yank selection to clipboard" })

--  RELOAD NVIM
map("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Reload Neovim config" })

--  UNDO TREE
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })

--  LAZY PLUGIN MANAGER
map("n", "<leader>l", vim.cmd.Lazy, { desc = "Lazy" })

--  INDENT BEHAVIOR
map("v", "<", "<gv", tble("force", opts, { desc = "Decrease indent and stay" }))
map("v", ">", ">gv", tble("force", opts, { desc = "Increase indent and stay" }))

--  QUICKFIX CONTROL
map("n", "<leader>cl", ":cclose<CR>", { silent = true, desc = "Close quickfix" })
map("n", "<leader>co", ":copen<CR>", { silent = true, desc = "Open quickfix" })
map("n", "<leader>cn", ":cnext<CR>zz", { desc = "Next quickfix" })
map("n", "<leader>cp", ":cprev<CR>zz", { desc = "Prev quickfix" })

--  LSP CHECK
map("n", "<leader>li", ":checkhealth vim.lsp<CR>", { desc = "LSP info" })

--  WINDOW SPLITS
map("n", "<leader>sv", "<cmd>vsplit<CR>", tble("force", opts, { desc = "Vertical split" }))
map("n", "<leader>sh", "<cmd>split<CR>", tble("force", opts, { desc = "Horizontal split" }))
