---@diagnostic disable: undefined-global
-- nvim-java: Modern Java development plugin for Neovim
-- https://github.com/nvim-java/nvim-java
return {
  "nvim-java/nvim-java",
  event = "BufEnter *.java",
  dependencies = {
    "nvim-java/lua-async-await",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("java").setup({
      -- 启动检查
      checks = {
        nvim_version = true,          -- 检查 Neovim 版本
        nvim_jdtls_conflict = true,   -- 检查与 nvim-jdtls 的冲突
      },

      -- JDTLS 配置
      jdtls = {
        version = "1.43.0",
      },

      -- 扩展功能
      lombok = {
        enable = true,
        version = "1.18.40",
      },
      java_test = {
        enable = true,
        version = "0.40.1",
      },
      java_debug_adapter = {
        enable = true,
        version = "0.58.2",
      },
      spring_boot_tools = {
        enable = true,
        version = "1.55.1",
      },

      -- JDK 自动安装
      jdk = {
        auto_install = true,
        version = "17",  -- 默认安装 JDK 17，可根据需要修改
      },

      -- 日志配置
      log = {
        use_console = true,
        use_file = true,
        level = "info",
        log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
        max_lines = 1000,
        show_location = false,
      },
    })
  end,
}
