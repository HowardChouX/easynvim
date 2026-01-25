--- @diagnostic disable: undefined-global

--------------------------------------------------------------------------------
-- 0. Neovide 专用快捷键 (Neovide Specific Keymaps)
--------------------------------------------------------------------------------
-- 只有在 Neovide 运行时才启用这些快捷键
if vim.g.neovide then
	-- 定义一个 Lua 函数来切换 Neovide 的全屏状态
	local function toggle_neovide_fullscreen()
		-- 切换 vim.g.neovide_fullscreen 的布尔值
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
		-- 打印消息提示用户全屏状态已切换
		if vim.g.neovide_fullscreen then
			print("Neovide: 进入全屏模式")
		else
			print("Neovide: 退出全屏模式")
		end
	end

	-- 将这个 Lua 函数注册为一个用户命令
	-- 这样我们就可以在键位映射中使用 <cmd> 命令来调用它
	vim.api.nvim_create_user_command("NeovideToggleFullscreen", toggle_neovide_fullscreen, {})

	-- 映射 Ctrl+F11 键来执行 NeovideToggleFullscreen 命令
	-- 适用于普通模式 (Normal), 插入模式 (Insert), 可视模式 (Visual), 终端模式 (Terminal)
	vim.keymap.set(
		"n",
		"<C-F11>",
		"<cmd>NeovideToggleFullscreen<CR>",
		{ noremap = true, silent = true, desc = "切换 Neovide 全屏 (Toggle Neovide Fullscreen) --Neovide" }
	)
	vim.keymap.set(
		"i",
		"<C-F11>",
		"<cmd>NeovideToggleFullscreen<CR>",
		{ noremap = true, silent = true, desc = "切换 Neovide 全屏 (Toggle Neovide Fullscreen) --Neovide" }
	)
	vim.keymap.set(
		"v",
		"<C-F11>",
		"<cmd>NeovideToggleFullscreen<CR>",
		{ noremap = true, silent = true, desc = "切换 Neovide 全屏 (Toggle Neovide Fullscreen) --Neovide" }
	)
	vim.keymap.set(
		"t",
		"<C-F11>",
		"<cmd>NeovideToggleFullscreen<CR>",
		{ noremap = true, silent = true, desc = "切换 Neovide 全屏 (Toggle Neovide Fullscreen) --Neovide" }
	)
end

--------------------------------------------------------------------------------
-- 1. 基础配置与 Leader (Basic Config & Leader)
--------------------------------------------------------------------------------

-- Leader 键设置
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- 为 Leader 键添加描述 (主要用于 Telescope 等插件的显示)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Leader 键 (Prefix Key) --系统" })

-- <Ctrl-z> 绑定为撤销 (undo)
vim.keymap.set({ "n", "i" }, "<C-z>", "<Cmd>undo<CR>", { silent = true, desc = "撤销 (Undo) --自定义" })

-- F1: 显示快捷键帮助 (依赖 Telescope 插件)
vim.keymap.set(
	{ "n", "i" },
	"<F1>",
	"<cmd>Telescope keymaps<CR>",
	{ noremap = true, silent = true, desc = "显示快捷键列表 (Show Keymaps) --系统" }
)

--------------------------------------------------------------------------------
-- 2. 插入模式优化 (Insert Mode Enhancements)
--------------------------------------------------------------------------------

-- Insert 模式下：jj = Esc (快速退出插入模式)
vim.keymap.set(
	"i",
	"jj",
	"<Esc>",
	{ noremap = true, silent = true, desc = "退出插入模式 (Exit Insert Mode) --自定义" }
)

-- Insert 模式下：<C-s> 保存文件 (退出插入 → 保存 → 回到插入)
vim.keymap.set(
	"i",
	"<C-s>",
	"<Esc>:w<CR>a",
	{ noremap = true, silent = true, desc = "保存文件 (Save File) --自定义" }
)

-- Insert 模式翻页 (已注释，如果需要可启用)
-- vim.keymap.set("i", "tt", "<Esc><C-b>", { noremap = true, silent = true, desc = "向上翻页 (Page Up) --自定义" })
-- vim.keymap.set("i", "bb", "<Esc><C-f>", { noremap = true, silent = true, desc = "向下翻页 (Page Down) --自定义" })

--------------------------------------------------------------------------------
-- 3. 窗口与终端 (Window & Terminal Management)
--------------------------------------------------------------------------------

