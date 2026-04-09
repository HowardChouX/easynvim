-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	priority = 1000,
	event = "VeryLazy",
	opts = {
		terminal = {
			-- 终端配置：右边分屏 (Snack 特有功能)
			win = {
				position = "right",
				split = "vertical",
				width = 0.4,
				border = "single",
				winblend = 0,
			},
		},
		-- 禁用 Snack 的通用功能（使用其他插件替代）
		notifier = { enabled = false },     -- 使用 noice.nvim
		dashboard = { enabled = false },    -- 使用 dashboard-nvim
		explorer = { enabled = false },     -- 使用 yazi.nvim
		input = { enabled = false },        -- 使用 Telescope
		picker = { enabled = false },       -- 使用 Telescope
		quickfile = { enabled = false },    -- 使用 Telescope

		-- 启用 Snack 的特有功能
		bigfile = { enabled = true },       -- 大文件优化（Snack 特有）
		indent = { enabled = true },        -- 智能缩进（Snack 特有）
		scope = { enabled = true },         -- 代码作用域高亮（Snack 特有）
		scroll = { enabled = true },        -- 平滑滚动（Snack 特有）
		statuscolumn = { enabled = true },  -- 智能状态列（Snack 特有）
		words = { enabled = true },         -- 单词跳转增强（Snack 特有）
	},

	-- 禁用所有快捷键（遵循集中管理原则）
	keys = {},

	init = function()
		-- 防止 Snack 修改全局配置
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- 仅设置 Snack 特有的调试工具
				_G.dd = function(...)
					require("snacks.debug").inspect(...)
				end
			end,
		})
	end,
}
