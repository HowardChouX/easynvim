# 🚀 Modern Neovim Configuration (Neovim 0.12+ Ready)

This repository provides a **high‑performance, modern Neovim configuration** written in Lua. It bundles a carefully selected set of plugins that give you:
- Fast startup via `vim.loader` bytecode cache.
- Full LSP support for many languages (Python, C++, Lua, …) with automatic installation via `mason.nvim`.
- Powerful completion powered by `nvim-cmp`.
- Syntax highlighting, indentation and text objects via `nvim‑treesitter`.
- Fuzzy finding, file explorer and buffer line via `telescope.nvim`, `nvim‑tree` and `bufferline.nvim`.
- Integrated debugging (DAP) for Python and C++.
- AI‑assisted coding with **Avante.nvim** (RAG service).

---

## 📂 Directory Layout
```
~/.config/nvim/
├─ init.lua                # Entry point – loads core and plugins
├─ lua/
│  ├─ core/               # Basic options, keymaps and lazy‑loader config
│  │   ├─ basic.lua        # General Neovim options
│  │   ├─ keymap.lua       # Global key mappings
│  │   └─ lazy.lua         # lazy.nvim bootstrap
│  └─ plugins/            # Individual plugin configurations
│      ├─ avante.lua        # AI RAG service integration
│      ├─ cmp.lua           # Completion engine
│      ├─ dap.lua           # Debug Adapter Protocol settings
│      ├─ lsp.lua           # LSP server configuration
│      ├─ mason.lua         # External tool installer
│      ├─ telescope.lua     # Fuzzy finder
│      ├─ nvim‑tree.lua      # File explorer
│      ├─ bufferline.lua    # Buffer line UI
│      ├─ hop.lua           # Quick navigation
│      ├─ grug-far.lua      # Global search‑replace
│      ├─ lspsaga.lua       # Enhanced LSP UI
│      ├─ none‑ls.lua       # Diagnostics & formatting
│      ├─ nvim‑surround.lua # Surround text objects
│      └─ … (other plugins)
└─ AGENTS.md               # Handover document for future maintainers
```

---

## ⚡ Core Features
- **Instant startup** – `vim.loader.enable()` caches compiled Lua bytecode.
- **LSP auto‑setup** – `mason.nvim` ensures language servers are installed; servers are lazily started per filetype.
- **Smart completion** – `nvim-cmp` with sources for LSP, buffer, path and snippets.
- **Treesitter** – Syntax highlighting, incremental selection and text objects.
- **AI assistance** – `avante.nvim` automatically starts a RAG service (Docker‑based) when Neovim launches.
- **Debugging** – `nvim-dap` pre‑configured for Python (`debugpy`) and C++ (`cppdbg`).
- **Consistent UI** – `tokyonight.nvim` colorscheme, `lualine` statusline, `bufferline` tabs.

---

## 📦 Plugin Overview
| Plugin | Purpose |
|--------|----------|
| `lazy.nvim` | Plugin manager & lazy‑loading framework |
| `nvim‑tree` | File explorer |
| `telescope.nvim` | Fuzzy finder & live grep |
| `nvim‑cmp` | Completion framework |
| `luasnip` + `friendly‑snippets` | Snippet engine |
| `nvim‑lspconfig` + `mason.nvim` | LSP server management |
| `nvim‑treesitter` | Syntax highlighting & queries |
| `bufferline.nvim` | Buffer/tab line |
| `lualine.nvim` | Statusline |
| `lspsaga.nvim` | Enhanced LSP UI (peek, hover, diagnostics) |
| `none‑ls.nvim` | Diagnostics, code actions & formatting |
| `hop.nvim` | Quick navigation by characters/words |
| `grug-far.nvim` | Project‑wide search & replace |
| `avante.nvim` | AI code assistant (RAG service) |
| `nvim‑dap` + adapters (`debugpy`, `cppdbg`) | Debugging support |
| `nvim‑surround` | Easy surrounding of text |
| `indent‑blankline.nvim` | Indentation guides |
| `blink.cmp` (optional) | Alternative completion source |

---

## ⌨️ Keymaps (selected)
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>` | Normal | Leader prefix |
| `<C-s>` | Normal/Insert | Save file |
| `jj` | Insert | Exit insert mode |
| `<C-t>` | Normal | Toggle bottom terminal |
| `<Leader>ff` | Normal | Find files (Telescope) |
| `<Leader>fg` | Normal | Live grep (Telescope) |
| `<Leader>fr` | Normal | Global replace (Grug‑far) |
| `<Leader>u` | Normal | Toggle file tree |
| `gd` | Normal | Go to definition (LSP) |
| `gr` | Normal | List references |
| `K` | Normal | Hover documentation |
| `<Space>rn` | Normal | Rename symbol |
| `<Space>ca` | Normal | Code actions |
| `<Space>f` | Normal | Format buffer |
| `F5` | Normal | Start / continue debugging |
| `F9` | Normal | Toggle breakpoint |
| `nm` | Normal/Visual | Ask AI (Avante) |
| `F1` | Normal | Open searchable keymap panel |

---

## 🛠️ Installation Guide
1. **Prerequisites**
   - Neovim ≥ 0.12
   - Git
   - A recent Node.js (for some LSP servers)
   - Optional but recommended: `ripgrep`, `fd`, `bat` for Telescope performance
2. **Clone the config**
   ```bash
   git clone <repo‑url> ~/.config/nvim
   ```
3. **Launch Neovim** – on first start `lazy.nvim` will install all plugins automatically.
4. **Sync plugins** (if you need to force a reinstall)
   ```vim
   :Lazy sync
   ```
5. **Install language servers**
   ```vim
   :Mason
   ```
   Then install the servers you need (e.g., `pyright`, `ruff`, `clangd`).
6. **Verify AI service** – ensure Docker is running and the required API keys are set in your `~/.zshrc`:
   ```bash
   export OPEN_SOURCE_API_KEY="..."
   export SILICONFLOW_API_KEY="..."
   export TAVILY_API_KEY="..."
   ```
   The RAG service will start automatically when Neovim loads.

---

## 🐞 Troubleshooting
- **Plugins fail to install** – check internet connectivity and that `git` is in your `PATH`. Run `:Lazy clean` then `:Lazy sync`.
- **LSP not attaching** – run `:Mason` to ensure the server is installed, and check `:LspInfo` for active clients.
- **Keybindings not working** – verify `lua/core/keymap.lua` is required in `init.lua`. Use `:verbose map <key>` to see the source.
- **Avante RAG service** – run `:RAGStatus` for detailed diagnostics. Ensure Docker Desktop is running and API keys are correct.
- **Colorscheme missing** – install the missing colorscheme plugin or change the name in `lua/plugins/tokyonight.lua`.

---

## 📄 Handover Document
A detailed handover guide for future maintainers is available in **AGENTS.md** at the repository root.

---

*Generated and maintained by the project maintainers.*
