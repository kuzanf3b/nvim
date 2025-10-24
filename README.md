# 💤 ZenVim

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green?logo=neovim)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-5.1-blue?logo=lua)](https://www.lua.org/)
[![Lazy.nvim](https://img.shields.io/badge/Plugin%20Manager-Lazy.nvim-orange)](https://github.com/folke/lazy.nvim)
[![Theme](https://img.shields.io/badge/Theme-TokyoNight-purple)](https://github.com/folke/tokyonight.nvim)

> A clean, modular Neovim configuration built from scratch with Lua and Lazy.nvim.

---

## ⚡ Overview

ZenVim is a **modular Neovim setup built from scratch**.  
Every feature is in its own file under `lua/plugins/`, making it easy to extend, replace, or debug.  

---

## ⚡ Core Features

| Area | Description |
|------|--------------|
| 🧠 **LSP** | Language Server Protocol support with `nvim-lspconfig` + `mason.nvim` |
| 🪄 **Completion** | Autocompletion via `nvim-cmp` and `LuaSnip` |
| 🧹 **Formatting & Linting** | Automatic formatting and linting via `conform.nvim`, `nvim-lint` |
| 🎥 **Smooth Animations** | Seamless scroll and cursor effects using `neoscroll.nvim` and `smear-cursor.nvim` |
| 🚀 **Motion Enhancements** | Faster navigation with `flash.nvim`, multi-cursor editing via `multicursors.nvim`, smart window navigation via `smart-splits.nvim` |
| 🪶 **UI Enhancements** | Clean statusline, notifications, indentation guides, and key hints with `lualine.nvim`, `nvim-notify`, `which-key.nvim`, and `indent-blankline.nvim` |
| 🧭 **File Explorer** | File and git tree navigation using `neo-tree.nvim` |
| 🔍 **Search Everything** | Powerful fuzzy finder via `telescope.nvim` |
| 🌳 **Syntax Tree** | Advanced syntax highlighting and textobjects using `nvim-treesitter` |
| 💾 **Quality of Life** | Git tools, undo tree, Discord presence, and color highlighting |

---

## 🖱️ Plugin Highlights

### 🎬 Animations
- **[neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)** → Smooth scrolling with easing functions.  
- **[smear-cursor.nvim](https://github.com/smoka7/smear-cursor.nvim)** → Subtle cursor smear animation for fast movements.

---

### 🧹 Formatter & Linter
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** → Lightweight async formatter.  
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)** → On-the-fly linting.  
- **[mason-conform.nvim](https://github.com/zeioth/mason-conform.nvim)** → Mason integration for Conform.

---

### 🏃 Motions
- **[multicursors.nvim](https://github.com/smoka7/multicursors.nvim)** → Multi-cursor editing for faster refactoring.  
- **[flash.nvim](https://github.com/folke/flash.nvim)** → Enhanced motion with visual hints.  
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** → Add/delete/change surrounding pairs easily.  
- **[smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)** → Intelligent window resizing and navigation.

---

### 🧩 Utilities
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** → Quick file navigation and marking.  
- **[presence.nvim](https://github.com/andweeb/presence.nvim)** → Discord rich presence integration.  
- **[vim-doge](https://github.com/kkoomen/vim-doge)** → Generate documentation automatically.  
- **[undotree](https://github.com/mbbill/undotree)** → Visualize undo history.  
- **[highlight-colors.nvim](https://github.com/brenoprata10/nvim-highlight-colors)** → Inline color previews.  
- **[better-indent-support-for-php-html](https://github.com/Vimjas/vim-html-php-indent)** → Better PHP/HTML indentation.

---

### 🪶 UI & Experience
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** → Beautiful statusline.  
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** → Popup notifications with animations.  
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** → Keybinding hints.  
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** → Indentation guides.  
- **[dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)** → Custom startup dashboard.  
- **[mini.indentscope](https://github.com/echasnovski/mini.indentscope)** → Visualize scope blocks with animation.

---

### 🧠 LSP & Mason
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** → LSP configuration layer.  
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** → Installer and manager for LSP/DAP tools.  
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)** → Bridges Mason and LSP.

---

### 🔍 Search & Files
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** → Fuzzy finder and live grep.  
- **[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** → Native sorter for Telescope.  
- **[telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)** → Replace default Vim UI with Telescope.  

---

### 🎨 Theme
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** → Elegant and fast theme inspired by Tokyo nights.

---

### 🌳 Syntax & Treesitter
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** → Better syntax highlighting and parsing.  
- **[nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)** → Powerful text manipulation.

---

## 🧰 Requirements

- Neovim ≥ 0.9.0  
- Node.js ≥ 16 (JS/TS tools)  
- Python ≥ 3.8 (Python LSPs/formatters)  
- Lua 5.1+  
- ripgrep (`rg`)  
- PHP ≥ 8.0 (for phpactor or intelephense)

---

## 🚀 Installation

1. **Clone ZenVim:**

   ```bash
   git clone https://github.com/kuzanf3b/ZenVim ~/.config/nvim
   ```

2. **Open Neovim and Lazy.nvim will automatically install plugins:**

   ```bash
   nvim
   ```

---

## 🔑 Keymaps Overview

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List buffers |
| `<leader>fs` | Search current word |
| `<leader>fi` | Find in `~/.config/nvim` |
| `<leader>e` | Toggle Neo-Tree |
| `<leader>ca` | Code action |
| `gd` | Go to definition |
| `gr` | List references |
| `<F2>` | Rename symbol |
| `:UndotreeToggle` | Toggle undo history |

---

## 💡 Notes

- Lazy.nvim handles plugin loading and optimization.
- Conform runs formatters asynchronously.
- nvim-lint runs on file save.
- Telescope provides fuzzy searching and live grep.
- Treesitter enhances syntax highlighting and code structure understanding.

---

## 🧩 Folder Structure

```
~/.config/nvim
├── init.lua
├── lua
│   ├── core
│   │   ├── settings.lua
│   │   ├── hooks.lua
│   │   ├── lazy.lua
│   │   └── mappings.lua
│   └── plugins
│       │   ├── lsp-config/
│       │   ├── lsp.lua
│       │   └── mason.lua
│       ├── animations.lua
│       ├── autopairs.lua
│       ├── colorscheme.lua
│       ├── completions.lua
│       ├── dashboard.lua
│       ├── formatter-linter.lua
│       ├── harpoon.lua
│       ├── lualine.lua
│       ├── motions.lua
│       ├── neo-tree.lua
│       ├── one-liners.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       └── ui.lua
└── README.md
```

---

## 🧘 Philosophy

> ZenVim follows the “less but better” principle — minimal, modular, and mindful.  
> Each plugin has a clear purpose and can be swapped or removed easily.
