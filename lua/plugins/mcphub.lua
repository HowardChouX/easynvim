-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	"ravitemer/mcphub.nvim",
    enabled = false,
    event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	build = "npm install -g mcp-hub@latest",
	config = function()
		require("mcphub").setup({
			--- `mcp-hub` binary related options-------------------
			config = vim.fn.expand("~/.config/mcphub/servers.json"),
			port = 40001,
			shutdown_delay = 5 * 60 * 1000, -- 5分钟后自动关闭不活动的服务器
			-- 退出 Neovim 时立即关闭所有服务器
			shutdown_on_exit = true,
			use_bundled_binary = true,
			mcp_request_timeout = 60000,
			global_env = {},

			workspace = {
				enabled = true,
				look_for = { ".mcphub/servers.json",},
				reload_on_dir_changed = true,
				port_range = { min = 40000, max = 41000 },
			},

			---Chat-plugin related options-----------------
			-- 🌟 核心优化：智能自动授权 🌟
			auto_approve = function(params)
				-- 1. 总是允许“只读”和“无副作用”的工具
				local safe_tools = {
					-- 基础
					"list_files",
					"search_files",
					"get_current_time",
					-- 联网
					"fetch",
					"read_url",
					"navigate",
					"screenshot",
					"get_content",
					-- 数据库 (读取类)
					"read_query",
					"describe_table",
					"list_tables",
					-- Git (只读)
					"git_log",
					"git_status",
					"git_diff",
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
					-- 如果是当前项目目录下的文件，自动批准
					if path:match("^" .. vim.fn.escape(cwd, "\\.")) then
						return true
					else
						-- 如果不是当前项目目录下的文件，显示弹窗确认（不打印详细内容）
						vim.notify(
							"请求读取项目外文件，需要确认",
							vim.log.levels.WARN,
							{ title = "MCP Hub 权限确认" }
						)
						return false -- 需要手动确认
					end
				end

				-- 3. 如果服务器本身被标记为自动批准（通常不建议全开，保持默认）
				if params.is_auto_approved_in_server then
					return true
				end

				-- 添加neovim服务器中的危险工具
				local dangerous_tools = {
					-- 文件系统操作（来自filesystem服务器）
					"write_file", "write_text_file", -- filesystem服务器的写入工具
					"edit_file", -- filesystem服务器的编辑工具
					"delete_file", "delete_items", -- filesystem服务器的删除工具
					"move_file", "move_item", -- filesystem服务器的移动工具
					"copy_file", -- filesystem服务器的复制工具
					"create_directory", -- filesystem服务器的创建目录工具
					-- 文件系统操作（来自neovim服务器）
					"write_file", -- neovim服务器的写入工具
					"edit_file", -- neovim服务器的编辑工具
					"move_item", -- neovim服务器的移动工具
					"delete_items", -- neovim服务器的删除工具
					-- Git操作
					"git_commit",
					"git_push",
					"git_reset",
					-- 数据库操作
					"sqlite_execute",
					"sqlite_insert",
					"sqlite_update",
					"sqlite_delete",
				}

				for _, tool in ipairs(dangerous_tools) do
					if params.tool_name == tool then
						vim.notify(
							"检测到危险操作，需要确认",
							vim.log.levels.ERROR,
							{ title = "MCP Hub 权限确认" }
						)
						return false -- 需要手动确认
					end
				end

				-- 默认情况下需要确认
				vim.notify("未知操作请求，需要确认", vim.log.levels.INFO, { title = "MCP Hub 权限确认" })
				return false
			end,
			--如果有需要自动启动
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
							accept = "<C-y>",
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
				level = vim.log.levels.WARN,
				to_file = false,
				prefix = "MCPHub",
			},
		})
	end,
}
