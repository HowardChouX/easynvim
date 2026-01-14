-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	init = function()
		-- 基础配置
		vim.g.VM_theme = "ocean"
		vim.g.VM_highlight_matches = "underline"

		-- 键位映射配置
		-- 注意：Ctrl+Alt 组合键在某些终端可能被拦截，建议同时配置备用键
		vim.g.VM_maps = {
			-- 多行光标定位 (用户指定: Ctrl+Alt+Up/Down)
			["Add Cursor Up"] = "<C-M-Up>",
			["Add Cursor Down"] = "<C-M-Down>",

			-- 基础操作
			["Find Under"] = "<C-n>", -- 选中光标下单词
			["Find Subword Under"] = "<C-n>", -- 选中光标下子词
			["Select All"] = "<C-M-n>", -- 全选匹配项
			["Skip Region"] = "n", -- 跳过当前匹配
			["Remove Region"] = "Q", -- 移除当前光标

			-- 撤销/重做
			["Undo"] = "u",
			["Redo"] = "<C-r>",
		}
	end,
}
