-- KEYMAPS - ZenVim styled like LazyVim
vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ╭──────────────────────────────────────────────╮
-- │ BASIC NAVIGATION & LINE MOVEMENT             │
-- ╰──────────────────────────────────────────────╯
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down (visual-aware)" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up (visual-aware)" })
map("n", "J", "mzJ`z", { desc = "Join line keep cursor" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up center" })
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result centered" })

-- ╭──────────────────────────────────────────────╮
-- │ FILES, CONFIG, & SESSION                     │
-- ╰──────────────────────────────────────────────╯
-- map("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })

-- ╭──────────────────────────────────────────────╮
-- │ EDITING ENHANCEMENTS                         │
-- ╰──────────────────────────────────────────────╯
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Decrease indent (stay in visual)" })
map("v", ">", ">gv", { desc = "Increase indent (stay in visual)" })
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting buffer" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without overwriting buffer" })
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
map("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- ╭──────────────────────────────────────────────╮
-- │ WINDOW NAVIGATION & RESIZE                   │
-- ╰──────────────────────────────────────────────╯
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ╭──────────────────────────────────────────────╮
-- │ MOVE LINES (LIKE LAZYVIM)                   │
-- ╰──────────────────────────────────────────────╯
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- ╭──────────────────────────────────────────────╮
-- │ BUFFER MANAGEMENT                            │
-- ╰──────────────────────────────────────────────╯
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Delete current buffer safely
map("n", "<leader>bd", function()
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.bo.modified then
		local choice = vim.fn.confirm("Buffer modified. Save before closing?", "&Yes\n&No\n&Cancel", 1)
		if choice == 1 then
			vim.cmd.write()
		elseif choice == 3 then
			return
		end
	end
	vim.cmd.bdelete(bufnr)
end, { desc = "Delete current buffer" })

-- Delete all other buffers
map("n", "<leader>bo", function()
	local current = vim.api.nvim_get_current_buf()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and bufnr ~= current then
			vim.cmd.bdelete(bufnr)
		end
	end
end, { desc = "Delete other buffers" })

map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Force delete buffer" })

-- ╭──────────────────────────────────────────────╮
-- │ UNDO, CLIPBOARD, PERMISSIONS                 │
-- ╰──────────────────────────────────────────────╯
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
map("n", "<leader>y", "<Plug>OSCYankOperator", { desc = "Yank to system clipboard" })
map("v", "<leader>y", "<Plug>OSCYankVisual", { desc = "Yank selection to system clipboard" })

map("n", "<leader>X", function()
	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify(" No file name. Save the buffer first!", vim.log.levels.WARN)
		return
	end
	local ok = os.execute("chmod +x " .. file)
	if ok == 0 then
		vim.notify(" Made executable: " .. file)
	else
		vim.notify("❌ Failed to chmod file.", vim.log.levels.ERROR)
	end
end, { desc = "Make current file executable" })

-- ╭──────────────────────────────────────────────╮
-- │ TERMINAL MODE                                │
-- ╰──────────────────────────────────────────────╯
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: move to left window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: move to lower window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: move to upper window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: move to right window" })

-- ╭──────────────────────────────────────────────╮
-- │ WINDOW MANAGEMENT                            │
-- ╰──────────────────────────────────────────────╯
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>sc", "<C-w>c", { desc = "Close split" })
map("n", "<leader>so", "<C-w>o", { desc = "Close other splits" })

-- ╭──────────────────────────────────────────────╮
-- │ PLUGIN INTEGRATIONS                          │
-- ╰──────────────────────────────────────────────╯
map("n", "<leader>ol", vim.cmd.Lazy, { desc = "Open Lazy" })
map("n", "<leader>om", "<cmd>Mason<cr>", { desc = "Open Mason" })
map("n", "<leader>Dg", "<cmd>DogeGenerate<cr>", { desc = "Generate documentation (Doge)" })
map("n", "<leader>cc", "<cmd>!php-cs-fixer fix % --using-cache=no<cr>", { desc = "Run PHP-CS-Fixer" })
map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP info" })

-- ╭──────────────────────────────────────────────╮
-- │ COPILOT TOGGLE ON / OFF                      │
-- ╰──────────────────────────────────────────────╯
map("n", "<leader>cp", function()
	vim.g.copilot_enabled = not vim.g.copilot_enabled
	if vim.g.copilot_enabled then
		vim.cmd("Copilot enable")
		vim.notify(" Copilot enabled", vim.log.levels.INFO)
	else
		vim.cmd("Copilot disable")
		vim.notify(" Copilot disabled", vim.log.levels.WARN)
	end
end, { desc = "Toggle GitHub Copilot" })

-- ╭──────────────────────────────────────────────╮
-- │ AESTHETIC & UTILITY                          │
-- ╰──────────────────────────────────────────────╯
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>m", "<cmd>messages<cr>", { desc = "Show :messages log" })
