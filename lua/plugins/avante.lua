-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global

return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = vim.fn.has("win32") ~= 0 and "powershell " .. vim.fn.shellescape(
			"-ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		) or "make BUILD_FROM_SOURCE=true",
		version = false,
		-- 关键：显式声明依赖 mcphub.nvim
		dependencies = {
			"ravitemer/mcphub.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = { file_types = { "markdown", "Avante" } },
				ft = { "markdown", "Avante" },
			},
		},
		config = function()
			require("avante_lib").load()
			require("avante").setup({
				-- 添加窗口配置，设置为右侧悬浮
				windows = {
					position = "right",
					floating = true,
					wrap = true, -- 启用文本换行
					width = 32, -- 窗口宽度，可以适当调大一些
					-- 输入框配置
					input = {
						prefix = "> ",
						height = 13, -- 输入框高度
					},
					-- 侧边栏配置
					sidebar = {
						border = "rounded",
						title = " Avante AI Assistant ",
						title_pos = "center", -- 标题位置: "left", "center", "right"
						zindex = 50,
					},
                },
				-- MCP Hub 集成：系统提示词
				system_prompt = function()
					-- 使用 pcall 防止 mcphub 还没加载完导致崩溃
					local status, hub = pcall(require, "mcphub")
					if status then
						local hub_instance = hub.get_hub_instance()
						return hub_instance and hub_instance:get_active_servers_prompt() or ""
					end
					return ""
				end,

				-- MCP Hub 集成：工具
				custom_tools = function()
					local status, mcp_ext = pcall(require, "mcphub.extensions.avante")
					if status then
						return { mcp_ext.mcp_tool() }
					end
					return {}
				end,
				disabled_tools = {
					"list_files",
					"search_files",
					"read_file",
					"create_file",
					"rename_file",
					"delete_file",
					"create_dir",
					"rename_dir",
					"delete_dir",
					"bash",
				},
				behaviour = {
					auto_suggestions = false,
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					show_diff = true,
					confirm_before_apply = true,
					support_paste_from_clipboard = true,
					-- 添加这个选项来优化悬浮窗口体验
					minimize_diff = true,
				},

				provider = "cherryin_openai_qwen3_coder_480b",
				providers = {
					cherrryin_glm4_6 = {
						__inherited_from = "openai",
						endpoint = "https://open.cherryin.ai/v1",
						api_key_name = "OPEN_SOURCE_API_KEY",
						model = "agent/glm-4.6(free)",
					},
					cherryin_deepseek_v3_1_free = {
						__inherited_from = "openai",
						endpoint = "https://open.cherryin.ai/v1",
						api_key_name = "OPEN_SOURCE_API_KEY",
						model = "agent/deepseek-v3.1-terminus(free)",
					},
					cherryin_kimi = {
						__inherited_from = "openai",
						endpoint = "https://open.cherryin.ai/v1",
						api_key_name = "OPEN_SOURCE_API_KEY",
						model = "agent/kimi-k2-0905(free)",
					},
					cherryin_openai_qwen3_coder_480b = {
						__inherited_from = "openai",
						endpoint = "https://open.cherryin.ai/v1",
						api_key_name = "OPEN_SOURCE_API_KEY",
						model = "agent/qwen3-coder-480b-a35b-instruct(free)",
					},
					cherryin_openai_120b = {
						__inherited_from = "openai",
						endpoint = "https://open.cherryin.ai/v1",
						api_key_name = "OPEN_SOURCE_API_KEY",
						model = "openai/gpt-oss-120b",
					},
					ollama = {
						model = "qwen2.5-coder:7b",
						is_env_set = require("avante.providers.ollama").check_endpoint_alive,
					},
				},

				file_selector = {
					provider = "telescope",
					provider_opts = {},
				},

				web_search_engine = {
					provider = "tavily",
					providers = {
						tavily = { api_key_name = "TAVILY_API_KEY" },
					},
				},

				acp_providers = {
					["goose"] = {
						enabled = true,
						command = "goose",
						args = { "acp" },
					},
				},

				rag_service = {
					enabled = false,
					host_mount = os.getenv("HOME"),
					runner = "docker",
					llm = {
						provider = "ollama",
						endpoint = "http://host.docker.internal:11434",
						model = "qwen2.5-coder:7b",
					},
					embed = {
						provider = "ollama",
						endpoint = "http://host.docker.internal:11434",
						model = "nomic-embed-text:latest",
					},
					docker_extra_args = "--network host",
				},
			})

			-- 添加一些有用的快捷键和自动命令来优化悬浮窗口体验
			-- 快速切换 avante 窗口
			vim.keymap.set("n", "<leader>aa", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
			vim.keymap.set("n", "<leader>az", "<cmd>AvanteZenMode<cr>", { desc = "Avante Zen Mode" })

			-- 如果窗口被意外关闭，重新打开
			vim.api.nvim_create_autocmd("WinClosed", {
				callback = function()
					-- 检查是否所有 avante 窗口都被关闭了
					local avante_wins = 0
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.api.nvim_buf_get_option(buf, "filetype")
						if ft == "Avante" or ft == "AvanteInput" then
							avante_wins = avante_wins + 1
						end
					end

					-- 如果没有 avante 窗口了，清理状态
					if avante_wins == 0 then
						vim.g.avante_state = nil
					end
				end,
			})
		end,
	},
}
