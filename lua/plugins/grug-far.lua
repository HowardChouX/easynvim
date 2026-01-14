-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {
        open_in_place = true -- Open the file in place instead of creating a new buffer
    },
}
