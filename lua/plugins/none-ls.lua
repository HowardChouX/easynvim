-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "NullLsInfo",
	keys = {
		{
			"<leader>f",
			function()
				vim.lsp.buf.format()
			end,
			desc = "格式化代码 (Format Code)",
		},
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format,
			},
		})
	end,
}
