---@diagnostic disable: undefined-global
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    -- 优先使用treesitter，回退到LSP
    backends = { "treesitter", "lsp", "markdown" },

    -- 窗口布局设置
    layout = {
      default_direction = "prefer_left",
      placement = "window",
      min_width = 10,
      max_width = { 40, 0.2 },
      win_opts = {
        winhl = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
      resize_to_content = true,
      preserve_equality = false,
    },

    attach_mode = "window",
    close_automatic_events = { "unsupported" },

    -- 简化的快捷键映射
    keymaps = {
      ["<CR>"] = "actions.jump",
      ["j"] = "actions.next",
      ["k"] = "actions.prev",
      ["q"] = "actions.close",
    },

    lazy_load = true,
    disable_max_lines = 10000,
    disable_max_size = 2000000, -- 2MB

    filter_kind = {
      "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct"
    },

    highlight_mode = "split_width",
    highlight_closest = true,
    highlight_on_hover = false,
    highlight_on_jump = 300,
    autojump = false,

    nerd_font = "auto",
    icons = {
      ["Collapsed"] = "",
      ["Expanded"] = "",
      Array = "󰅪",
      Boolean = "",
      Class = "󰠱",
      Constant = "󰏿",
      Constructor = "",
      Enum = "󰕘",
      Function = "󰊕",
      Interface = "󰜰",
      Method = "󰊕",
      Module = "󰆧",
      Struct = "󰙅",
      Variable = "󰆧",
    },

    ignore = {
      unlisted_buffers = false,
      diff_windows = true,
      filetypes = {},
      buftypes = "special",
      wintypes = "special",
    },

    manage_folds = false,
    link_folds_to_tree = false,
    link_tree_to_folds = true,
    open_automatic = false,
    post_jump_cmd = "normal! zz",
    close_on_select = false,
    update_events = { "TextChanged", "InsertLeave" },
    show_guides = true,
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },
  },

  config = function(_, opts)
    require("aerial").setup(opts)

    -- 设置简单的快捷键
    vim.keymap.set("n", "<leader>q", "<cmd>AerialToggle!<CR>", {
      desc = "打开/关闭大纲 (Toggle Outline) --插件(Aerial)",
    })
  end,
}