return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- 可选命令触发
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    },
    -- keys = {
    --     { "<leader>u", ":NvimTreeToggle<CR>", desc = "切换文件树 (Toggle File Tree)" },
    -- },
}
