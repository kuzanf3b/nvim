return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	event = "VeryLazy",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local list = harpoon:list()

		-- Harpoon Telescope toggle
		local conf = require("telescope.config").values
		local themes = require("telescope.themes")
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			local opts = themes.get_ivy({ prompt_title = "Harpoon Files" })
			require("telescope.pickers")
				.new(opts, {
					finder = require("telescope.finders").new_table({ results = file_paths }),
					previewer = conf.file_previewer(opts),
					sorter = conf.generic_sorter(opts),
				})
				:find()
		end

		-- Keymaps (auto-load via lazy.nvim)
		vim.keymap.set("n", "<leader>ha", function()
			require("harpoon"):list():add()
			vim.notify("File added to Harpoon", vim.log.levels.INFO)
		end, { desc = "Add file to Harpoon" })

		vim.keymap.set("n", "<leader>hl", function()
			toggle_telescope(require("harpoon"):list())
		end, { desc = "List Harpoon files (Telescope)" })

		vim.keymap.set("n", "<leader>hp", function()
			require("harpoon"):list():prev()
		end, { desc = "Previous Harpoon file" })

		vim.keymap.set("n", "<leader>hn", function()
			require("harpoon"):list():next()
		end, { desc = "Next Harpoon file" })

		vim.keymap.set("n", "<leader>hr", function()
			require("harpoon"):list():remove()
			vim.notify("Removed current file from Harpoon", vim.log.levels.INFO)
		end, { desc = "Remove current Harpoon file" })

		vim.keymap.set("n", "<leader>hc", function()
			require("harpoon"):list():clear()
			vim.notify("Harpoon list cleared!", vim.log.levels.INFO)
		end, { desc = "Clear all Harpoon files" })

		vim.keymap.set("n", "<C-e>", function()
			require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
		end, { desc = "Harpoon quick menu" })
	end,
}
