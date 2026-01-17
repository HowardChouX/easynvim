# 🚀 现代 Neovim 配置 (Neovim 0.11+)

本仓库提供了一个**高性能、现代化的 Neovim 配置**，使用 Lua 编写。它集成了一系列精心挑选的插件，为您提供：
- 通过 `vim.loader` 字节码缓存实现的**快速启动**
- 支持多种语言（Python、C++、Lua 等）的**完整 LSP 支持**，通过 `mason.nvim` 自动安装
- 由 `nvim-cmp` 驱动的**智能补全**
- 通过 `nvim-treesitter` 实现的语法高亮、缩进和文本对象
- 通过 `telescope.nvim`、`nvim-tree` 和 `bufferline.nvim` 实现的模糊查找、文件资源管理和缓冲区标签
- 通过 **Avante.nvim** 和 **MCP Hub** 实现的**AI 辅助编程**

---

## 📂 目录结构
```
~/.config/nvim/
├─ init.lua                # 入口点 - 加载核心配置和插件
├─ lua/
│  ├─ core/               # 基础选项、快捷键和懒加载配置
│  │   ├─ basic.lua        # 通用 Neovim 选项
│  │   ├─ keymap.lua       # 全局快捷键映射
│  │   ├─ lazy.lua         # lazy.nvim 引导配置
│  │   └─ neovide_config.lua # Neovide 图形界面配置
│  └─ plugins/            # 单个插件配置
│      ├─ avante.lua        # AI 助手集成
│      ├─ bufferline.lua    # 缓冲区标签 UI
│      ├─ cmp.lua           # 补全引擎
│      ├─ diagnostics.lua   # 诊断配置
│      ├─ grug-far.lua      # 全局搜索替换
│      ├─ hop.lua           # 快速导航
│      ├─ indent-blankline.lua # 缩进指南
│      ├─ lspsaga.lua       # 增强的 LSP UI
│      ├─ lualine.lua       # 状态栏
│      ├─ mason.lua         # 外部工具安装器
│      ├─ mcphub.lua        # MCP Hub 服务器管理
│      ├─ multicursor.lua   # 多光标编辑
│      ├─ noice.lua         # 现代化通知系统
│      ├─ none-ls.lua       # 诊断和格式化
│      ├─ nvim-autopairs.lua # 自动括号配对
│      ├─ nvim-surround.lua # 环绕文本对象
│      ├─ nvim-tree.lua     # 文件资源管理器
│      ├─ nvim-treesitter.lua # 语法高亮和查询
│      ├─ render-markdown.lua # Markdown 渲染
│      ├─ telescope.lua     # 模糊查找器
│      ├─ toggleterm.lua    # 终端管理
│      └─ tokyonight.lua    # Tokyo Night 主题
└─ AGENTS.md               # 未来维护者的交接文档
```

---

## ⚡ 核心功能
- **即时启动** - `vim.loader.enable()` 缓存编译后的 Lua 字节码
- **LSP 自动设置** - `mason.nvim` 确保语言服务器安装；根据文件类型懒启动服务器
- **智能补全** - `nvim-cmp` 提供 LSP、缓冲区、路径和代码片段等多种源
- **Treesitter** - 语法高亮、增量选择和文本对象
- **AI 辅助** - `avante.nvim` 集成多种 AI 模型和 `mcphub.nvim` 提供 MCP 服务器支持
- **一致的 UI** - `tokyonight.nvim` 主题、`lualine` 状态栏、`bufferline` 标签页
- **现代化界面** - `noice.nvim` 提供美观的命令行和通知界面

---

## 📦 插件概览
| 插件 | 用途 |
|------|------|
| `lazy.nvim` | 插件管理器 & 懒加载框架 |
| `nvim-tree` | 文件资源管理器 |
| `telescope.nvim` | 模糊查找器和实时搜索 |
| `nvim-cmp` | 补全框架 |
| `luasnip` + `friendly-snippets` | 代码片段引擎 |
| `nvim-lspconfig` + `mason.nvim` | LSP 服务器管理 |
| `nvim-treesitter` | 语法高亮和查询 |
| `bufferline.nvim` | 缓冲区/标签栏 |
| `lualine.nvim` | 状态栏 |
| `lspsaga.nvim` | 增强的 LSP UI（预览、悬停、诊断） |
| `none-ls.nvim` | 诊断、代码操作和格式化 |
| `hop.nvim` | 按字符/单词快速导航 |
| `grug-far.nvim` | 项目范围的搜索和替换 |
| `avante.nvim` | AI 代码助手（多模型支持） |
| `mcphub.nvim` | MCP 服务器管理和工具集成 |
| `nvim-surround` | 轻松环绕文本 |
| `indent-blankline.nvim` | 缩进指南 |
| `nvim-autopairs` | 自动括号配对 |
| `visual-multi` | 多光标编辑 |
| `toggleterm.nvim` | 终端管理 |
| `noice.nvim` | 现代化通知和命令行界面 |
| `nvim-notify` | 美观的通知系统 |
| `tokyonight.nvim` | Tokyo Night 主题 |

