-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
    "Saghen/blink.cmp",
    enabled = false,
    version = "*",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    event = "VeryLazy",
    opts = {
        completion = {
            documentation = {
                auto_show = true
            }
        },
        keymap = {
            preset = "super-tab",
        },
        sources = {
            default = { "path", "snippets", "buffer", "lsp" },
        },
        cmdline = {
            sources = function()
                local cmd_type = vim.fn.getcmdtype()
                if cmd_type == "/" then
                    return { "buffer" }
                end
                if cmd_type == ":" then
                    return { "cmdline" }
                end
                return {}
            end,

            keymap = {
                preset = "super-tab"
            },
            completion = {
                menu = {
                    auto_show = true
                }
            }
        }
    },
}