-- Normal 模式下：<C-t> 打开终端 (底部分屏，高度为 8 行)
vim.keymap.set(
	"n",
	"<C-t>",
	":botright 8split | terminal<CR>",
	{ noremap = true, silent = true, desc = "打开底部终端 (Open Bottom Terminal) --系统" }
)

-- Terminal 模式下：jj 切换到 Normal 模式 (退出终端插入模式)
vim.keymap.set(
	"t",
	"jj",
	[[<C-\><C-n>]],
	{ noremap = true, silent = true, desc = "终端模式 -> 普通模式 (Terminal -> Normal) --系统" }
)

-- Terminal 模式下：Esc 切换到 Normal 模式 (退出终端插入模式)
vim.keymap.set(
	"t",
	"<Esc>",
	[[<C-\><C-n>]],
	{ noremap = true, silent = true, desc = "终端模式 -> 普通模式 (Terminal -> Normal) --系统" }
)

--------------------------------------------------------------------------------
-- 4. 常用编辑操作 (Common Editing Operations)
--------------------------------------------------------------------------------

-- Normal 模式下：<C-s> 保存文件
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "保存文件 (Save File) --自定义" })

-- 自定义翻页：tt = PageUp, bb = PageDown
vim.keymap.set("n", "tt", "<C-b>", { noremap = true, silent = true, desc = "向上翻页 (Page Up) --自定义" })
vim.keymap.set("n", "bb", "<C-f>", { noremap = true, silent = true, desc = "向下翻页 (Page Down) --自定义" })

-- 常用系统快捷键补充 (Common System Keymaps)
vim.keymap.set("n", "dd", "dd", { desc = "删除当前行 (Delete Line) --系统" })
vim.keymap.set("n", "yy", "yy", { desc = "复制当前行 (Yank Line) --系统" })
vim.keymap.set("n", "p", "p", { desc = "粘贴 (Paste) --系统" })
vim.keymap.set("n", "P", "P", { desc = "上方粘贴 (Paste Above) --系统" })
vim.keymap.set("n", "u", "u", { desc = "撤销 (Undo) --系统" })
vim.keymap.set("n", "<C-r>", "<C-r>", { desc = "重做 (Redo) --系统" })
vim.keymap.set("n", "gg", "gg", { desc = "跳转到文件首 (Go to Start) --系统" })
vim.keymap.set("n", "G", "G", { desc = "跳转到文件尾 (Go to End) --系统" })
vim.keymap.set("n", "/", "/", { desc = "向下搜索 (Search Forward) --系统" })
vim.keymap.set("n", "?", "?", { desc = "向上搜索 (Search Backward) --系统" })
vim.keymap.set("n", "n", "n", { desc = "下一个搜索结果 (Next Result) --系统" })
vim.keymap.set("n", "N", "N", { desc = "上一个搜索结果 (Prev Result) --系统" })
vim.keymap.set("v", "<", "<gv", { desc = "向左缩进 (Indent Left) --系统" })
vim.keymap.set("v", ">", ">gv", { desc = "向右缩进 (Indent Right) --系统" })

--------------------------------------------------------------------------------
-- 5. 光标移动与模式切换 (Cursor Movement & Mode Switching)
--------------------------------------------------------------------------------

-- 基础光标移动 (Basic Movement)
vim.keymap.set("n", "h", "h", { desc = "左移 (Left) --系统" })
vim.keymap.set("n", "j", "j", { desc = "下移 (Down) --系统" })
vim.keymap.set("n", "k", "k", { desc = "上移 (Up) --系统" })
vim.keymap.set("n", "l", "l", { desc = "右移 (Right) --系统" })
vim.keymap.set("n", "0", "0", { desc = "行首 (Start of Line) --系统" })
vim.keymap.set("n", "$", "$", { desc = "行尾 (End of Line) --系统" })

