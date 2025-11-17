# 💤 ZenVim

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green?logo=neovim)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-5.1-blue?logo=lua)](https://www.lua.org/)
[![Lazy.nvim](https://img.shields.io/badge/Plugin%20Manager-Lazy.nvim-orange)](https://github.com/folke/lazy.nvim)
[![Tokyo Night](https://img.shields.io/badge/Theme-TokyoNight-purple)](https://github.com/folke/tokyonight.nvim)
[![Rose Pine](https://img.shields.io/badge/Theme-Rosepine-cyan)](https://github.com/rose-pine/neovim)


## ✨ Overview 
ZenVim is a thoughtfully curated Neovim configuration built manually from the ground up. It embraces minimalism, efficiency, and clarity — for devs who want their editor to feel alive yet streamlined.  
This isn’t just a copy‑paste config; it’s a handcrafted setup for those who code, engineer and live in the zone.

---

## 🤖 Core Features

| Area                        | Description |
|-----------------------------|--------------|
| 🧠 **LSP**                  | Language Server Protocol support with `nvim-lspconfig` + `mason.nvim` |
| 🪄 **Completion**           | Autocompletion via `nvim-cmp` and `LuaSnip` |
| 🧹 **Formatting & Linting** | Automatic formatting and linting via `conform.nvim`, `nvim-lint` |
| 🎥 **Smooth Animations**    | Seamless scroll using `neoscroll.nvim` |
| 🚀 **Motion Enhancements**  | Faster navigation with `flash.nvim`, faster code with mini.nvim using `mini.ai`, `mini.operator`, `mini.surround` |
| 🧪 **Testing**              | Faster testing with `neotest.nvim` |
| 🪶 **UI Enhancements**      | Clean statusline and key hints with `lualine.nvim` and `mini.clue` |
| 🧭 **File Jumper**          | File and git tree navigation using `oil.nvim` and jump between file using `harpoon` |
| 🔍 **Search Everything**    | Powerful fuzzy finder via `telescope.nvim` |
| 🌳 **Syntax Tree**          | Advanced syntax highlighting and textobjects using `nvim-treesitter` |
| 💾 **Quality of Life**      | Git tools, undo tree, Discord presence, and color highlighting |

---


## 🔒 Key Features
- Fully modular Lua configuration for Neovim (no messy Vimscript legacy)  
- Minimal dependencies: you build and configure each piece yourself, so you know exactly what’s running  
- Pre‑wired productivity tools (file explorer, fuzzy finder, LSP support, autocompletion)  
- Cleaner UI & theming out‑of‑the‑box: focus on code, not configuration noise  
- Easily extensible: drop in your own modules, tweak plugins, adjust layout  
- Perfect for engineers who prefer customization over “one‑size‑fits‑all” setups  

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

2. **Enter config directory:**

   ```bash
   cd ~/.config/nvim
   ```

2. **Open Neovim and Lazy.nvim will automatically install plugins:**

   ```bash
   nvim
   ```
---

## 🔑 Mappings Overview

| Key          | Action |
|--------------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>a`  | Add file to harpoon |
| `<C-e>`      | Harpoon menu |
| `<leader>e`  | Toggle Oil explorer |
| `<leader>ca` | Code action |
| `gd`         | Go to definition |
| `<leader>u`  | Toggle undo history |
| `<leader>cp` | Toggle Copilot |
| `<leader>gg` | Toggle Fugitive |

---

## 💡 Project Notes

- This config is intentionally manual: rather than relying solely on “plug & play”, it encourages you to read, edit and understand the building blocks.
- Plugins are locked via lazy-lock.json to maintain reproducibility — but you’re free to update versions & test.
- Because you’re engineering the setup, occasional breaking changes may happen (especially on plugin upgrades) — treat it as an ongoing lab.
- Performance is a priority: features load when you need them, no bloat.
- Theming & UI aim to be subtle and distraction free — your code should shine.

---

## 🧩 Folder Structure

```
~/.config/nvim
├── init.lua
├── lua
│   ├── core
│   │   ├── hooks.lua
│   │   ├── lazy.lua
│   │   ├── mappings.lua
│   │   └── options.lua
│   └── plugins
│       │   └── lsp-config/
│       │       ├── lsp.lua
│       │       └── mason.lua
│       ├── animations.lua
│       ├── autopairs.lua
│       ├── colorscheme.lua
│       ├── completions.lua
│       ├── dashboard.lua
│       ├── editor.lua
│       ├── flash.lua
│       ├── formatter-linter.lua
│       ├── git.lua
│       ├── grug-far.lua
│       ├── harpoon.lua
│       ├── lualine.lua
│       ├── mini.lua
│       ├── neo-tree.lua
│       ├── neotest.lua
│       ├── oil.lua
│       ├── one-liners.lua
│       ├── peek.lua
│       ├── presence.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       └── ui.lua
│       └── utils.lua
└── README.md
```

---

## 🖱️ Screenshots

| **Dashboard** | **Telescope** |
|-----------|-----------|
| <img src="assets/dashboard.png" width="auto"/> | <img src="assets/telescope.png" width="auto"/> | 

| **Oil** | **Coding** |
|-----------|-----------|
| <img src="assets/oil.png" width="auto"/> | <img src="assets/coding.png" width="auto"/> |



---

## 🤝 Contributions

Contributions are always welcome!

Whether it's bug reports, feature requests, or pull requests, please feel free to open an issue or PR.

1.  Fork the repository.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

---

## 🧘 Project Philosophy

> “A tool should fade away and leave the work in front of you.”<br>
> ZenVim embraces this through three guiding truths:

1. **Clarity** — The config should be readable, navigable, and understandable.

2. **Control** — You always know what’s happening; you decide what gets loaded and when.

3. **Flow** — Your editor is a launchpad, not a barrier. No unnecessary friction, just momentum.
