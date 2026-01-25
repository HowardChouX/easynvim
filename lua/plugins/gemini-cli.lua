return {
	"marcinjahn/gemini-cli.nvim",
	cmd = "Gemini",
	keys = {
		{ "<leader>ga", "<cmd>Gemini<cr>", desc = "Launch Gemini" },
	},
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		-- The command to execute Gemini CLI.
		-- Assumes `gemini` is in your PATH.
		gemini_cmd = "gemini",

		-- Command line arguments to pass to gemini-cli.
		-- For example, you can add model or other parameters here.
		args = {},

		-- Automatically reload buffers changed by Gemini CLI.
		-- Requires `vim.o.autoread = true`.
		auto_reload = true,

		-- Configuration for the command picker.
		-- The default preset is "vscode".
		picker_cfg = {
			preset = "vscode",
		},

		-- Other options for snacks.nvim terminal.
		config = {
			os = {
				-- Use nvim-remote to open files from the terminal.
				editPreset = "nvim-remote",
			},
			gui = {
				-- Set this to "3" if you use Nerd Fonts v3.
				nerdFontsVersion = "3",
			},
		},

		-- Window configuration for the Gemini CLI terminal.
		win = {
			wo = {
				-- Show a title in the window bar.
				winbar = "GeminiCLI",
			},
			-- Style of the window.
			style = "gemini_cli",
			-- Position of the window. Can be "right", "left", "top", "bottom".
			position = "right",
			-- Size of the window.
			size = "40%",
		},
	},
	config = true,
	init = function()
		-- It's recommended to set autoread for auto_reload to work correctly.
		vim.o.autoread = true
	end,
}
