-- lua/mason.lua
-- Mason 安装和自动安装 LSP
return {
	"mason-org/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
	event = "VeryLazy",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		-- 移除对nvim-lspconfig的依赖，因为在Neovim 0.11中已弃用
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"clangd",
				"html",
				"cssls",
				"ts_ls",
				"emmet_ls",
			},
			automatic_installation = true,
		})
	end,
}
