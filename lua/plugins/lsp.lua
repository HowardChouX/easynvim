---@diagnostic disable: undefined-global
return {
	"echasnovski/mini.nvim",
    event = "BufReadPre",
	version = false,
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- 尝试加载 cmp_nvim_lsp，如果存在则使用
		local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			capabilities = cmp_lsp.default_capabilities(capabilities)
		else
			-- 可选：开发时提示
			vim.notify("cmp_nvim_lsp not found. Install it via lazy.nvim for better completion.", vim.log.levels.WARN)
		end
		-- 通用 on_attach 回调
		local on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
		local servers = {
			lua_ls = {
				cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/lua-language-server") },
			},
			pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "basic",
						},
					},
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--background-index", -- 后台建立索引
					"--clang-tidy", -- 开启 clang-tidy
					"--header-insertion=iwyu", -- 自动导入头文件
					"--completion-style=detailed", -- 详细补全信息
					"--function-arg-placeholders", -- 补全函数时填充参数占位符
					"--fallback-style=llvm",
					"-j=4", -- 并行处理
					"--pch-storage=memory", -- 内存缓存 PCH，提升速度
				},
			},
			racket = {
				cmd = { "racket", "-l", "racket-langserver" },
				filetypes = { "racket", "scheme" },
				settings = {
					racket = {
						-- Enable additional completion triggers
						completion = {
							enabled = true,
						},
					},
				},
				-- Force completion to work even with minimal triggers
				capabilities = {
					textDocument = {
						completion = {
							completionItem = {
								snippetSupport = true,
								resolveSupport = {
									properties = { "documentation", "detail", "additionalTextEdits" },
								},
							},
						},
					},
				},
			},
		}

		-- 为Neovim 0.11创建简化的LSP配置
		_G.my_lsp_config = {
			capabilities = capabilities,
			on_attach = on_attach,
			servers = servers,
		}

		-- 美化通知的函数
		local function notify_success(message)
			vim.notify("✅ " .. message, vim.log.levels.INFO, {
				title = "LSP 状态",
				icon = "",
			})
		end

		local function notify_warning(message)
			vim.notify("⚠️ " .. message, vim.log.levels.WARN, {
				title = "LSP 警告",
				icon = "",
			})
		end

		local function notify_error(message)
			vim.notify("❌ " .. message, vim.log.levels.ERROR, {
				title = "LSP 错误",
				icon = "",
			})
		end

		local function notify_info(message)
			vim.notify("ℹ️ " .. message, vim.log.levels.INFO, {
				title = "LSP 信息",
				icon = "",
			})
		end

		-- 修正版函数：启动LSP服务器并显示美化状态通知
		function _G.start_lsp_server(filetype)
			-- 映射文件类型到服务器名称
			local filetype_to_server = {
				lua = "lua_ls",
				python = "pyright",
				c = "clangd",
				cpp = "clangd",
				racket = "racket",
				scheme = "racket",
			}

			-- 检查是否配置了对应的服务器
			local server_name = filetype_to_server[filetype]
			if not server_name then
				notify_info(string.format("文件类型 '%s' 未配置LSP服务器", filetype))
				return
			end

			if not _G.my_lsp_config.servers[server_name] then
				notify_warning(string.format("LSP服务器 '%s' 未在配置中定义", server_name))
				return
			end

			local config = _G.my_lsp_config.servers[server_name]

			local client_config = {
				name = server_name,
				cmd = config.cmd,
				filetypes = config.filetypes or { filetype },
				root_dir = vim.fn.getcwd(),
				capabilities = _G.my_lsp_config.capabilities,
				on_attach = _G.my_lsp_config.on_attach,
				settings = config.settings or {},
			}

			local ok, client_id = pcall(function()
				return vim.lsp.start(client_config)
			end)

			if ok and client_id then
				notify_success(string.format("%s 服务器启动成功", server_name))
			else
				local error_msg = client_id or "未知错误"

				-- 提供更具体的错误建议
				local suggestion = ""
				if
					string.find(error_msg:lower(), "cmd", 1, true)
					or string.find(error_msg:lower(), "spawn", 1, true)
					or string.find(error_msg:lower(), "executable", 1, true)
				then
					suggestion = "\n💡 请确保已安装对应的LSP服务器并在PATH中可用"
				elseif string.find(error_msg:lower(), "timeout", 1, true) then
					suggestion = "\n💡 启动超时，请检查网络连接或服务器配置"
				end

				notify_error(string.format("%s 服务器启动失败\n%s%s", server_name, error_msg, suggestion))
			end
		end

		-- 为常见文件类型创建自动命令
		local filetypes = {
			"lua",
			"python",
			"cpp",
			"c",
			"racket",
			"scheme",
		}

		for _, ft in ipairs(filetypes) do
			vim.api.nvim_create_autocmd("FileType", {
				pattern = ft,
				callback = function(args)
					-- 使用vim.schedule确保通知在合适的时机显示
					vim.schedule(function()
						-- 检查缓冲区是否仍然有效
						if not vim.api.nvim_buf_is_valid(args.buf) then
							return
						end

						local buf_ft = vim.bo[args.buf].filetype
						if buf_ft == ft then
							notify_info(string.format("检测到 %s 文件，正在配置LSP...", ft))
							_G.start_lsp_server(ft)
						end
					end)
				end,
			})
		end
	end,
}
