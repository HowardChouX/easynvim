# 🚀 Modern Neovim Configuration (Neovim 0.12+ Ready)

这是一个高度优化、现代化且功能完备的 Neovim 配置，专为提升开发效率而设计。基于 Lua 编写，深度集成了 LSP（语言服务器）、DAP（调试适配器）、Treesitter（语法高亮）以及 Telescope（模糊搜索）。

**核心亮点**：
*   ⚡ **极速启动**：启用 Lua 字节码缓存 (`vim.loader`)，启动时间通常在 100ms 左右。
*   🐍 **Python 深度优化**：集成 Pyright (LSP) + Ruff (Linter) + Debugpy (DAP)，提供 IDE 级的 Python 开发体验。
*   ⚡ **C++ 性能调优**：定制 Clangd 参数，支持后台索引与内存缓存，大型项目也能秒级响应。
*   🐛 **开箱即用的调试**：一键 F5 启动调试，支持断点、单步执行、变量监视与 REPL。
*   🔍 **智能辅助**：自动补全、自动导入、代码格式化一应俱全。
*   🤖 **AI 增强 (Avante)**：集成 RAG 服务，提供智能代码助手和文档查询功能。

---

## 🤖 Avante RAG 服务自动启动

### 🚀 自动启动功能
配置已集成智能的 RAG 服务自动启动功能，无需手动管理：

**自动检测与启动**：
- ✅ 检查 Docker 状态和 API 密钥可用性
- ✅ 验证 RAG 服务健康状态
- ✅ 自动启动/重启不健康的服务
- ✅ 直接从 `.zshrc` 读取环境变量

**手动控制命令**：
```vim
:RAGStatus    " 检查 RAG 服务状态
:RAGStart     " 手动启动服务
:RAGStop      " 手动停止服务
:RAGRestart   " 重启服务
```

**环境变量要求**（在 `.zshrc` 中设置）：
```bash
export OPEN_SOURCE_API_KEY="your_cherryin_api_key"
export SILICONFLOW_API_KEY="your_siliconflow_api_key"
export TAVILY_API_KEY="your_tavily_api_key"
```

### 🔧 源代码构建配置

**前置要求**：
- ✅ **Rust/Cargo 工具链**：用于从源代码构建 Avante
- ✅ **Docker**：RAG 服务运行环境

**构建配置**：
```lua
build = vim.fn.has("win32") ~= 0 and "powershell "..vim.fn.shellescape("-ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false")
    or "make BUILD_FROM_SOURCE=true",
```

**构建选项说明**：
- `BUILD_FROM_SOURCE=true`：强制从源代码构建
- 默认使用 `make` 命令进行构建
- Windows 系统使用 PowerShell 脚本构建

### 💻 Rust/Cargo 开发环境要求

**Rust 工具链安装**：
```bash
# 使用 rustup 安装 Rust (推荐)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 或使用包管理器安装
# Ubuntu/Debian
sudo apt install rustc cargo

# macOS (使用 Homebrew)
brew install rustup
rustup-init

# Windows
# 下载并运行 rustup-init.exe 或使用 Chocolatey
choco install rust
```

**验证安装**：
```bash
# 检查 Rust 版本
rustc --version
cargo --version

# 添加 Rust 到 PATH (如果使用 rustup)
# 重启终端或运行：source $HOME/.cargo/env
```

**为什么需要 Rust/Cargo？**
- Avante.nvim 的核心组件（tokenizers、templates、repo-map、html2md）使用 Rust 编写
- Cargo 是 Rust 的包管理器，用于编译这些高性能组件
- 从源代码构建可以获得最新的功能和性能优化

**快速验证构建**：
```bash
# 在 Neovim 中测试构建
nvim +"Lazy sync"

# 或手动触发构建
cd ~/.local/share/nvim/lazy/avante.nvim
make BUILD_FROM_SOURCE=true
```

---

## ⌨️ 快捷键查询表 (Shortcut Key Lookup)

💡 **提示**：在 Neovim 中按下 **`F1`** 可直接打开交互式快捷键搜索面板。所有快捷键均已添加描述，方便检索。

