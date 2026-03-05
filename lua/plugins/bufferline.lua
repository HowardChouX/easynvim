-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        options = {
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                -- 简化诊断显示，只显示图标不显示数量（因为 lualine 已显示详细信息）
                local indicator = " "
                for level, number in pairs(diagnostics_dict) do
                    if number > 0 then
                        local symbol
                        if level == "error" then
                            symbol = ""
                        elseif level == "warning" then
                            symbol = ""
                        else
                            symbol = ""
                        end
                        indicator = indicator .. symbol
                    end
                end
                return indicator == " " and "" or indicator
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true,
                },
            },
        }
    },

}
