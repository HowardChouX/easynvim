# 🚀 现代 Neovim 配置 (Neovim 0.12+ 就绪)

本仓库提供了一个**高性能、现代化的 Neovim 配置**，使用 Lua 编写。它集成了一系列精心挑选的插件，为您提供：
- 通过 `vim.loader` 字节码缓存实现的**快速启动**
- 支持多种语言（Python、C++、Lua 等）的**完整 LSP 支持**，通过 `mason.nvim` 自动安装
- 由 `nvim-cmp` 驱动的**智能补全**
- 通过 `nvim-treesitter` 实现的语法高亮、缩进和文本对象
- 通过 `telescope.nvim`、`nvim-tree` 和 `bufferline.nvim` 实现的模糊查找、文件资源管理和缓冲区标签
- Python 和 C++ 的**集成调试（DAP）**
- 通过 **Avante.nvim**（RAG 服务）实现的**AI 辅助编程**

---

## 📂 目录结构
```
~/.config/nvim/
├─ init.lua                # 入口点 - 加载核心配置和插件
├─ lua/
│  ├─ core/               # 基础选项、快捷键和懒加载配置
│  │   ├─ basic.lua        # 通用 Neovim 选项
│  │   ├─ keymap.lua       # 全局快捷键映射
│  │   └─ lazy.lua         # lazy.nvim 引导配置
│  └─ plugins/            # 单个插件配置
│      ├─ avante.lua        # AI RAG 服务集成
│      ├─ cmp.lua           # 补全引擎
│      ├─ dap.lua           # 调试适配器协议设置
│      ├─ lsp.lua           # LSP 服务器配置
│      ├─ mason.lua         # 外部工具安装器
│      ├─ telescope.lua     # 模糊查找器
│      ├─ nvim-tree.lua      # 文件资源管理器
│      ├─ bufferline.lua    # 缓冲区标签 UI
│      ├─ hop.lua           # 快速导航
│      ├─ grug-far.lua      # 全局搜索替换
│      ├─ lspsaga.lua       # 增强的 LSP UI
│      ├─ none-ls.lua       # 诊断和格式化
│      ├─ nvim-surround.lua # 环绕文本对象
│      └─ … (其他插件)
└─ AGENTS.md               # 未来维护者的交接文档
```

---

## ⚡ 核心功能
- **即时启动** - `vim.loader.enable()` 缓存编译后的 Lua 字节码
- **LSP 自动设置** - `mason.nvim` 确保语言服务器安装；根据文件类型懒启动服务器
- **智能补全** - `nvim-cmp` 提供 LSP、缓冲区、路径和代码片段等多种源
- **Treesitter** - 语法高亮、增量选择和文本对象
- **AI 辅助** - `avante.nvim` 在 Neovim 启动时自动启动 RAG 服务（基于 Docker）
- **调试功能** - `nvim-dap` 预配置支持 Python (`debugpy`) 和 C++ (`cppdbg`)
- **一致的 UI** - `tokyonight.nvim` 主题、`lualine` 状态栏、`bufferline` 标签页

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
| `avante.nvim` | AI 代码助手（RAG 服务） |
| `nvim-dap` + 适配器（`debugpy`、`cppdbg`） | 调试支持 |
| `nvim-surround` | 轻松环绕文本 |
| `indent-blankline.nvim` | 缩进指南 |
| `blink.cmp`（可选） | 替代补全源 |

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
| `F5` | Normal | 开始/继续调试 |
| `F9` | Normal | 切换断点 |
| `ja` | Normal | 询问 AI（Avante） |
| `F1` | Normal | 打开可搜索的快捷键面板 |

---

## 🛠️ 安装指南
1. **先决条件**
   - Neovim ≥ 0.12
   - Git
   - 较新的 Node.js（用于某些 LSP 服务器）
   - 可选但推荐：`ripgrep`、`fd`、`bat` 用于提升 Telescope 性能

