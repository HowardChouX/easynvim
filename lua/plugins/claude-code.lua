-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global

return {
	{
		"coder/claudecode.nvim",
		enabled = true,
        event = "VeryLazy",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("claudecode").setup({
				-- 服务器配置
				port_range = { min = 10000, max = 65535 },
				auto_start = true,
				log_level = "info", -- "trace", "debug", "info", "warn", "error"

				-- 终端配置
				terminal = {
					split_side = "right", -- "left" or "right"
					split_width_percentage = 0.35,
					provider = "snacks", -- 使用 snacks.nvim 提供更好的终端支持
					auto_close = true,
					snacks_win_opts = {
						-- 浮动窗口配置（可选）
						position = "float",
						width = 0.9,
						height = 0.9,
						border = "rounded",
						title = " Claude Code ",
						title_pos = "center",
					},
				},

				-- 发送/聚焦行为
				focus_after_send = true, -- 发送后自动聚焦到 Claude 终端

				-- 选择跟踪
				track_selection = true,
				visual_demotion_delay_ms = 50,

				-- 工作目录控制 - 使用 Git 仓库根目录
				git_repo_cwd = true,

				-- 差异集成
				diff_opts = {
					auto_close_on_accept = true,
					vertical_split = true,
					open_in_current_tab = true,
					keep_terminal_focus = false,
				},
			})
			end,
			cmd = {
				"ClaudeCode",
				"ClaudeCodeFocus",
				"ClaudeCode --resume",
				"ClaudeCode --continue",
				"ClaudeCodeSelectModel",
				"ClaudeCodeAdd",
				"ClaudeCodeSend",
				"ClaudeCodeTreeAdd",
				"ClaudeCodeDiffAccept",
				"ClaudeCodeDiffDeny",
				"ClaudeCodeStatus",
			},
		keys = {
		},
	},
}

