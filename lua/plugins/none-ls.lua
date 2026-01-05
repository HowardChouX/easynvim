-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "NullLsInfo",
  keys = {
    { "<leader>lf",
      function()
        vim.lsp.buf.format()
      end,
      desc = "格式化代码 (Format Code)",
    },
  },
  config = function()
    -- 适配 neovim 0.11 版本的 mason API
    local mason = require("mason")
    local registry = require("mason-registry")

    mason.setup()

    local function install(name)
      local ok, pkg = pcall(registry.get_package, name)
      if ok and not pkg:is_installed() then
        pkg:install()
      end
    end

    install("stylua")
    install("black")
    install("clang-format")
    install("google-java-format")

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.google_java_format,
      },
    })
  end,
}
