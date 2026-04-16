---@diagnostic disable: undefined-global
return {
  "folke/lazydev.nvim",
  ft = "lua", -- 仅在 lua 文件中加载
  opts = {
    library = {
      -- 添加 Neovim 运行时路径
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
