return {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter", -- 界面渲染完成后触发
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function()
        -- 自定义 LSP 状态组件
        local function lsp_status()
            -- 获取当前缓冲区的 LSP 客户端
            local clients = vim.lsp.get_clients({ bufnr = 0 })

            if #clients == 0 then
                return " LSP: 无"
            end

            -- 收集客户端名称
            local client_names = {}
            for _, client in ipairs(clients) do
                table.insert(client_names, client.name)
            end

            -- 限制显示长度，避免状态栏过长
            local status = table.concat(client_names, ", ")
            if #status > 25 then
                status = string.sub(status, 1, 22) .. "..."
            end

            return " LSP: " .. status
        end

        -- 自定义 LSP 状态组件（简洁版）
        local function lsp_status_short()
            local clients = vim.lsp.get_clients({ bufnr = 0 })

            if #clients == 0 then
                return ""
            end

            -- 只显示图标和数量
            return " " .. #clients
        end

        -- 自定义 LSP 状态组件（带错误/警告指示）
        local function lsp_diagnostics()
            if not vim.diagnostic then
                return ""
            end

            local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

            local result = ""
            if errors > 0 then
                result = result .. " " .. errors
            end
            if warnings > 0 then
                if #result > 0 then
                    result = result .. " "
                end
                result = result .. " " .. warnings
            end

            return result
        end

        return {
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = { "Avante", "AvanteInput", "AvanteSelectedFiles", "DressingSelect" },
                    winbar = { "Avante", "AvanteInput", "AvanteSelectedFiles", "DressingSelect" },
                },
            },
            extensions = { "nvim-tree" },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                -- 添加 LSP 状态到 x 区域
                lualine_x = {
                    lsp_status_short, -- 简洁版 LSP 状态
                    lsp_diagnostics,  -- 诊断信息
                    "filesize",
                    "encoding",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
            -- 可选：为 inactive 状态栏也配置 LSP 显示
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { lsp_status_short, "location" },
                lualine_y = {},
                lualine_z = {}
            },
        }
    end,
    config = function(_, opts)
        require("lualine").setup(opts)

        -- 可选：添加 LSP 状态变化时的自动刷新
        vim.api.nvim_create_augroup("LualineLSP", { clear = true })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = "LualineLSP",
            callback = function()
                -- 延迟刷新，确保 LSP 完全附加
                vim.defer_fn(function()
                    require("lualine").refresh()
                end, 100)
            end,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = "LualineLSP",
            callback = function()
                require("lualine").refresh()
            end,
        })

        -- 诊断信息变化时也刷新
        vim.api.nvim_create_autocmd("DiagnosticChanged", {
            group = "LualineLSP",
            callback = function()
                require("lualine").refresh()
            end,
        })
    end,
}
