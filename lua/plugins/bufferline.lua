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
                local indicator = " "
                for level, number in pairs(diagnostics_dict) do
                    local symbol
                    if level == "error" then
                        symbol = " "
                    elseif level == "warning" then
                        symbol = " "
                    else
                        symbol = " "
                    end
                    indicator = indicator .. number .. symbol
                end
                return indicator
            end,
            offsets = {}
        }
    },

    -- keys = {
    --     { "<leader>bh", ":BufferLineCyclePrev<CR>",   silent = true, desc = "切换上一个标签 (Prev Buffer)" },
    --     { "<leader>bl", ":BufferLineCycleNext<CR>",   silent = true, desc = "切换下一个标签 (Next Buffer)" },
    --     { "<leader>bp", ":BufferLinePickClose<CR>",   silent = true, desc = "选择关闭标签 (Pick Close)" },
    --     { "<leader>bc", ":BufferLineCloseOthers<CR>", silent = true, desc = "关闭其他标签 (Close Others)" },
    --     { "<leader>bd", ":bdelete<CR>",               silent = true, desc = "删除当前缓冲区 (Delete Buffer)" },
    -- },
}