### 1. 通用操作 (General)
| 快捷键 | 模式 | 描述 |
| :--- | :--- | :--- |
| `nm` | Normal/Visual | **AI 提问 (Avante RAG)** |
| `<Space>` | Normal | Leader 键 (前缀键) |
| `<C-s>` | Normal/Insert | 00. 保存文件 (Save File) |
| `<C-z>` | Normal/Insert | 01. 撤销 (Undo) |
| `jj` | Insert | 02. 退出插入模式 (Exit Insert Mode) |
| `tt` | Normal/Insert | 05. 向上翻页 (Page Up) |
| `bb` | Normal/Insert | 05. 向下翻页 (Page Down) |
| `<C-t>` | Normal | 03. 打开底部终端 (Open Bottom Terminal) |
| `jj` | Terminal | 04. 终端模式 -> 普通模式 (Terminal -> Normal) |
| `Esc` | Terminal | 04. 终端模式 -> 普通模式 (Terminal -> Normal) |

### 2. 文件与搜索 (Files & Search)
| 快捷键 | 描述 |
| :--- | :--- |
| `<Leader>ff` | 10. 查找文件 (Find Files) |
| `<Leader>fg` | 11. 全局搜索 (Live Grep) |
| `<Leader>fr` | 12. 全局查找替换 (Grug Far) |
| `<Leader>u` | 13. 切换文件树 (Toggle File Tree) |
| `ff` | 14. 单词跳转 (Hop Word) |

### 3. 代码导航与 LSP (LSP Navigation)
| 快捷键 | 描述 |
| :--- | :--- |
| `gd` | 20. 跳转到定义 (Go to Definition) |
| `gD` | 20. 跳转到声明 (Go to Declaration) |
| `gr` | 26. 查看引用 (References) |
| `gi` | 22. 跳转到实现 (Go to Implementation) |
| `K` | 21. 显示文档 (Hover Documentation) |
| `<C-k>` | 23. 签名帮助 (Signature Help) |
| `<Space>rn` |24. 重命名变量 (Rename) |
| `<Space>ca` | 25. 代码操作 (Code Action) |
| `<Space>f` | 27. 格式化代码 (Format Code) |
| **Lspsaga 增强命令**: | |
| `<F2>` | 24. 智能重命名 (Lspsaga Rename) |
| `<Leader>ld` | 30. 预览定义 (Peek Definition) |
| `<Leader>lh` | 31. 悬浮文档 (Hover Doc) |
| `<Leader>lR` | 32. 查找引用 (Finder) |
| `<Leader>n` | 33. 下一个诊断 (Diagnostic Next) |
| `<Leader>p` | 34. 上一个诊断 (Diagnostic Prev) |

### 4. 标签页与缓冲区 (Bufferline)
| 快捷键 | 描述 |
| :--- | :--- |
| `<Leader>bh` | 50. 切换上一个标签 (Buffer Prev) |
| `<Leader>bl` | 51. 切换下一个标签 (Buffer Next) |
| `<Leader>bp` | 52. 选择关闭标签 (Pick Close) |
| `<Leader>bc` | 53. 关闭其他标签 (Close Others) |
| `<Leader>bd` | 54. 删除当前缓冲区 (Buffer Delete) |
| `[b` | 55. 上一个缓冲区 (Prev Buffer) |
| `]b` | 56. 下一个缓冲区 (Next Buffer) |

### 5. 辅助功能与调试 (Utils & DAP)
| 快捷键 | 描述 |
| :--- | :--- |
| `[q` / `]q` | 59/60. 切换速查项 (Prev/Next Quickfix) |
| `[l` / `]l` | 61/62. 切换位置项 (Prev/Next Location) |
| `[<Space>` | 65. 上方插入空行 (Add Empty Line Above) |
| `]<Space>` | 66. 下方插入空行 (Add Empty Line Below) |
| **调试 (Debug/DAP)**: | |
| **`F5`** | **42. 智能启动/继续调试 (Start/Continue Debug)** |
| **`F6`** | 46. 切换调试界面 (Toggle Debug UI) |
| **`F7`** | 47. 打开调试控制台 (Open REPL) |
| **`F9`** | 40. 切换断点 (Toggle Breakpoint) |
| **`<Leader> + F9`** | 41. 设置条件断点 (Conditional Breakpoint) |
| **`F10`** | 43. 单步跳过 (Step Over) |
| **`F11`** | 44. 单步进入 (Step Into) |
| **`F12`** | 45. 单步跳出 (Step Out) |

---

## 🛠️ 安装指南 (Installation)

### 前置要求
*   **Neovim >= 0.10** (推荐 0.12+)
*   **Git**
*   **Nerd Font** (推荐 JetBrainsMono Nerd Font，用于显示图标)
*   **构建工具**: `gcc`, `make`, `python3`, `npm` (用于安装各类语言服务器)

