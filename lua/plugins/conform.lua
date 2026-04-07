---@diagnostic disable: undefined-global
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			sql = { "sqlfluff" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
