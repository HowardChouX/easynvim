-- plugins/nvim-tree.lua
---@diagnostic disable: undefined-global
return {
	"nvim-tree/nvim-tree.lua",
	lazy = false, -- [关键] 必须设为 false，否则启动时不会加载
	dependencies = { "nvim-tree/nvim-web-devicons" },

	-- [关键] 在插件加载前禁用 netrw，这是官方推荐的做法
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,

	opts = {
		-- 接管目录的核心配置
		hijack_netrw = true,
		hijack_directories = {
			enable = true,
			auto_open = true,
		},

		-- 自动同步配置 (替代了废弃的 update_to_buf_dir)
		sync_root_with_cwd = true,
		respect_buf_cwd = true,

		-- 你的其他偏好
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	},
}