---

## ⌨️ 快捷键（精选）
| 按键 | 模式 | 描述 |
|------|------|------|
| `<Space>` | Normal | Leader 前缀 |
| `<C-s>` | Normal/Insert | 保存文件 |
| `jj` | Insert | 退出插入模式 |
| `<C-t>` | Normal | 切换底部终端 |
| `<Leader>ff` | Normal | 查找文件（Telescope） |
| `<Leader>fg` | Normal | 实时搜索（Telescope） |
| `<Leader>fr` | Normal | 全局替换（Grug-far） |
| `<Leader>u` | Normal | 切换文件树 |
| `gd` | Normal | 跳转到定义（LSP） |
| `gr` | Normal | 列出引用 |
| `K` | Normal | 悬停文档 |
| `<Space>rn` | Normal | 重命名符号 |
| `<Space>ca` | Normal | 代码操作 |
| `<Space>f` | Normal | 格式化缓冲区 |
| `<Leader>aa` | Normal | 显示 AI 助手侧边栏 |
| `<F1>` | Normal | 打开可搜索的快捷键面板 |

---

## 🛠️ 安装指南
1. **先决条件**
   - Neovim ≥ 0.11
   - Git
   - 较新的 Node.js（用于某些 LSP 服务器）
   - 可选但推荐：`ripgrep`、`fd`、`bat` 用于提升 Telescope 性能

2. **克隆配置**
   ```bash
   git clone git@github.com:HowardChouX/easynvim.git ~/.config/nvim
   ```

3. **启动 Neovim** - 首次启动时 `lazy.nvim` 将自动安装所有插件

4. **同步插件**（如果需要强制重新安装）
   ```vim
   :Lazy sync
   ```

5. **安装语言服务器**
   ```vim
   :Mason
   ```
   然后安装您需要的服务器（例如 `pyright`、`ruff`、`clangd`）

6. **验证 AI 服务** - 确保 Docker 正在运行，并在 `~/.zshrc` 中设置所需的 API 密钥：
   ```bash
   export OPEN_SOURCE_API_KEY="..."
   export SILICONFLOW_API_KEY="..."
   export TAVILY_API_KEY="..."
   ```
   Avante AI 助手将在加载时自动集成 MCP Hub 服务

---

## 🐞 故障排除
- **插件安装失败** - 检查网络连接和 `git` 是否在 `PATH` 中。运行 `:Lazy clean` 然后 `:Lazy sync`
- **LSP 未附加** - 运行 `:Mason` 确保服务器已安装，并检查 `:LspInfo` 获取活动客户端
- **快捷键不工作** - 验证 `lua/core/keymap.lua` 是否在 `init.lua` 中加载
- **AI 助手问题** - 确保 MCP Hub 连接正常，检查 API 密钥配置
- **主题缺失** - 安装缺失的主题插件或在 `lua/plugins/tokyonight.lua` 中更改名称

---

## 📄 功能特性

### 编辑体验
- **智能补全**：集成 LSP、缓冲区、路径和代码片段的多源补全
- **语法高亮**：基于 Treesitter 的现代化语法高亮
- **快速导航**：Hop 插件的字符级快速跳转
- **多光标编辑**：Visual-Multi 插件的多光标支持
- **环绕操作**：轻松添加、修改和删除文本环绕符号
- **自动配对**：自动完成括号、引号等符号配对

### 开发工具
- **语言服务器**：支持 Python、C++、Lua、Racket、JavaScript/TypeScript、HTML/CSS 等
- **代码格式化**：通过 none-ls 和 LSP 提供自动格式化
- **诊断信息**：实时显示错误和警告
- **现代化界面**：Noice.nvim 提供美观的通知和命令行界面

