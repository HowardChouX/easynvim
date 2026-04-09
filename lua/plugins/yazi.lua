-- plugins/yazi.lua
---@diagnostic disable: undefined-global
return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	-- 禁用 netrw
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,

	opts = {
		open_for_directories = true,
		open_multiple_tabs = false,
		change_neovim_cwd_on_close = false,
		floating_window_scaling_factor = 0.9,
		yazi_floating_window_winblend = 0,
		yazi_floating_window_border = "rounded",
		yazi_floating_window_zindex = nil,
		log_level = vim.log.levels.OFF,

		-- 默认打开文件方式
		open_file_function = function(chosen_file, config, state)
			vim.cmd("edit " .. chosen_file)
		end,

		highlight_groups = {
			hovered_buffer = nil,
			hovered_buffer_in_same_directory = nil,
		},

		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			replace_in_directory = "<c-g>",
			cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "<c-\\>",
			open_and_pick_window = "<c-o>",
		},

		clipboard_register = "*",
		highlight_hovered_buffers_in_same_directory = true,

		integrations = {
			bufdelete_implementation = "bundled-snacks",
			picker_add_copy_relative_path_action = nil,
		},

		future_features = {
			use_cwd_file = true,
			new_shell_escaping = true,
		},
	},
}