### 安装步骤
1.  **备份旧配置**:
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    ```

2.  **克隆仓库**:
    ```bash
    git clone [你的仓库地址] ~/.config/nvim
    ```

3.  **首次启动**:
    打开终端输入 `nvim`。Lazy.nvim 插件管理器会自动开始安装所有插件。请耐心等待安装完成。

4.  **安装语言工具**:
    在 Neovim 中输入 `:MasonInstallAll` (如果配置了) 或 `:Mason` 手动安装：
    *   Python: `pyright`, `ruff`, `debugpy`
    *   C++: `clangd`
    *   Lua: `lua-language-server`

---

## 📂 目录结构说明

```text
lua/
├── core/                  # 核心基础配置
│   ├── basic.lua          # 基础 Vim 选项 (行号, 缩进等)
│   ├── keymap.lua         # 全局快捷键
│   └── lazy.lua           # 插件管理器引导
└── plugins/               # 插件模块 (功能分类)
    ├── lsp.lua            # LSP 语言服务器配置 (核心)
    ├── dap.lua            # DAP 调试配置 (Python/C++)
    ├── cmp.lua            # 自动补全引擎
    ├── mason.lua          # 外部工具管理器
    ├── telescope.lua      # 模糊搜索
    ├── nvim-treesitter.lua# 语法高亮与缩进
    ├── nvim-tree.lua      # 文件资源管理器
    ├── bufferline.lua     # 顶部标签栏
    ├── toggleterm.lua     # 内置终端
    ├── hop.lua            # 快速跳转
    ├── grug-far.lua       # 全局查找替换
    ├── avante.lua         # AI 增强 (RAG 服务自动启动)
    └── ...

# RAG 服务相关文件
├── docker-compose.yml     # Docker 容器配置
├── start-rag-service.sh   # 自动化部署脚本
├── start-rag-service.ps1  # Windows 部署脚本
├── verify-setup.sh        # 系统验证脚本
├── .env.example           # 环境变量模板
├── lua/rag-autostart.lua  # 自动启动逻辑
└── lua/rag-commands.lua   # 用户命令管理
```

## ⚡ 性能优化细节

1.  **Lua Loader**: 强制开启 `vim.loader.enable()`，利用字节码缓存加速启动。
2.  **LSP 懒加载**: 仅在打开特定文件类型时才启动对应的 LSP 服务器。
3.  **Python 优化**:
    *   `pyright` 配置为仅检查打开的文件 (`openFilesOnly`)，避免扫描整个 `venv` 导致卡顿。
    *   引入 `ruff` 进行极速 Linting。
4.  **Clangd 优化**:
    *   启用后台索引 (`--background-index`)。
    *   启用 PCH 内存存储 (`--pch-storage=memory`)。
    *   启用并行解析 (`-j=4`)。

### 🤖 AI 增强功能实现细节

#### Avante RAG 服务集成

#### 自动启动机制
- **集成位置**: `lua/plugins/avante.lua` 插件配置中
- **启动时机**: Avante 插件加载完成后延迟 5 秒
- **智能检测**: 自动检查 Docker 状态、API 密钥可用性、服务健康状况

#### Docker Compose 配置
- **配置文件**: `docker-compose.yml`
- **健康检查**: 内置健康端点监控
- **端口映射**: 20250:20250
- **数据挂载**: `/host` 容器路径映射到本地目录
- **权限管理**: 使用当前用户 ID 避免权限问题

#### API 密钥管理
- **来源**: 直接从 `.zshrc` 环境变量读取
- **验证**: 启动前检查所有必需密钥
- **错误处理**: 明确显示缺失的密钥名称

### 一键部署脚本
- `start-rag-service.sh` - Linux/WSL2 自动化部署
- `start-rag-service.ps1` - Windows PowerShell 部署
- `verify-setup.sh` - 系统状态验证

---

## ❓ 常见问题

**Q: RAG 服务自动启动失败？**
A: 检查以下项目：
- Docker Desktop 是否正在运行
- `.zshrc` 中的 API 密钥是否正确设置
- 运行 `:RAGStatus` 查看详细错误信息

**Q: 调试器启动失败 "Debug adapter didn't respond"?**
A: 这通常是因为首次安装 `debugpy` 需要时间，或者网络超时。我们已将超时时间延长至 20秒。请尝试重启 Neovim 或运行 `:MasonInstall debugpy` 手动重装。

**Q: 快捷键不工作?**
A: 请检查是否与您的终端快捷键冲突（例如 `Ctrl+F9` 常被终端占用，请使用 `<Leader>+F9`）。可以使用 `F1` 查看当前生效的快捷键。

**Q: RAG 服务健康检查失败？**
A: 运行 `docker-compose logs avante-rag-service` 查看详细日志，通常是因为 API 密钥无效或网络问题。
