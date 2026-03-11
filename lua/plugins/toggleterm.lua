-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = { { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "切换终端 (Toggle Terminal)" } },
	opts = {
		size = 15,
		open_mapping = [[<C-t>]],
		direction = "float",
		start_in_insert = true,
		close_on_exit = true,
		shell = vim.o.shell,
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		persist_size = true,
		persist_mode = true,
		auto_scroll = true,
		float_opts = {
			border = "double",
			winblend = 0,
		},
	},
}
