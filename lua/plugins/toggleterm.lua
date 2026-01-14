-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-t>]],
      direction = "horizontal", -- 可选: 'vertical' | 'float'
      --direction = "float", -- 可选: 'vertical' | 'float'
      --direction = "vertical", -- 可选: 'vertical' | 'float'
      start_in_insert = true,
      close_on_exit = true,
      shell = vim.o.shell,
    })
  end,
}
