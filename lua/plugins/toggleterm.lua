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
      direction = "horizontal", -- 默认水平分割
      start_in_insert = true,
      close_on_exit = true,
      shell = vim.o.shell,
      -- 基础配置
      hide_numbers = false, -- 隐藏终端编号
      shade_terminals = true,
      shading_factor = 2, -- 终端背景变暗程度
      persist_size = true,
      persist_mode = true,
      auto_scroll = true, -- 自动滚动到底部
    })
  end,
}
