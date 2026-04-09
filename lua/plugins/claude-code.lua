-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global

return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		cmd = {
			"ClaudeCode",
			"ClaudeCodeFocus",
			"ClaudeCodeAdd",
			"ClaudeCodeSend",
			"ClaudeCodeDiffAccept",
			"ClaudeCodeDiffDeny",
			"ClaudeCodeStatus",
		},
		keys = {
			{ "<leader>t", "<cmd>ClaudeCode<cr>", desc = "切换 Claude Code (Toggle)", mode = { "n", "t" } },
			{ "g2", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude Code 接受更改" },
			{ "g3", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude Code 拒绝更改" },
		},
		opts = {
			terminal = {
				provider = "snacks",
				snacks_win_opts = {
					position = "right",
					width = 0.4,
					border = "single",
				},
			},
		},
	},
}
