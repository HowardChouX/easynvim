-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global

return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- 优化 1: 改为局部安装，避免污染系统全局 npm，也不需要 sudo 权限
    build = "bundled_build.lua", -- 这里必须指向插件自带的构建脚本 :Lazy build mcphub.nvim
	config = function()
		require("mcphub").setup({
			--- `mcp-hub` binary related options-------------------
			config = vim.fn.expand("~/.config/mcphub/servers.json"),
			port = 40001,
			shutdown_delay = 5 * 60 * 1000,
			-- 优化 2: 使用插件目录下安装的 binary，配合上面的 build = "npm install"
			use_bundled_binary = true, 
			mcp_request_timeout = 60000,
			
            -- 环境变量：如果有需要全局注入的 Key 可以放这里，但你已经在 servers.json 里配好了
			global_env = {}, 

			workspace = {
				enabled = true,
				look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
				reload_on_dir_changed = true,
				port_range = { min = 40000, max = 41000 },
			},

			---Chat-plugin related options-----------------
			-- 🌟 核心优化：智能自动授权 🌟
			auto_approve = function(params)
				-- 1. 总是允许“只读”和“无副作用”的工具
				local safe_tools = {
					-- 基础
					"list_files", "search_files", "get_current_time",
					-- 联网
					"fetch", "read_url", "navigate", "screenshot", "get_content",
					-- 数据库 (读取类)
					"read_query", "describe_table", "list_tables",
                    -- Git (只读)
                    "git_log", "git_status", "git_diff"
				}

				for _, tool in ipairs(safe_tools) do
					if params.tool_name == tool then
						return true
					end
				end

				-- 2. 文件读取：只允许读取当前项目目录下的文件
				if params.tool_name == "read_file" then
					local path = params.arguments.path or ""
					-- 获取当前工作目录
					local cwd = vim.fn.getcwd()
					-- 简单的路径检查，确保读取的是 cwd 下的文件
					if path:match("^" .. vim.pattern.escape(cwd)) then
						return true
					end
				end

				-- 3. 如果服务器本身被标记为自动批准（通常不建议全开，保持默认）
				if params.is_auto_approved_in_server then
					return true
				end

				-- 其他所有操作（如 write_file, git_commit, sqlite_execute）都需要你手动确认
				return false
			end,

			auto_toggle_mcp_servers = true,
			
			extensions = {
				avante = {
					make_slash_commands = true, -- 允许在 Avante 输入框用 /fetch 等命令
				},
			},

			--- Plugin specific options-------------------
			native_servers = {},
			builtin_tools = {
				edit_file = {
					parser = {
						track_issues = true,
						extract_inline_content = true,
					},
					locator = {
						fuzzy_threshold = 0.8,
						enable_fuzzy_matching = true,
					},
					ui = {
						go_to_origin_on_complete = true,
						keybindings = {
							accept = "<C-y>", -- 建议改为更通用的快捷键，防止冲突
							reject = "<C-n>",
							next = "n",
							prev = "p",
							accept_all = "ga",
							reject_all = "gr",
						},
					},
				},
			},
			ui = {
				window = {
					width = 0.8,
					height = 0.8,
					align = "center",
					relative = "editor",
					zindex = 50,
					border = "rounded",
				},
				wo = {
					winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
				},
			},
			log = {
				level = vim.log.levels.WARN, -- 保持 WARN，减少噪音
				to_file = false,
				prefix = "MCPHub",
			},
		})
	end,
}

