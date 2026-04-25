# Neovim Configuration

A modern Neovim 0.11+ configuration written in Lua with AI-first approach via CodeCompanion and MCP support.

## Features

- **Fast startup** - `vim.loader` bytecode caching
- **Full LSP support** - Python, C/C++, Lua, SQL via mason.nvim
- **Smart completion** - blink.nvim AI-powered completion
- **Treesitter** - Syntax highlighting, indentation, text objects
- **Debugging** - nvim-dap with UI for Python, C/C++, Java
- **AI Assistant** - CodeCompanion with MCP servers (filesystem, memory, sequential-thinking, tavily, fetch, time)
- **Fuzzy finding** - Telescope with ripgrep/fd integration
- **Modern UI** - Tokyo Night theme, noice.nvim notifications, aerial.nvim outline

## Quick Start

```bash
# Clone configuration
git clone git@github.com:HowardChouX/easynvim.git ~/.config/nvim

# Start Neovim (lazy.nvim auto-installs plugins)
nvim

# Install LSP servers
:Mason

# Install Treesitter parsers
:TSInstall all
```

## Plugin List

lazy.nvim, blink.nvim, bufferline.nvim, cmp-buffer, cmp-cmdline, cmp-nvim-lsp, cmp-path, cmp-under-comparator, cmp_luasnip, dashboard-nvim, hop.nvim, indent-blankline.nvim, lspkind.nvim, lspsaga.nvim, lualine.nvim, mason-lspconfig.nvim, mason-tool-installer.nvim, mason.nvim, noice.nvim, nui.nvim, nvim-autopairs, nvim-cmp, nvim-dap, nvim-dap-ui, nvim-lspconfig, nvim-neotest/nvim-nio, nvim-notify, nvim-surround, nvim-treesitter, nvim-web-devicons, plenary.nvim, render-markdown.nvim, snacks.nvim, telescope-ui-select.nvim, telescope.nvim, tokyonight.nvim, vim-visual-multi, yazi.nvim, aeri

## Key Bindings

| Key | Action |
|-----|--------|
| `Space` | Leader prefix |
| `<C-s>` | Save file |
| `jj` | Exit insert mode |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>bh/bl` | Buffer prev/next |
| `<leader>q` | Toggle Aerial (code outline) |
| `<leader>e` | Open Yazi file manager |
| `<leader>a` | CodeCompanion chat |
| `<leader><tab>` | CodeCompanion actions |
| `<leader><F5>` | Start/Continue debug |
| `<leader><F9>` | Toggle breakpoint |
| `<leader><F10>` | Step over |
| `<leader><F11>` | Step into |
| `<leader><S-F11>` | Step out |
| `<leader><S-F5>` | Stop debug |
| `ff` | Hop word jump |
| `gd` | Go to definition (Lspsaga) |
| `<F2>` | Rename symbol (Lspsaga) |
| `<F1>` | Show keymaps (Telescope) |

## Dependencies

| Dependency | Purpose | Install (Arch) |
|------------|---------|----------------|
| Neovim 0.11+ | Editor | `pacman -S neovim` |
| Git | Plugin management | `pacman -S git` |
| Node.js | LSP/MCP servers | `pacman -S nodejs` |
| gcc | Treesitter compilation | `pacman -S gcc` |
| ripgrep | Telescope search | `pacman -S ripgrep` |
| fd | Telescope file search | `pacman -S fd` |

## Environment Variables

```bash
export ANTHROPIC_API_KEY="your-key"
export ANTHROPIC_MODEL="claude-3-5-sonnet-20241022"
export TAVILY_API_KEY="your-key"
```

## File Structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── basic.lua     # Editor options
│   │   ├── keymap.lua    # Keybindings
│   │   └── lazy.lua      # Plugin bootstrap
│   └── plugins/          # Plugin configs (lazy.nvim spec)
└── snippets/            # LuaSnip snippets
```
