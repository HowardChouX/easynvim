-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	opts = {
		auto_install = true, -- 自动安装 ensure_installed 中的解析器
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"toml",
			"python",
			"cpp", -- C++
			"c", -- C
			"json",
			"yaml",
			"bash",
			"markdown",
			"markdown_inline",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"regex",
			"go",
			"java",
			"rust",
			"query",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
	},
}
