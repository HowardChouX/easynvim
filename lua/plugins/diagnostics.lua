---@diagnostic disable: undefined-global
return {
	"neovim/nvim-lspconfig",
    event = "VeryLazy",
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			update_in_insert = false,
			signs = true,
			underline = true,
			severity_sort = true,
		})
	end,
}
