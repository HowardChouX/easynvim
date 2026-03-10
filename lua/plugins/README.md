# CodeCompanion.nvim 使用指南

## 快速启动

| 命令 | 说明 |
|------|------|
| `:CodeCompanion` | 打开聊天窗口 |
| `:CodeCompanionChat` | 新建聊天 |
| `:CodeCompanionActions` | 打开操作面板 |

## 聊天窗口快捷键

| 快捷键 | 模式 | 说明 |
|--------|------|------|
| `<CR>` | n | 发送消息 |
| `<C-CR>` | i | 发送消息 |
| `q` | n | 关闭聊天 |
| `<C-c>` | i | 关闭聊天 |
| `?` | n | 查看帮助选项 |

## 内联助手快捷键

| 快捷键 | 模式 | 说明 |
|--------|------|------|
| `ga` | n | 接受建议更改 |
| `gr` | n | 拒绝建议更改 |
| `q` | n | 停止请求 |

## 触发前缀

| 前缀 | 用途 | 示例 |
|------|------|------|
| `/` | Slash 命令 | `/file`, `/buffer`, `/help` |
| `#` | 编辑器上下文 | `#buffer`, `#lsp` |
| `@` | 工具调用 | `@full_stack_dev`, `@run_command` |
| `\` | ACP Slash 命令 | `\命令` |

## 自定义提示 (Prompt Library)

### 通过命令调用

```vim
:CodeCompanion review   " 代码审查
:CodeCompanion explain  " 解释代码
:CodeCompanion refactor " 重构代码
:CodeCompanion fix      " 修复代码 (inline)
:CodeCompanion comment  " 添加注释 (inline)
```

### 通过操作面板

1. 执行 `:CodeCompanionActions`
2. 选择对应的提示
3. 如需选中代码，先进入 Visual 模式

## Slash 命令

在聊天窗口中使用：

| 命令 | 说明 |
|------|------|
| `/file` | 选择文件插入内容 |
| `/buffer` | 选择缓冲区插入内容 |
| `/help` | 搜索 Vim 帮助文档 |

## 工具 (Tools)

### 内置工具

| 工具 | 说明 |
|------|------|
| `read_file` | 读取文件 |
| `insert_edit_into_file` | 编辑文件 |
| `run_command` | 运行命令 |
| `grep_search` | 搜索代码 (需要 rg) |

### 工具组

| 工具组 | 说明 |
|--------|------|
| `@full_stack_dev` | 全栈开发助手 - 包含编辑、运行、搜索功能 |

### 安全审批

以下工具执行前需要用户确认：
- `run_command` - 运行命令
- `insert_edit_into_file` - 编辑文件

## MCP 服务器

### 已配置服务器

| 服务器 | 说明 | 状态 |
|--------|------|------|
| `sequential-thinking` | 顺序思考 | 默认启动 |
| `filesystem` | 文件系统访问 | 按需启动 |
| `tavily-mcp` | 网络搜索 | 按需启动 |

### MCP 管理

```vim
:MCPHub                    " 打开 MCP 管理界面
:CodeCompanionChat RefreshCache  " 刷新工具缓存
```

### 在聊天中使用 MCP

```
/mcp                        " 查看 MCP 服务器列表
```

## 规则系统

### 自动加载的规则文件

项目根目录下以下文件会被自动加载：
- `CLAUDE.md` - Claude 规则
- `CLAUDE.local.md` - 本地 Claude 规则
- `.cursorrules` - Cursor 规则
- `.rules` - 通用规则
- `AGENT.md` / `AGENTS.md` - 代理指令

### 规则示例

```markdown
# 项目规则

## 代码风格
- 使用 2 空格缩进
- 函数命名使用 snake_case
- 变量命名使用 camelCase

## 禁止事项
- 不要使用 var 声明变量
- 不要忽略错误处理
```

## 编辑器上下文

在聊天中使用 `#{上下文}` 插入：

