# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim 0.11+ configuration using `lazy.nvim` as the plugin manager. The config is written in Lua with the primary AI assistant being CodeCompanion with full MCP (Model Context Protocol) support.

## Architecture

```
~/.config/nvim/
├── init.lua              # Entry point - loads core modules in order: basic, keymap, lazy
├── lua/
│   ├── core/
│   │   ├── basic.lua     # Editor options (numbers, tabs, clipboard, etc.)
│   │   ├── keymap.lua    # All keybindings with Chinese descriptions
│   │   └── lazy.lua      # lazy.nvim bootstrap and plugin import
│   └── plugins/          # Individual plugin configs (lazy.nvim spec)
├── snippets/             # LuaSnip snippets (JSON format)
└── plugin/               # Generated plugin directory
```

**Plugin Loading Pattern**: Each file in `lua/plugins/` returns a lazy.nvim spec table. `lazy.lua` imports all plugins via `{ import = "plugins" }`.

## Common Commands

### Plugin Management
```vim
:Lazy sync        " Install/update/clean plugins
:Lazy clean       " Remove unused plugins
:Lazy profile     " Analyze startup performance
:Lazy health      " Check plugin health status
```

### LSP & Formatting
```vim
:Mason            " Open Mason UI to install LSP servers
:MasonInstall all " Install all configured LSP servers and tools
:LspInfo          " Show attached LSP clients
:LspRestart       " Restart LSP server for current buffer
:TSInstall all    " Install all Treesitter parsers
:TSUpdate         " Update Treesitter parsers
```

### Debugging (DAP)
```vim
<leader><F5>     " Start/Continue debug
<leader><F9>     " Toggle breakpoint
<leader><F10>    " Step over
<leader><F11>    " Step into
<leader><S-F11>  " Step out
<leader><S-F5>   " Stop debug
<leader>dv       " Show variables (dapui)
<leader>dw       " Show watch expressions (dapui)
<leader>ds       " Show call stack (dapui)
```

### CodeCompanion (AI Assistant)
```vim
<leader>a              " Toggle CodeCompanion chat
<leader><tab>          " Open CodeCompanion action palette
```

### Telescope Search
```vim
<leader>ff      " Find files
<leader>fg      " Live grep (requires ripgrep)
<leader>fb      " Find buffers
<leader>fh      " Find help tags
```

## Configuration Patterns

### Adding a New Plugin
Create a new file in `lua/plugins/` that returns a lazy.nvim spec:
```lua
---@diagnostic disable: undefined-global
return {
  "author/plugin-name",
  event = "VeryLazy",
  opts = { /* plugin options */ },
}
```

### LSP Server Configuration
LSP servers are configured in `lua/plugins/mason.lua` using Neovim 0.11's `vim.lsp.config()` API:
```lua
vim.lsp.config("server_name", {
  filetypes = { "lua" },
  settings = { ... },
})
```

### Keymap Binding Rules

**重要原则**：所有快捷键必须统一管理在 `lua/core/keymap.lua` 中，禁止在插件配置文件里直接定义快捷键。

All keymaps include Chinese descriptions with source tags:
```lua
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
  { desc = "查找文件 (Find Files) --插件(Telescope)" })
```

Description format: `中文描述 (English Description) --类型`
- Type tags: `--系统`、`--自定义`、`--插件(名称)`

keymap.lua auto-reloads on save via BufWritePost autocmd.

## Plugin Ecosystem

### Core Plugins
- **lazy.nvim**: Plugin manager with lazy loading
- **mason.nvim**: LSP/DAP/Linter/Formatter installer
- **nvim-lspconfig**: LSP client configuration
- **nvim-cmp**: Completion engine
- **blink.nvim**: AI-powered code completion
- **telescope.nvim**: Fuzzy finder
- **nvim-treesitter**: Syntax highlighting and parsing
- **codecompanion.nvim**: AI coding assistant with MCP support
- **noice.nvim**: Modern UI components
- **aerial.nvim**: Code outline sidebar
- **dashboard-nvim**: Startup screen

### UI & Navigation
- **tokyonight.nvim**: Color theme
- **lualine.nvim**: Status line
- **bufferline.nvim**: Buffer tabs
- **indent-blankline.nvim**: Indentation guides
- **hop.nvim**: Easy motion navigation
- **yazi.nvim**: File manager integration

### Editing & LSP
- **conform.nvim**: Code formatting
- **lspsaga.nvim**: Enhanced LSP UI
- **nvim-autopairs**: Auto-pair brackets
- **vim-visual-multi**: Multiple cursors
- **nvim-surround**: Text surrounding operations

### Debugging
- **nvim-dap**: Debug Adapter Protocol client
- **nvim-dap-ui**: DAP UI components
- **nvim-java**: Java debugging support (with java.lua config)

## Pre-configured LSP Servers

- `lua_ls` - Lua
- `pyright` - Python
- `clangd` - C/C++
- `sqls` - SQL

## Pre-configured Formatters (via conform.nvim)

- `stylua` - Lua
- `black` - Python
- `clang-format` - C/C++

## Key Bindings Reference

| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>d` | Dashboard |
| `<leader>f` | Format code (Conform) |
| `<leader>bh/bl` | Buffer prev/next |
| `<leader>a` | CodeCompanion Chat |
| `<leader><tab>` | CodeCompanion Actions |
| `<leader>q` | Toggle Aerial (code outline) |
| `<leader>e` | Open Yazi file manager |
| `<leader>t` | Toggle terminal |
| `<leader>nd` | Dismiss notification (Noice) |
| `ff` | Hop word jump |
| `jj` | Exit insert mode |
| `<C-s>` | Save file |
| `<F1>` | Show keymaps (Telescope) |
| `<F2>` | Rename symbol (Lspsaga) |
| `gd` | Go to definition (Lspsaga) |
| `H` / `L` | Line start / end |
| `tt` / `bb` | Page up / down |

## Dependencies

Required external tools:
- `git` - Plugin management
- `node` + `npm` - LSP servers, MCP servers
- `gcc` - Treesitter compilation
- `ripgrep` + `fd` - Telescope search (recommended)

## Environment Variables

For AI functionality, set these in your shell:
```bash
export ANTHROPIC_API_KEY="your-key"
export ANTHROPIC_MODEL="claude-3-5-sonnet-20241022"
export TAVILY_API_KEY="your-key"
```

## File Structure Conventions

- `lua/core/` - Core configuration (basic, keymaps, lazy loading)
- `lua/plugins/` - Individual plugin configurations
- Each plugin gets its own `.lua` file returning a lazy.nvim spec table
- Keymaps are centralized in `keymap.lua`
- LSP configurations are in `mason.lua`
- AI assistant configuration is in `codecompanion.lua`
