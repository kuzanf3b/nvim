vim.g.mapleader = " "
local map = vim.keymap.set

-- Navigation
map({ "n", "x" }, "j", "v:count==0?'gj':'j'", { expr = true, silent = true, desc = "Down" })
map({ "n", "x" }, "k", "v:count==0?'gk':'k'", { expr = true, silent = true, desc = "Up" })
map("n", "J", "mzJ`z", { desc = "Join" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll ↓" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll ↑" })
map("n", "n", "nzzzv", { desc = "Next" })
map("n", "N", "Nzzzv", { desc = "Prev" })

-- Files
map("n", "<leader>e", vim.cmd.Ex, { desc = "Explorer" })

-- Editing
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move ↓" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move ↑" })
map("v", "<", "<gv", { desc = "Indent ←" })
map("v", ">", ">gv", { desc = "Indent →" })
map("x", "<leader>p", [["_dP]], { desc = "Paste keep" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete keep" })
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word" })
map("i", "<C-c>", "<Esc>", { desc = "Esc" })
map("n", "Q", "<nop>", { desc = "No Q" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Right" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Taller" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Shorter" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Wider" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Narrower" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Line ↓" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Line ↑" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Line ↓" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Line ↑" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move ↓" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move ↑" })

-- Clipboard & exec
map("n", "<leader>y", '"+y', { desc = "Yank" })
map("v", "<leader>y", '"+y', { desc = "Yank" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line" })
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo tree" })

map("n", "<leader>X", function()
	local f = vim.fn.expand("%:p")
	if f == "" then
		vim.notify("No filename", vim.log.levels.WARN)
	else
		if os.execute("chmod +x " .. f) == 0 then
			vim.notify("Executable: " .. f)
		else
			vim.notify("chmod failed", vim.log.levels.ERROR)
		end
	end
end, { desc = "Make exec" })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit term" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Right" })

-- Splits
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "VSplit" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "HSplit" })
map("n", "<leader>sc", "<C-w>c", { desc = "Close" })
map("n", "<leader>so", "<C-w>o", { desc = "Only" })

-- Plugins
map("n", "<leader>ol", vim.cmd.Lazy, { desc = "Lazy" })
map("n", "<leader>om", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP info" })

-- Copilot
map("n", "<leader>cp", function()
	vim.g.copilot_enabled = not vim.g.copilot_enabled
	vim.cmd(vim.g.copilot_enabled and "Copilot enable" or "Copilot disable")
end, { desc = "Copilot" })

-- Misc
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
map("n", "<leader>m", "<cmd>messages<cr>", { desc = "Messages" })
map("n", "<leader>rs", "<cmd>source %<CR>", { desc = "Execute the current file" })