-- 模式切换与可视块 (Mode Switching & Visual Block)
vim.keymap.set("n", "i", "i", { desc = "光标前插入 (Insert Before Cursor) --系统" })
vim.keymap.set("n", "I", "I", { desc = "行首插入 (Insert at Line Start) --系统" })
vim.keymap.set("n", "a", "a", { desc = "光标后插入 (Append After Cursor) --系统" })
vim.keymap.set("n", "A", "A", { desc = "行尾插入 (Append at Line End) --系统" })
vim.keymap.set("n", "o", "o", { desc = "下方插入新行 (Open Line Below) --系统" })
vim.keymap.set("n", "O", "O", { desc = "上方插入新行 (Open Line Above) --系统" })
vim.keymap.set("n", "s", "s", { desc = "删除字符并插入 (Substitute Char) --系统" })
vim.keymap.set("n", "S", "S", { desc = "删除整行并插入 (Substitute Line) --系统" })
vim.keymap.set("n", "v", "v", { desc = "可视模式-字符 (Visual Char) --系统" })
vim.keymap.set("n", "V", "V", { desc = "可视模式-行 (Visual Line) --系统" })
vim.keymap.set("n", "<C-q>", "<C-v>", { desc = "可视模式-块 (Visual Block) --自定义" }) -- 用户习惯 Ctrl+q

--------------------------------------------------------------------------------
-- 6. 文本对象与高级操作 (Text Objects & Advanced Operations)
--------------------------------------------------------------------------------

-- 文本对象与操作 (Text Objects & Operations)
vim.keymap.set("n", "x", "x", { desc = "剪切字符 (Cut Char) --系统" })
vim.keymap.set("n", "diw", "diw", { desc = "删除当前单词 (Delete Inner Word) --系统" })
vim.keymap.set("n", "daw", "daw", { desc = "删除单词及空格 (Delete Around Word) --系统" })
vim.keymap.set("n", 'yi"', 'yi"', { desc = "复制双引号内容 (Yank Inner Quotes) --系统" })
vim.keymap.set("n", "da{", "da{", { desc = "删除大括号及内容 (Delete Around Braces) --系统" })
vim.keymap.set("n", "cit", "cit", { desc = "修改标签内容 (Change Inner Tag) --系统" })

-- 移动指令组合 (Movement Combinations)
vim.keymap.set("n", "d2w", "d2w", { desc = "删除后续2个单词 (Delete 2 Words) --系统" })
vim.keymap.set("n", "y3e", "y3e", { desc = "复制到第3个单词结尾 (Yank 3 Ends) --系统" })
vim.keymap.set("n", "dt", "dt", { desc = "删除直到字符... (Delete Till) --系统" })
vim.keymap.set("n", "ygg", "ygg", { desc = "复制到文件头 (Yank to Start) --系统" })
vim.keymap.set("n", "dG", "dG", { desc = "删除到文件尾 (Delete to End) --系统" })
vim.keymap.set("n", "dj", "dj", { desc = "删除本行和下一行 (Delete 2 Lines) --系统" })
vim.keymap.set("n", "d3k", "d3k", { desc = "删除本行及上三行 (Delete 4 Lines Up) --系统" })
vim.keymap.set("n", "dgg", "dgg", { desc = "删除到文件开头 (Delete to Start) --系统" })
vim.keymap.set("n", "ggyG", "ggyG", { desc = "复制全文 (Yank All) --系统" })

-- Word vs WORD (单词跳转)
vim.keymap.set("n", "w", "w", { desc = "下个单词开头 (Word Start) --系统" })
vim.keymap.set("n", "e", "e", { desc = "单词结尾 (Word End) --系统" })
vim.keymap.set("n", "b", "b", { desc = "上个单词开头 (Word Back) --系统" })
vim.keymap.set("n", "ge", "ge", { desc = "上个单词结尾 (Word End Back) --系统" })
vim.keymap.set("n", "W", "W", { desc = "下个字串开头 (WORD Start) --系统" })
vim.keymap.set("n", "E", "E", { desc = "字串结尾 (WORD End) --系统" })
vim.keymap.set("n", "B", "B", { desc = "上个字串开头 (WORD Back) --系统" })

-- 标记与行内搜索 (Marks & Inline Search)
vim.keymap.set("n", "m", "m", { desc = "设置标记 m{char} (Set Mark) --系统" })
vim.keymap.set("n", "'", "'", { desc = "跳转到标记 '{char} (Jump to Mark) --系统" })
vim.keymap.set("n", "''", "''", { desc = "回到上次跳转位置 (Jump Back) --系统" })
vim.keymap.set("n", "'^", "'^", { desc = "回到上次插入位置 (Last Insert) --系统" })
vim.keymap.set("n", "f", "f", { desc = "向右查找字符 f{char} (Find Char) --系统" })
vim.keymap.set("n", "F", "F", { desc = "向左查找字符 F{char} (Find Char Back) --系统" })
vim.keymap.set("n", ";", ";", { desc = "重复查找字符-向后 (Repeat Find) --系统" })
vim.keymap.set("n", ",", ",", { desc = "重复查找字符-向前 (Repeat Find Rev) --系统" })
vim.keymap.set("n", "*", "*", { desc = "搜索光标下单词 (Search Word) --系统" })

