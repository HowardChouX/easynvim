-- 告诉 Lua 语言服务器 vim 是全局变量
---diagnostic disable: undefined-global

return {
	{
		"coder/claudecode.nvim",
        event = "VeryLazy",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = true,
		cmd = {
			"ClaudeCode",
			"ClaudeCodeFocus",
			"ClaudeCodeAdd",
			"ClaudeCodeSend",
			"ClaudeCodeDiffAccept",
			"ClaudeCodeDiffDeny",
			"ClaudeCodeStatus",
		},
		opts = {
			-- 服务器配置 - 启用IDE连接
			port_range = { min = 10000, max = 65535 },
			auto_start = true, -- 自动启动WebSocket服务器，启用IDE连接
			log_level = "info", -- "trace", "debug", "info", "warn", "error"

			-- 终端配置
			terminal = {
				split_side = "right", -- "left" or "right"
				split_width_percentage = 0.35,
				provider = "auto", -- 自动选择最佳终端提供者
				auto_close = true,
			},

			-- 发送/聚焦行为
			focus_after_send = true, -- 发送后自动聚焦到 Claude 终端
			-- 选择跟踪 - 自动跟踪当前buffer和选中的文本
			track_selection = true,
			visual_demotion_delay_ms = 200,
			-- 工作目录控制 - 使用 Git 仓库根目录
			git_repo_cwd = true,
			-- 差异集成
			diff_opts = {
				auto_close_on_accept = true,
				vertical_split = true,
				open_in_current_tab = true,
				keep_terminal_focus = false,
			},
		},
	},
}
