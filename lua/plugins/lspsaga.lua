return {
    "https://github.com/nvimdev/lspsaga.nvim",
    version = "*",
    cmd = "Lspsaga",
    opts = {
        finder = {
            keys = {
                toggle_or_open = "<CR>",
            },
        },
    },
    -- keys = {
    --     { "<F2>", ":Lspsaga rename<CR>", desc = "全局重命名变量 (Rename)" },
    --     { "<leader>lc", ":Lspsaga code_action<CR>", desc = "代码修复 (Code Action)" },
    --     { "<leader>ld", ":Lspsaga definition<CR>", desc = "跳转到定义 (Peek Definition)" },
    --     { "<leader>lh", ":Lspsaga hover_doc<CR>", desc = "查看文档说明 (Hover Doc)" },
    --     { "<leader>lR", ":Lspsaga finder<CR>", desc = "查找引用和定义 (LSP Finder)" },
    --     { "<leader>n", ":Lspsaga diagnostic_jump_next<CR>", desc = "跳转到下一个诊断 (Next Diagnostic)" },
    --     { "<leader>p", ":Lspsaga diagnostic_jump_prev<CR>", desc = "跳转到上一个诊断 (Prev Diagnostic)" },
    -- }
}