-- 寄存器操作 (Registers)
vim.keymap.set("n", '"', '"', { desc = "指定寄存器 (Select Register) --系统" })
vim.keymap.set("n", '"_', '"_', { desc = "黑洞寄存器-不保存 (Black Hole) --系统" })
vim.keymap.set("n", '"+', '"+', { desc = "系统剪贴板 (System Clipboard) --系统" })
vim.keymap.set("n", '"ayy', '"ayy', { desc = "复制行到a寄存器 (Yank to 'a') --系统" })
vim.keymap.set("n", '"ap', '"ap', { desc = "粘贴a寄存器内容 (Paste from 'a') --系统" })

-- 替换与宏 (Replace & Macro)
vim.keymap.set("n", "r", "r", { desc = "替换单个字符 (Replace Char) --系统" })
vim.keymap.set("n", "q", "q", { desc = "录制宏 (Record Macro) --系统" })
vim.keymap.set("n", "@", "@", { desc = "执行宏 (Replay Macro) --系统" })

--------------------------------------------------------------------------------
-- 7. 缓冲区与列表 (Buffer & List Navigation)
--------------------------------------------------------------------------------

-- 多行光标 (Multicursor) - 插件: Visual-Multi
vim.keymap.set(
	"n",
	"<C-M-Up>",
	"<Cmd>call vm#commands#add_cursor_up(0, 1)<CR>",
	{ desc = "向上添加光标 (Add Cursor Up) --插件(Visual-Multi)" }
)
vim.keymap.set(
	"n",
	"<C-M-Down>",
	"<Cmd>call vm#commands#add_cursor_down(0, 1)<CR>",
	{ desc = "向下添加光标 (Add Cursor Down) --插件(Visual-Multi)" }
)
vim.keymap.set(
	"n",
	"<C-n>",
	"<Plug>(VM-Find-Under)",
	{ desc = "选中光标下单词 (Find Under) --插件(Visual-Multi)" }
)
vim.keymap.set(
	"x",
	"<C-n>",
	"<Plug>(VM-Find-Subword-Under)",
	{ desc = "选中光标下子词 (Find Subword) --插件(Visual-Multi)" }
)
vim.keymap.set("n", "<C-M-n>", "\\A", { desc = "全选匹配项 (Select All) --插件(Visual-Multi)" })
vim.keymap.set("n", "n", "<Plug>(VM-Skip-Region)", { desc = "跳过当前匹配 (Skip Region) --插件(Visual-Multi)" })
vim.keymap.set(
	"n",
	"Q",
	"<Plug>(VM-Remove-Region)",
	{ desc = "移除当前光标 (Remove Region) --插件(Visual-Multi)" }
)

