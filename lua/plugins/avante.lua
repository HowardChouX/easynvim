--@diagnostic disable: undefined-global

-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell " .. vim.fn.shellescape(
		"-ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	) or "make BUILD_FROM_SOURCE=true",
	cmd = { "Avante", "AvanteChatNew", "AvanteToggle" }, -- 改为手动命令触发
	version = false, -- 永远不要将此值设置为 "*"
	config = function()
		require("avante_lib").load()
		require("avante").setup({
			provider = "cherryin_openai_120b", -- 使用默认的 Goose ACP
			providers = {
				-- 1. Morph (专门用于 Fast Apply)
				morph = {
					__inherited_from = "openai",
					endpoint = "https://api.morphllm.com/v1",
					model = "morph-v3-fast", -- 追求速度选 fast
					api_key_name = "MORPH_API_KEY",
				},
				-- 2. SiliconFlow
				siliconflow = {
					__inherited_from = "openai",
					endpoint = "https://api.siliconflow.cn/v1",
					api_key_name = "SILICONFLOW_API_KEY",
					model = "deepseek-ai/DeepSeek-V3.1-Terminus",
				},
				-- 3. CherryIn - GLM 4.6
				cherrryin_glm4_6 = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/glm-4.6(free)",
				},
				-- 4. CherryIn - DeepSeek V3.1 Free
				cherryin_deepseek_v3_1_free = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/deepseek-v3.1-terminus(free)",
				},
				-- 5. CherryIn - DeepSeek V3.1 (付费/标准版)
				cherryin_deepseek_v3_1 = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/deepseek-v3.1-terminus",
				},
				-- 6. CherryIn - DeepSeek V3.2 Free
				cherryin_deepseek_v3_2 = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "agent/deepseek-v3.2(free)",
				},
				-- 7. OpenAI (CherryIn 代理)
				cherryin_openai_20b = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "openai/gpt-oss-20b",
				},
				cherryin_openai_120b = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "OPEN_SOURCE_API_KEY",
					model = "openai/gpt-oss-120b",
				},

				-- 8. CherryIn - Claude 3.7 Sonnet
				cherryin_claude = {
					__inherited_from = "openai",
					endpoint = "https://open.cherryin.ai/v1",
					api_key_name = "CLAUDE_API_KEY",
					model = "anthropic/claude-3.7-sonnet",
				},
			},

			--- UI 布局优化 ---
			ui = {
				window = {
					width = 0.8,
					height = 0.7,
					border = "rounded",
				},
				chat = {
					max_height = 50,
					min_height = 30,
					border = "single",
				},
				qa = {
					max_width = 100,
					border = "none",
				},
			},

			-- 文件选择器 (适配最新版键名)
			file_selector = {
				provider = "telescope",
				provider_opts = {},
			},

			-- 搜索引擎
			web_search_engine = {
				provider = "tavily",
				providers = {
					tavily = {
						api_key_name = "TAVILY_API_KEY",
					},
				},
			},

			-- ACP 通信
			acp_providers = {
				["goose"] = {
					enabled = true,
					command = "goose",
					args = { "acp" },
				},
			},

			-- RAG 服务配置
			rag_service = {
				enabled = false,
				auto_start = false,
				runner = "docker",
				host_mount = os.getenv("HOME"),
				docker_extra_args = "--network host",
				llm = {
					provider = "ollama",
					endpoint = "http://localhost:11434",
					model = "llama2:7b",
				},
				embed = {
					provider = "ollama",
					endpoint = "http://localhost:11434",
					model = "qwen3-embedding:8b",
				},
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			enabled = true,
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
