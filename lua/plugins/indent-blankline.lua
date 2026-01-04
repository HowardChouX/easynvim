-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
    "lukas-reineke/indent-blankline.nvim",
    event = 'VeryLazy',
    main = "ibl",
    opts = {},
}