-- 列表/缓冲区导航 (List/Buffer Navigation)
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "上一个缓冲区 (Prev Buffer) --自定义" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "下一个缓冲区 (Next Buffer) --自定义" })
vim.keymap.set("n", "[B", "<cmd>bfirst<CR>", { desc = "第一个缓冲区 (First Buffer) --自定义" })
vim.keymap.set("n", "]B", "<cmd>blast<CR>", { desc = "最后一个缓冲区 (Last Buffer) --自定义" })
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>", { desc = "上一个速查项 (Prev Quickfix) --自定义" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "下一个速查项 (Next Quickfix) --自定义" })
vim.keymap.set("n", "[l", "<cmd>lprevious<CR>", { desc = "上一个位置项 (Prev Location) --自定义" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>", { desc = "下一个位置项 (Next Location) --自定义" })

-- 插入空行 (Insert Empty Line)
vim.keymap.set("n", "[<Space>", function()
	vim.cmd("put! =''")
end, { desc = "上方插入空行 (Add Empty Line Above) --自定义" })
vim.keymap.set("n", "]<Space>", function()
	vim.cmd("put =''")
end, { desc = "下方插入空行 (Add Empty Line Below) --自定义" })

--------------------------------------------------------------------------------
-- 8. 插件快捷键 (Plugin Specific Keymaps)
--------------------------------------------------------------------------------

-- Telescope 插件快捷键
vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<CR>",
	{ desc = "查找文件 (Find Files) --插件(Telescope)" }
)
vim.keymap.set("n", "<leader>fg", function()
	-- 检查 ripgrep 是否可用
	local has_rg = false
	if vim.fn.executable("rg") == 1 or vim.fn.executable("ripgrep") == 1 then
		has_rg = true
	end

	if has_rg then
		-- ripgrep 可用，使用 live_grep 进行全局搜索
		vim.cmd("Telescope live_grep")
	else
		-- ripgrep 不可用，使用普通的 find_files 替代并发出警告
		vim.notify(
			"ripgrep 未安装，使用文件查找替代。推荐安装 ripgrep 以获得更好的搜索体验。",
			vim.log.levels.WARN
		)
		vim.cmd("Telescope find_files")
	end
end, { desc = "全局搜索 (Live Grep) --插件(Telescope)" })

-- NvimTree 插件快捷键
vim.keymap.set(
	"n",
	"<leader>u",
	":NvimTreeToggle<CR>",
	{ desc = "切换文件树 (Toggle File Tree) --插件(NvimTree)" }
)

-- Bufferline 插件快捷键
vim.keymap.set(
	"n",
	"<leader>bh",
	":BufferLineCyclePrev<CR>",
	{ silent = true, desc = "切换上一个标签 (Prev Buffer) --插件(Bufferline)" }
)
vim.keymap.set(
	"n",
	"<leader>bl",
	":BufferLineCycleNext<CR>",
	{ silent = true, desc = "切换下一个标签 (Next Buffer) --插件(Bufferline)" }
)
vim.keymap.set(
	"n",
	"<leader>bp",
	":BufferLinePickClose<CR>",
	{ silent = true, desc = "选择关闭标签 (Pick Close) --插件(Bufferline)" }
)
vim.keymap.set(
	"n",
	"<leader>bc",
	":BufferLineCloseOthers<CR>",
	{ silent = true, desc = "关闭其他标签 (Close Others) --插件(Bufferline)" }
)
vim.keymap.set(
	"n",
	"<leader>bd",
	":bdelete<CR>",
	{ silent = true, desc = "删除当前缓冲区 (Delete Buffer) --插件(Bufferline)" }
)

-- GrugFar 插件快捷键
vim.keymap.set("n", "<leader>fr", ":GrugFar<CR>", { desc = "查找与替换 (Find & Replace) --插件(GrugFar)" })

-- Hop 插件快捷键
vim.keymap.set("n", "ff", "<Cmd>HopWord<CR>", { silent = true, desc = "单词跳转 (Hop Word) --插件(Hop)" })

-- Lspsaga 插件快捷键
vim.keymap.set("n", "<F2>", ":Lspsaga rename<CR>", { desc = "全局重命名变量 (Rename) --插件(Lspsaga)" })
vim.keymap.set("n", "<leader>lc", ":Lspsaga code_action<CR>", { desc = "代码修复 (Code Action) --插件(Lspsaga)" })
vim.keymap.set(
	"n",
	"<leader>ld",
	":Lspsaga definition<CR>",
	{ desc = "跳转到定义 (Peek Definition) --插件(Lspsaga)" }
)
vim.keymap.set(
	"n",
	"<leader>lh",
	":Lspsaga hover_doc<CR>",
	{ desc = "查看文档说明 (Hover Doc) --插件(Lspsaga)" }
)
vim.keymap.set(
	"n",
	"<leader>lR",
	":Lspsaga finder<CR>",
	{ desc = "查找引用和定义 (LSP Finder) --插件(Lspsaga)" }
)
vim.keymap.set(
	"n",
	"<leader>n",
	":Lspsaga diagnostic_jump_next<CR>",
	{ desc = "跳转到下一个诊断 (Next Diagnostic) --插件(Lspsaga)" }
)
vim.keymap.set(
	"n",
	"<leader>p",
	":Lspsaga diagnostic_jump_prev<CR>",
	{ desc = "跳转到上一个诊断 (Prev Diagnostic) --插件(Lspsaga)" }
)

-- None-ls 插件快捷键
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end, { desc = "格式化代码 (Format Code) --插件(None-ls)" })

-- DAP (Debug Adapter Protocol) 插件快捷键
vim.keymap.set("n", "<F9>", function()
	require("dap").toggle_breakpoint()
end, { desc = "切换断点 (Toggle Breakpoint) --插件(DAP)" })
vim.keymap.set("n", "<Leader><F9>", function()
	require("dap").set_breakpoint(vim.fn.input("断点条件: "))
end, { desc = "设置条件断点 (Conditional Breakpoint) --插件(DAP)" })

