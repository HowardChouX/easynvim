return {
	"marcinjahn/gemini-cli.nvim",
	cmd = "Gemini",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		auto_reload = true,
		config = {
			os = {
				editPreset = "nvim-remote",
			},
			gui = {
				nerdFontsVersion = "3",
			},
		},
		win = {
			wo = {
				winbar = "GeminiCLI",
			},
			style = "gemini_cli",
			position = "right",
			size = "40%",
		},
	},
	config = true,
	init = function()
		-- It's recommended to set autoread for auto_reload to work correctly.
		vim.o.autoread = true
		vim.api.nvim_create_autocmd("VimLeavePre", {
			pattern = "*",
			callback = function()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == "gemini_cli" then
						vim.cmd("Gemini toggle")
						return
					end
				end
			end,
		})
	end,
}
