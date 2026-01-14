-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local mason_nvim_dap = require("mason-nvim-dap")

			-- 1. 自动安装 debugpy
			mason_nvim_dap.setup({
				ensure_installed = { "python" }, -- 在 mason-nvim-dap 中，python 对应 debugpy
				automatic_installation = true,
				handlers = {}, -- 可以在这里扩展其他语言的自动配置
			})

			-- 2. 配置 DAP UI
			dapui.setup()

			-- 自动打开/关闭调试界面
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			-- 3. 配置 Python 调试器
			-- 使用 mason 安装的 debugpy-adapter 路径
			local debugpy_adapter_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/debugpy-adapter"
			require("dap-python").setup(debugpy_adapter_path)

			-- 增加适配器响应的超时时间 (解决 "Debug adapter didn't respond" 问题)
			-- 默认是 4000ms (4秒)，对于某些环境可能不够
			local dap_python = require("dap-python")
			dap_python.test_runner = "pytest" -- 默认测试框架

			-- 手动修补 dap 配置以增加超时
			for _, config in pairs(dap.configurations.python or {}) do
				config.justMyCode = false -- 允许调试库代码（可选）
			end

			-- 全局增加所有适配器的超时时间
			dap.defaults.fallback.external_terminal = {
				command = "/usr/bin/x-terminal-emulator",
				args = { "-e" },
			}

			-- 重要：增加初始化超时时间
			local original_run = dap.run
			dap.run = function(config, opts)
				-- 确保配置中有初始化选项
				config = config or {}
				config.initialize_timeout_sec = 20 -- 增加到 20 秒
				original_run(config, opts)
			end


			-- 5. 美化断点图标
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

			-- 6. 创建DAP相关命令
			vim.api.nvim_create_user_command("DAP", function()
				vim.notify("DAP插件已加载，使用快捷键或:DAPStart开始调试")
			end, { desc = "加载并显示DAP插件信息" })

			vim.api.nvim_create_user_command("DAPStart", function()
				if dap.session() then
					dap.continue()
				else
					if vim.bo.filetype == "python" and dap.configurations.python then
						dap.run(dap.configurations.python[1])
					else
						dap.continue()
					end
				end
			end, { desc = "启动或继续调试" })

			vim.api.nvim_create_user_command("DAPToggle", function()
				dapui.toggle()
			end, { desc = "切换调试界面" })

			vim.api.nvim_create_user_command("DAPBreakpoint", function(opts)
				if opts.args and opts.args ~= "" then
					dap.set_breakpoint(opts.args)
				else
					dap.toggle_breakpoint()
				end
			end, { desc = "设置或切换断点", nargs = "?" })

			vim.api.nvim_create_user_command("DAPContinue", function()
				dap.continue()
			end, { desc = "继续调试" })

			vim.api.nvim_create_user_command("DAPStep", function(opts)
				if opts.args == "over" then
					dap.step_over()
				elseif opts.args == "into" then
					dap.step_into()
				elseif opts.args == "out" then
					dap.step_out()
				else
					vim.notify("用法: :DAPStep over|into|out")
				end
			end, { desc = "单步调试 (over|into|out)", nargs = "?" })
		end,
	},
}
