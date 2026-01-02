return {
  "OXY2DEV/markview.nvim",
  lazy = true,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", lazy = false },
    "nvim-tree/nvim-web-devicons",
    "hrsh7th/nvim-cmp",
  },
  ft = { "markdown" },
  config = function()
    require("markview").setup({
      -- ===== 核心预览设置 =====
      preview = {
        enable = true,
        hybrid_modes = { "n", "i" },
        width = 80,
        position = "right",
        sync_scroll = true,
      },

      -- ===== 渲染增强 =====
      render = {
        code_highlight = { enable = true, theme = "monokai" },
        latex = { enable = true },
        emoji = { enable = true },
        table = { enable = true }, -- 确保表格渲染启用
        toc = {
          enable = true,
          position = "left",
          depth = 4,
        },
        heading_anchors = true,
      },

      -- ===== 键盘映射 =====
      keymaps = {
        toggle = "<leader>md", -- 切换预览面板
      },

      -- ===== 表格渲染增强 =====
      table = {
        enable = true,
        alignment = "center",
        style = "github",
      },
    })

    -- 为 Markdown 文件添加专用快捷键
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "<leader>mp", "<cmd>MarkviewToggle<cr>", { desc = "Toggle Markdown Preview" })
      end,
    })
  end
}