### AI 辅助
- **Avante.nvim**：基于 MCP Hub 的 AI 编程助手
- **多模型支持**：支持 Cherryin (GLM-4.6、DeepSeek、Qwen)、OpenAI、Ollama 等多种模型
- **MCP 集成**：自动集成文件系统、Git、时间、SQLite 等 MCP 服务器
- **智能权限**：安全的自动授权机制，保护项目安全
- **代码生成**：智能代码建议和生成

### 界面美化
- **主题系统**：Tokyo Night 主题，支持多种风格
- **状态栏**：Lualine 提供丰富的状态信息
- **文件树**：Nvim-tree 提供直观的文件导航
- **缓冲区管理**：Bufferline 提供标签页式缓冲区管理
- **缩进指南**：清晰的缩进线可视化
- **Neovide 支持**：针对 GUI 版本的优化配置

---

## ⚙️ 配置说明

### 核心配置
配置分为四个主要部分：
- `basic.lua`：基础 Neovim 选项设置
- `keymap.lua`：全局快捷键映射（包含智能描述系统）
- `lazy.lua`：插件管理器设置
- `neovide_config.lua`：Neovide 图形界面专用配置

### 插件配置
每个插件在 `lua/plugins/` 目录下有独立的配置文件，支持：
- 懒加载优化（VeryLazy、事件触发等）
- 自定义选项和依赖管理
- 快捷键集成和配置

### 自定义命令
- `:Mason` 系列命令：LSP 服务器管理
- `:Telescope` 系列命令：文件查找和搜索
- `:Lspsaga` 系列命令：增强 LSP 操作
- `:Avante` 系列命令：AI 助手操作
- `:NullLsInfo`：格式化工具状态

---

## 🔧 命令行参考

### Mason 命令
```vim
:Mason              # 打开 Mason UI
:MasonInstall       # 安装特定包
:MasonUpdate        # 更新所有包
:MasonUninstall     # 卸载包
:MasonLog           # 查看日志
```

### Telescope 命令
```vim
:Telescope find_files    # 查找文件
:Telescope live_grep     # 实时搜索
:Telescope keymaps       # 快捷键搜索
:Telescope buffers       # 缓冲区搜索
```

---

## 📁 配置文件 API

### 基础配置接口
```lua
-- 在 basic.lua 中设置的基础选项
vim.opt.number = true          -- 显示行号
vim.opt.relativenumber = true  -- 相对行号
vim.opt.expandtab = true       -- Tab 转空格
vim.g.mapleader = " "          -- Leader 键
```

### LSP 配置接口
```lua
-- 在 mason.lua 中定义的服务器配置
vim.lsp.config("lua_ls", {
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
```

### 插件配置接口
每个插件通过 `lazy.nvim` 的配置系统进行管理，支持事件触发、按键触发等多种加载策略。

---

## 🔄 与外部工具集成

### MCP Hub 集成
- **自动服务器管理**：智能启动和停止 MCP 服务器
- **安全权限控制**：危险操作需要手动确认
- **文件系统集成**：安全的文件读写操作
- **Git 状态显示**：内置 Git 状态信息

### Shell 集成
- **内置终端支持**：ToggleTerm 提供便捷的终端访问
- **快捷键快速打开**：Ctrl+T 快速打开底部终端

---

## 🔍 故障排除 FAQ

### Q: 插件加载失败怎么办？
A: 检查网络连接和 `git` 是否在 `PATH` 中。运行 `:Lazy clean` 然后 `:Lazy sync`

### Q: LSP 服务器不工作？
A: 运行 `:Mason` 确保服务器已安装，并检查 `:LspInfo`

### Q: AI 助手无法启动？
A: 确保 MCP Hub 连接正常，检查 API 密钥配置

### Q: 快捷键冲突？
A: 使用 `:Telescope keymaps` 查看所有快捷键及其来源

---

## 📚 维护者手册

### 添加新插件
1. 在 `lua/plugins/` 目录下创建新的配置文件
2. 使用 `lazy.nvim` 的配置语法
3. 测试插件的懒加载行为

### 自定义主题
- 修改 `lua/plugins/tokyonight.lua`
- 支持多种 Tokyo Night 风格
- 可替换为其他主题插件

### 性能优化
- 使用 `vim.loader` 缓存
- 合理配置懒加载策略
- 定期清理不必要的插件

### 调试技巧
- 使用 `:Lazy profile` 分析插件性能
- `:LspInfo` 检查 LSP 状态
- `:NullLsInfo` 检查格式化工具状态

---