| 上下文 | 说明 |
|--------|------|
| `#buffer` | 当前缓冲区内容 |
| `#lsp` | LSP 诊断信息 |
| `#git` | Git 状态 |

## 常用工作流

### 代码审查

1. 选中代码 (Visual 模式)
2. 执行 `:CodeCompanion review`
3. 查看审查结果
4. 可追加问题继续讨论

### 快速修复

1. 选中问题代码 (Visual 模式)
2. 执行 `:CodeCompanion fix`
3. 查看差异预览
4. 按 `ga` 接受或 `gr` 拒绝

### 添加注释

1. 选中代码 (Visual 模式)
2. 执行 `:CodeCompanion comment`
3. 查看添加注释后的预览
4. 按 `ga` 接受或 `gr` 拒绝

---

# 维护指南

## 配置文件位置

```
~/.config/nvim/lua/plugins/codecompanion.lua
```

## 更新插件

```vim
:Lazy update codecompanion.nvim
```

## 重新加载配置

```vim
:Lazy reload codecompanion.nvim
" 或重启 Neovim
```

## 环境变量

确保以下环境变量已设置：

| 变量 | 说明 |
|------|------|
| `ANTHROPIC_API_KEY` | API 密钥 |
| `ANTHROPIC_BASE_URL` | API 基础 URL (可选) |
| `ANTHROPIC_MODEL` | 模型名称 (默认: GLM-5) |
| `TAVILY_API_KEY` | Tavily 搜索 API (可选) |

## 检查依赖

### 必需依赖

```bash
# 检查 Node.js (MCP 服务器需要)
node --version

# 检查 npm/npx
npx --version

# 检查 ripgrep (grep_search 工具需要)
rg --version
```

### 安装依赖

```bash
# Ubuntu/Debian
sudo apt install nodejs npm ripgrep

# macOS
brew install node ripgrep
```

## 日志调试

```vim
" 查看 CodeCompanion 日志
:CodeCompanion log

" 查看 LSP 日志
:LspLog
```

## 常见问题

### 1. MCP 服务器启动失败

```bash
# 手动安装 MCP 服务器
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-sequential-thinking
```

### 2. API 连接失败

检查环境变量：
```bash
echo $ANTHROPIC_API_KEY
echo $ANTHROPIC_BASE_URL
```

### 3. 工具不显示

```vim
" 刷新缓存
:CodeCompanionChat RefreshCache
```

### 4. 补全不工作

确保安装了 blink.cmp：
```vim
:Lazy check blink.cmp
```

## 配置备份

```bash
# 备份配置
cp ~/.config/nvim/lua/plugins/codecompanion.lua ~/.config/nvim/lua/plugins/codecompanion.lua.bak
```

## 版本信息查看

```vim
:CodeCompanion version
:Lazy show codecompanion.nvim
```

## 卸载/重置

```vim
" 卸载插件
:Lazy uninstall codecompanion.nvim

" 删除缓存
:!rm -rf ~/.local/share/nvim/codecompanion
```

---

## 配置结构参考

```
~/.config/nvim/lua/plugins/codecompanion.lua
├── triggers          # 触发前缀
├── display           # 显示配置
│   ├── action_palette
│   ├── diff
│   ├── chat
│   └── inline
├── prompt_library    # 提示库
├── interactions      # 交互配置
│   ├── chat
│   │   ├── roles
│   │   ├── keymaps
│   │   ├── slash_commands
│   │   └── tools
│   ├── inline
│   └── background
├── rules             # 规则配置
├── adapters          # 适配器配置
│   ├── acp
│   └── http
├── extensions        # 扩展配置
└── mcp               # MCP 服务器配置
```

## 相关链接

- [CodeCompanion GitHub](https://github.com/olimorris/codecompanion.nvim)
- [CodeCompanion 文档](https://codecompanion.olimorris.dev)
- [MCP 协议](https://modelcontextprotocol.io)