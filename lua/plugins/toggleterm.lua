return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-t>]],
      direction = "horizontal", -- 可选: 'vertical' | 'float'
      start_in_insert = true,
      close_on_exit = true,
      shell = vim.o.shell,
    })

    -- jj：只退出 terminal 模式
    -- 已移动到 core/keymap.lua
    -- vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "退出终端插入模式 (Exit Term Insert)" })

    -- Esc：退出 terminal 模式并关闭 buffer
    -- vim.keymap.set("t", "<Esc>", function()
    --   -- 先退出 terminal 模式
    --   vim.api.nvim_feedkeys(
    --     vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
    --     "n",
    --     false
    --   )
    --   -- 稍作延迟后关闭终端 buffer
    --   vim.defer_fn(function()
    --     if vim.bo.buftype == "terminal" then
    --       vim.cmd("bd!")
    --     end
    --   end, 20)
    -- end, { noremap = true, silent = true, desc = "关闭终端 (Close Terminal)" })
  end,
}
