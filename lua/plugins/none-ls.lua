return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		-- 适配 neovim 0.11 版本的 mason API
		local mason = require("mason")
		local registry = require("mason-registry")

		-- 先确保 mason 已初始化
		mason.setup()

		local function install(name)
			local success, package = pcall(registry.get_package, name)
			if success and not package:is_installed() then
				package:install()
			end
		end
		install("stylua")
		install("black")
		install("clang-format")
		install("google-java-format")

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.google_java_format,
			},
		})
	end,
	-- keys = {
	-- 	{
	-- 		"<leader>lf",
	-- 		function()
	-- 			vim.lsp.buf.format()
	-- 		end,
	-- 		desc = "格式化代码 (Format Code)"
	-- 	},
	-- },
}
