return {
	"yetone/avante.nvim",
	-- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
	-- ⚠️ 一定要加上这一行配置！！！！！
	-- 如果您想从源代码构建，请确保 cargo 已安装并且设置 BUILD_FROM_SOURCE=true
	-- ⚠️ 一定要加上这一行配置！！！！！
	build = vim.fn.has("win32") ~= 0 and "powershell " .. vim.fn.shellescape(
		"-ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	) or "make BUILD_FROM_SOURCE=true",
	event = "VeryLazy",
	version = false, -- 永远不要将此值设置为 "*"！永远不要！
	---@module 'avante'
	---@type avante.Config
	config = function()
		require("avante_lib").load()
		require("avante").setup({
			-- UI 布局优化
			ui = {
				-- 优化窗口大小和位置
				window = {
					width = 0.8, -- 窗口宽度为屏幕的80%
					height = 0.7, -- 窗口高度为屏幕的70%
					border = "rounded", -- 圆角边框
				},
				-- 聊天界面优化
				chat = {
					max_height = 30, -- 聊天区域最大高度
					min_height = 10, -- 聊天区域最小高度
					border = "single", -- 简洁边框
				},
				-- 问答界面优化
				qa = {
					max_width = 100, -- 问答区域最大宽度
					border = "none", -- 无边框，更简洁
				},
			},
			-- 在此处添加任何选项
			-- 例如
			provider = "cherryin_deepseek_v3_1",
			providers = {
				siliconflow = {
					__inherited_from = "openai",
					endpoint = "https://api.siliconflow.cn/",
					api_key_name = "SILICONFLOW_API_KEY",
					model = "deepseek-ai/DeepSeek-V3.1-Terminus",
				},
				cherrryin_glm4_6 = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/glm-4.6(free)",
				},
				cherryin_deepseek_v3_1 = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/deepseek-v3.1-terminus(free)",
				},
				cherryin_deepseek_v3_2 = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/deepseek-v3.2(free)",
				},
				cherryin_claude = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "CLAUDE_API_KEY",
					model = "anthropic/claude-3.7-sonnet",
				},
			},
			-- 使用已配置好的 Telescope 作为文件选择器
			file_picker = {
				command = "Telescope find_files",
			},
			web_search_engine = {
				provider = "tavily", -- 设置默认的 Web 搜索引擎提供商为 Tavily
				providers = {
					tavily = {
						api_key_name = "TAVILY_API_KEY", -- Tavily API 密钥的环境变量名
					},
				},
			},
			-- RAG 服务配置 - 启用内置 RAG 服务
			rag_service = {
				enabled = true, -- 启用内置 RAG 服务
				auto_start = true, -- 启用自动启动
				runner = "docker", -- Docker 运行器
				host_mount = os.getenv("HOME"), -- 使用用户主目录作为挂载点
				docker_extra_args = "--network host", -- 使用主机网络模式
				-- LLM配置

				llm = {
					provider = "ollama",
					endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
					api_key = "",
					model = "llama2:7b", -- 使用可用的模型
					extra = {
						embed_batch_size = 10,
					}, -- LLM 的额外配置选项
				},
				embed = { -- Configuration for the Embedding Model used by the RAG service
					provider = "ollama", -- The Embedding provider ("ollama")
					endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
					api_key = "", -- Ollama typically does not require an API key
					model = "nomic-embed-text:v1.5", -- The Embedding model name (e.g., "nomic-embed-text")
					extra = { -- Extra configuration options for the Embedding model (optional)
						embed_batch_size = 10,
					},
				},
			},
		})

		-- Remove custom RAG service loading - now handled by Avante built-in RAG service
		-- Note: Avante will automatically start/manage RAG service when rag_service.enabled = true
	end,

	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- 以下依赖项是可选的，
		--"echasnovski/mini.pick", -- 用于文件选择器提供者 mini.pick
		"nvim-telescope/telescope.nvim", -- 用于文件选择器提供者 telescope
		--"ibhagwan/fzf-lua", -- 用于文件选择器提供者 fzf
		"nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- 用于 providers='copilot'
		{
			-- 支持图像粘贴
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- 推荐设置
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- Windows 用户必需
					use_absolute_path = true,
				},
			},
		},
		{
			-- 如果您有 lazy=true，请确保正确设置
			"MeanderingProgrammer/render-markdown.nvim",
			enabled = true, -- 禁用 render-markdown.nvim，使用 markview.nvim 替代
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
