-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global
return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "hrsh7th/nvim-cmp",
  },
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      -- ===== 核心设置 =====
      enabled = true,
      render_modes = { "n", "c", "t" },
      debounce = 100,
      file_types = { "markdown" },
      max_file_size = 10.0,

      -- ===== 标题渲染 =====
      heading = {
        enabled = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        position = "overlay",
        width = "full",
        border = false,
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },

      -- ===== 代码块渲染 =====
      code = {
        enabled = true,
        language = true,
        language_icon = true,
        language_name = true,
        language_info = true,
        width = "full",
        border = "hide",
        inline = true,
        style = "full",
      },

      -- ===== 表格渲染增强 =====
      pipe_table = {
        enabled = true,
        cell = "padded",
        padding = 1,
        border_enabled = true,
        style = "full",
        -- GitHub风格的表格边框
        border = {
          "┌", "┬", "┐",
          "├", "┼", "┤",
          "└", "┴", "┘",
          "│", "─",
        },
      },

      -- ===== 列表和复选框 =====
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },

      checkbox = {
        enabled = true,
        unchecked = {
          icon = "󰄱 ",
        },
        checked = {
          icon = "󰱒 ",
        },
      },

      -- ===== 引用和标注 =====
      quote = {
        enabled = true,
        icon = "▋",
      },

      callout = {
        -- GitHub风格的标注
        note      = { raw = "[!NOTE]",      rendered = "󰋽 Note",      highlight = "RenderMarkdownInfo",    category = "github" },
        tip       = { raw = "[!TIP]",       rendered = "󰌶 Tip",       highlight = "RenderMarkdownSuccess", category = "github" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint",    category = "github" },
        warning   = { raw = "[!WARNING]",   rendered = "󰀪 Warning",   highlight = "RenderMarkdownWarn",    category = "github" },
        caution   = { raw = "[!CAUTION]",   rendered = "󰳦 Caution",   highlight = "RenderMarkdownError",   category = "github" },
      },

      -- ===== 链接渲染 =====
      link = {
        enabled = true,
        hyperlink = "󰌹 ",
      },

      -- ===== LaTeX 支持 =====
      latex = {
        enabled = true,
        converter = { "utftex", "latex2text" },
        position = "center",
      },

      -- ===== 完成建议 =====
      completions = {
        lsp = { enabled = true },
      },

      -- ===== 窗口选项 =====
      win_options = {
        conceallevel = {
          default = vim.o.conceallevel,
          rendered = 3,
        },
        concealcursor = {
          default = vim.o.concealcursor,
          rendered = "",
        },
      },
    })

    -- 为 Markdown 文件添加专用快捷键
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- 切换渲染模式
        vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdownToggle<cr>", { desc = "Toggle Markdown Rendering" })
        -- 预览渲染效果
        vim.keymap.set("n", "<leader>mv", "<cmd>RenderMarkdownPreview<cr>", { desc = "Preview Markdown" })
      end,
    })
  end
}

