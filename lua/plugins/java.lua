---@diagnostic disable: undefined-global
return {
	"nvim-java/nvim-java",
	ft = "java",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("java").setup({
			checks = {
				nvim_jdtls_conflict = true,
			},
			jdtls = {
				root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", ".git" },
				jvm_args = {
					"-java.home:/usr/lib/jvm/java-21-openjdk",
				},
			},
			lombok = { enable = false },
			java_test = { enable = true },
			java_debug_adapter = { enable = true },
			spring_boot_tools = { enable = false },
			jdk = {
				auto_install = false,
				version = "21",
			},
			maven = {
				downloadSources = false,
				downloadJavadoc = false,
			},
			log = {
				level = "warn",
			},
		})
		vim.lsp.enable("jdtls")
	end,
}