2. **克隆配置**
   ```bash
   git clone <repo-url> ~/.config/nvim
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
   RAG 服务将在 Neovim 加载时自动启动

---

## 🐞 故障排除
- **插件安装失败** - 检查网络连接和 `git` 是否在 `PATH` 中。运行 `:Lazy clean` 然后 `:Lazy sync`
- **LSP 未附加** - 运行 `:Mason` 确保服务器已安装，并检查 `:LspInfo` 获取活动客户端
- **快捷键不工作** - 验证 `lua/core/keymap.lua` 是否在 `init.lua` 中加载。使用 `:verbose map <key>` 查看来源
- **Avante RAG 服务** - 运行 `:RAGStatus` 获取详细诊断。确保 Docker Desktop 正在运行且 API 密钥正确
- **主题缺失** - 安装缺失的主题插件或在 `lua/plugins/tokyonight.lua` 中更改名称

---

## 📄 功能特性

### 编辑体验
- **智能补全**：集成 LSP、缓冲区、路径和代码片段的多源补全
- **语法高亮**：基于 Treesitter 的现代化语法高亮
- **快速导航**：Hop 插件的字符级快速跳转
- **多光标编辑**：Visual-Multi 插件的多光标支持
- **环绕操作**：轻松添加、修改和删除文本环绕符号

### 开发工具
- **语言服务器**：支持 Python、C++、Lua、JavaScript/TypeScript、Java、HTML/CSS 等
- **调试支持**：集成 DAP，支持 Python 和 C++ 调试
- **代码格式化**：通过 null-ls 和 LSP 提供自动格式化
- **诊断信息**：实时显示错误和警告

### AI 辅助
- **Avante.nvim**：基于 RAG 的 AI 编程助手
- **多模型支持**：支持 Cherryin、OpenAI 等多种模型
- **代码生成**：智能代码建议和生成
- **问题解答**：上下文相关的编程问题解答

### 界面美化
- **主题系统**：Tokyo Night 主题，支持多种风格
- **状态栏**：Lualine 提供丰富的状态信息
- **文件树**：Nvim-tree 提供直观的文件导航
- **缓冲区管理**：Bufferline 提供标签页式缓冲区管理

---

## ⚙️ 配置说明

### 核心配置
配置分为三个主要部分：
- `basic.lua`：基础 Neovim 选项设置
- `keymap.lua`：全局快捷键映射
- `lazy.lua`：插件管理器设置

### 插件配置
每个插件在 `lua/plugins/` 目录下有独立的配置文件，支持：
- 懒加载优化
- 自定义选项
- 快捷键集成
- 依赖管理

### 自定义命令
- `:StartLSP`：手动启动 LSP 服务器
- `:DAP` 系列命令：调试相关操作
- `:Avante` 系列命令：AI 助手操作

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

### DAP 调试命令
```vim
:DAPStart          # 启动/继续调试
:DAPToggle         # 切换调试界面
:DAPBreakpoint     # 设置/切换断点
:DAPStep over      # 单步跳过
:DAPStep into      # 单步进入
:DAPStep out       # 单步跳出
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
-- 在 lsp.lua 中定义的服务器配置
_G.my_lsp_config = {
    capabilities = capabilities,
    on_attach = on_attach,
    servers = servers
}
```

### 插件配置接口
每个插件通过 `lazy.nvim` 的配置系统进行管理，支持事件触发、按键触发等多种加载策略。

---

## 🔄 与外部工具集成

### Docker 集成
- Avante RAG 服务使用 Docker 容器
- 自动启动和管理 RAG 服务

### Git 集成
- 内置 Git 状态显示
- 支持 Git 操作快捷键

### Shell 集成
- 内置终端支持
- 快捷键快速打开终端

---

## 🔍 故障排除 FAQ

### Q: 插件加载失败怎么办？
A: 检查网络连接，运行 `:Lazy clean` 然后 `:Lazy sync`

### Q: LSP 服务器不工作？
A: 确保服务器已通过 `:Mason` 安装，检查 `:LspInfo`

### Q: AI 助手无法启动？
A: 验证 Docker 是否运行，API 密钥是否正确设置

### Q: 快捷键冲突？
A: 使用 `:Telescope keymaps` 查看所有快捷键及其来源

### Q: 调试功能异常？
A: 确保调试适配器已安装，检查 DAP 配置

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
- `:DAP` 命令调试程序

---

*由项目维护者生成和维护。*

