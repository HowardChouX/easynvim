---@diagnostic disable: undefined-global
return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- 调试浮动窗口显示变量
		vim.keymap.set("n", "<leader>dv", function()
			dapui.float_element("scopes", { width = 80, height = 30 })
		end, { desc = "显示变量 (Variables) --DAP" })

		vim.keymap.set("n", "<leader>dw", function()
			dapui.float_element("watch", { width = 80, height = 15 })
		end, { desc = "监视表达式 (Watch) --DAP" })

		vim.keymap.set("n", "<leader>ds", function()
			dapui.float_element("stacks", { width = 80, height = 20 })
		end, { desc = "调用堆栈 (Stacks) --DAP" })
	end,
}