vim.keymap.set("n", "<F5>", function()
	local dap = require("dap")
	if dap.session() then
		dap.continue()
	else
		if vim.bo.filetype == "python" and dap.configurations.python then
			dap.run(dap.configurations.python[1])
		else
			dap.continue()
		end
	end
end, { desc = "智能启动/继续调试 (Start/Continue Debug) --插件(DAP)" })

vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "单步跳过 (Step Over) --插件(DAP)" })
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "单步进入 (Step Into) --插件(DAP)" }) -- 注意: F11 仍用于 DAP，Ctrl+F11 用于 Neovide 全屏
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "单步跳出 (Step Out) --插件(DAP)" })
vim.keymap.set("n", "<F6>", function()
	require("dapui").toggle()
end, { desc = "切换调试界面 (Toggle Debug UI) --插件(DAP)" })
vim.keymap.set("n", "<F7>", function()
	require("dap").repl.open()
end, { desc = "打开调试控制台 (Open REPL) --插件(DAP)" })

-- ToggleTerm 插件快捷键
vim.keymap.set(
	"t",
	"jj",
	[[<C-\><C-n>]],
	{ noremap = true, silent = true, desc = "退出终端插入模式 (Exit Term Insert) --插件(ToggleTerm)" }
)
vim.keymap.set("t", "<Esc>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
	vim.defer_fn(function()
		if vim.bo.buftype == "terminal" then
			vim.cmd("bd!")
		end
	end, 20)
end, { noremap = true, silent = true, desc = "关闭终端 (Close Terminal) --插件(ToggleTerm)" })

-- LSP (Native & Autocommands) 快捷键
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local opts = { buffer = bufnr }

		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			{ desc = "跳转到声明 (Go to Declaration) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"gd",
			vim.lsp.buf.definition,
			{ desc = "跳转到定义 (Go to Definition) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"K",
			vim.lsp.buf.hover,
			{ desc = "显示文档 (Hover Documentation) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			{ desc = "跳转到实现 (Go to Implementation) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			{ desc = "签名帮助 (Signature Help) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"<space>rn",
			vim.lsp.buf.rename,
			{ desc = "重命名变量 (Rename) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			{ "n", "v" },
			"<space>ca",
			vim.lsp.buf.code_action,
			{ desc = "代码操作 (Code Action) --系统(LSP)", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"gr",
			vim.lsp.buf.references,
			{ desc = "查看引用 (References) --系统(LSP)", buffer = bufnr }
		)
	end,
})

-- Avante AI 助手 插件快捷键
vim.keymap.set("n", "<leader>aa", function()
	require("avante.api").ask()
end, { desc = "显示侧边栏 (Show Sidebar) --插件(Avante)" })
vim.keymap.set("n", "<leader>an", "<cmd>AvanteChatNew<CR>", { desc = "创建新聊天 (New Chat) --插件(Avante)" })
vim.keymap.set("n", "<leader>ar", function()
	require("avante.api").refresh()
end, { desc = "刷新侧边栏 (Refresh Sidebar) --插件(Avante)" })
vim.keymap.set("n", "<leader><tab>", function()
	require("avante.api").focus()
end, { desc = "切换侧边栏焦点 (Toggle Sidebar Focus) --插件(Avante)" })
vim.keymap.set("n", "<leader>ac", function()
	require("avante.api").select_model()
end, { desc = "选择模型 (Select Model) --插件(Avante)" })
vim.keymap.set(
	"n",
	"<leader>ae",
	"<cmd>AvanteEdit<CR>",
	{ desc = "编辑选定的块 (Edit Selected Block) --插件(Avante)" }
)
vim.keymap.set(
	"n",
	"<leader>at",
	"<cmd>AvanteToggle<CR>",
	{ desc = "切换 Avante 侧边栏 (Toggle Avante Sidebar) --插件(Avante)" }
)
vim.keymap.set("n", "<leader>az", function()
	require("avante.api").zen_mode()
end, { desc = "进入 Avante Zen 模式 (Enter Avante Zen Mode) --插件(Avante)" })
vim.keymap.set("n", "<leader>as", "<cmd>AvanteStop<CR>", { desc = "停止 Avante (Stop Avante) --插件(Avante)" })
