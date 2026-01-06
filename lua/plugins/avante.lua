-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global

return {
    -- 定义 Avante
    {
        "yetone/avante.nvim",
        build = vim.fn.has("win32") ~= 0 and "powershell " .. vim.fn.shellescape(
            "-ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        ) or "make BUILD_FROM_SOURCE=true",
        version = false,
        -- 按需加载：当按下任何 Avante 快捷键时加载插件
        keys = {
            {
                "ja",
                function()
                    require("avante.api").ask()
                end,
                desc = "显示侧边栏",
            },
            { "jn", "<cmd>AvanteChatNew<CR>", desc = "创建新聊天" },
            {
                "jr",
                function()
                    require("avante.api").refresh()
                end,
                desc = "刷新侧边栏",
            },
            {
                "jf",
                function()
                    require("avante.api").focus()
                end,
                desc = "切换侧边栏焦点",
            },
            {
                "jc",
                function()
                    require("avante.api").select_model()
                end,
                desc = "选择模型",
            },
            { "je", "<cmd>AvanteEdit<CR>", desc = "编辑选定的块" },
            { "jt", "<cmd>AvanteToggle<CR>", desc = "切换 Avante 侧边栏" },
            {
                "jz",
                function()
                    require("avante.api").zen_mode()
                end,
                desc = "进入 Avante Zen 模式",
            },
            { "js", "<cmd>AvanteStop<CR>", desc = "停止 Avante" },
        },
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

                -- MCP Hub 集成：工具（这是 Avante 新版推荐的集成方式）
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
                    auto_set_keymaps = false,
                    auto_apply_diff_after_generation = true,
                    support_paste_from_clipboard = true,
                },

                ui = {
                    window = {
                        width = 0.9,
                        height = 0.9,
                        align = "center",
                        relative = "editor",
                        border = "rounded",
                    },

                    -- 下面是官方推荐的 input 配置
                    input = {
                        position = "bottom",
                        border = "rounded",

                        -- Initial height (lines)
                        height = 8,

                        -- Allow growing when user types more text
                        auto_resize = true,

                        -- Boundaries
                        min_height = 6,
                        max_height = 15,

                        prompt = "Ask > ",
                    },
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
                    cherryin_deepseek_v3_2 = {
                        __inherited_from = "openai",
                        endpoint = "https://open.cherryin.ai/v1",
                        api_key_name = "OPEN_SOURCE_API_KEY",
                        model = "agent/deepseek-v3.2(free)",
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
        end,
    },
}
