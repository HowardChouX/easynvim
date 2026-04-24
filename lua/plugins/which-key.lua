---@diagnostic disable: undefined-global
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
		},
		keys = {
			["<leader>"] = "which_key_az",
		},
		preset = "modern",
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
