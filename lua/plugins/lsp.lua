-- lua/lsp.lua
-- LSP 服务器配置 + jdtls 特殊处理
-- 注意：Neovim 0.11中直接使用vim.lsp API，不再依赖nvim-lspconfig
-- 使用一个简单的配置插件
return {
  -- 一个轻量级的配置占位符
  "echasnovski/mini.nvim",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- 创建基础 capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- 尝试加载 cmp_nvim_lsp，如果存在则使用
    local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    else
      -- 可选：开发时提示
      vim.notify("cmp_nvim_lsp not found. Install it via lazy.nvim for better completion.", vim.log.levels.WARN)
    end

    -- 确保支持代码片段（对HTML/Emmet很重要）
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- 通用 on_attach 回调
    local on_attach = function(client, bufnr)
      -- 禁用格式化，交由 null-ls 或专门的格式化工具处理
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- LSP 常用快捷键 (已移动到 core/keymap.lua 中的 LspAttach 自动命令)
      -- local opts = { noremap = true, silent = true, buffer = bufnr }
      -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "跳转到声明 (Go to Declaration)", buffer = bufnr })
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "跳转到定义 (Go to Definition)", buffer = bufnr })
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "显示文档 (Hover Documentation)", buffer = bufnr })
      -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "跳转到实现 (Go to Implementation)", buffer = bufnr })
      -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "签名帮助 (Signature Help)", buffer = bufnr })
      -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "重命名变量 (Rename)", buffer = bufnr })
      -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { desc = "代码操作 (Code Action)", buffer = bufnr })
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "查看引用 (References)", buffer = bufnr })
      -- vim.keymap.set('n', '<space>f', function()
      --   vim.lsp.buf.format { async = true }
      -- end, { desc = "格式化代码 (Format Code)", buffer = bufnr })

      -- 30. 诊断跳转 (Diagnostic Jumps)
      -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "上一个诊断 (Previous Diagnostic)", buffer = bufnr })
      -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "下一个诊断 (Next Diagnostic)", buffer = bufnr })
    end

    -- LSP 服务器自定义配置 - 修正：添加正确的命令
    local servers = {
      lua_ls = {
        cmd = { "lua-language-server" }, -- 修正：使用正确的命令名称
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "use", "describe", "it" }, -- 常见测试框架
            },
            workspace = {
              checkThirdParty = false, -- 避免第三方库类型检查干扰
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
      pyright = {
        cmd = { "pyright-langserver", "--stdio" }, -- 修正：添加正确的命令
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly", -- 优化：只检查打开的文件，提升大型项目性能
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      },
      clangd = {
        cmd = {
          "clangd",
          "--background-index",          -- 后台建立索引
          "--clang-tidy",                -- 开启 clang-tidy
          "--header-insertion=iwyu",     -- 自动导入头文件
          "--completion-style=detailed", -- 详细补全信息
          "--function-arg-placeholders", -- 补全函数时填充参数占位符
          "--fallback-style=llvm",
          "-j=4",                        -- 并行处理
          "--pch-storage=memory",        -- 内存缓存 PCH，提升速度
        },
      },
      html = {
        cmd = { "vscode-html-language-server", "--stdio" }, -- 修正：添加命令
        filetypes = { "html" }
      },
      cssls = {
        cmd = { "vscode-css-language-server", "--stdio" }, -- 修正：添加命令
      },
      tsserver = {                                         -- 修正：服务器名称应该是 tsserver
        cmd = { "typescript-language-server", "--stdio" }, -- 修正：添加命令
      },
      emmet_ls = {
        cmd = { "emmet-ls", "--stdio" }, -- 修正：添加命令
        filetypes = { "html", "jsx", "tsx", "vue", "svelte" },
      },
      racket = {
        cmd = { "racket", "-l", "racket-langserver" },
        filetypes = { "racket", "scheme" },
      },
    }

    -- 为Neovim 0.11创建简化的LSP配置
    _G.my_lsp_config = {
      capabilities = capabilities,
      on_attach = on_attach,
      servers = servers
    }

    -- 美化通知的函数
    local function notify_success(message)
      vim.notify("✅ " .. message, vim.log.levels.INFO, {
        title = "LSP 状态",
        icon = "",
      })
    end

    local function notify_warning(message)
      vim.notify("⚠️ " .. message, vim.log.levels.WARN, {
        title = "LSP 警告",
        icon = "",
      })
    end

    local function notify_error(message)
      vim.notify("❌ " .. message, vim.log.levels.ERROR, {
        title = "LSP 错误",
        icon = "",
      })
    end

    local function notify_info(message)
      vim.notify("ℹ️ " .. message, vim.log.levels.INFO, {
        title = "LSP 信息",
        icon = "",
      })
    end

    -- 修正版函数：启动LSP服务器并显示美化状态通知
    function _G.start_lsp_server(filetype)
      -- 映射文件类型到服务器名称
      local filetype_to_server = {
        lua = 'lua_ls',
        python = 'pyright',
        cpp = 'clangd',
        c = 'clangd',
        html = 'html',
        css = 'cssls',
        javascript = 'tsserver',      -- 修正：使用正确的服务器名称
        typescript = 'tsserver',      -- 修正：使用正确的服务器名称
        javascriptreact = 'tsserver', -- 修正：使用正确的服务器名称
        typescriptreact = 'tsserver', -- 修正：使用正确的服务器名称
        vue = 'emmet_ls',
        svelte = 'emmet_ls',
        racket = 'racket',
        scheme = 'racket'
      }

      local server_name = filetype_to_server[filetype]
      if not server_name then
        notify_info(string.format("文件类型 '%s' 未配置LSP服务器", filetype))
        return
      end

      if not _G.my_lsp_config.servers[server_name] then
        notify_warning(string.format("LSP服务器 '%s' 未在配置中定义", server_name))
        return
      end

      -- 检查服务器是否已启动
      local active_clients = vim.lsp.get_clients()
      for _, client in ipairs(active_clients) do
        if client.name == server_name then
          notify_info(string.format("LSP服务器 '%s' 已在运行", server_name))
          return
        end
      end

      -- 显示启动进度
      notify_info(string.format("正在启动 %s 服务器...", server_name))

      local config = _G.my_lsp_config.servers[server_name]

      -- 修正：使用正确的命令配置
      local client_config = {
        name = server_name,
        cmd = config.cmd, -- 修正：使用配置中定义的命令
        filetypes = config.filetypes or { filetype },
        root_dir = vim.fn.getcwd(),
        capabilities = _G.my_lsp_config.capabilities,
        on_attach = _G.my_lsp_config.on_attach,
        settings = config.settings or {}
      }

      -- 使用vim.lsp.start API（Neovim 0.8+推荐方式）
      local ok, client_id = pcall(function()
        return vim.lsp.start(client_config)
      end)

      if ok and client_id then
        notify_success(string.format("%s 服务器启动成功", server_name))
      else
        local error_msg = client_id or "未知错误"

        -- 提供更具体的错误建议
        local suggestion = ""
        if string.find(error_msg:lower(), "cmd", 1, true) or
            string.find(error_msg:lower(), "spawn", 1, true) or
            string.find(error_msg:lower(), "executable", 1, true) then
          suggestion = "\n💡 请确保已安装对应的LSP服务器并在PATH中可用"
        elseif string.find(error_msg:lower(), "timeout", 1, true) then
          suggestion = "\n💡 启动超时，请检查网络连接或服务器配置"
        end

        notify_error(string.format("%s 服务器启动失败\n%s%s", server_name, error_msg, suggestion))
      end
    end

    -- 为常见文件类型创建自动命令
    local filetypes = { 'lua', 'python', 'cpp', 'c', 'html', 'css', 'javascript', 'typescript', 'javascriptreact',
      'typescriptreact', 'vue', 'svelte', 'racket', 'scheme' }

    for _, ft in ipairs(filetypes) do
      vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        callback = function(args)
          -- 使用vim.schedule确保通知在合适的时机显示
          vim.schedule(function()
            -- 检查缓冲区是否仍然有效
            if not vim.api.nvim_buf_is_valid(args.buf) then return end

            local buf_ft = vim.bo[args.buf].filetype
            if buf_ft == ft then
              notify_info(string.format("检测到 %s 文件，正在配置LSP...", ft))
              _G.start_lsp_server(ft)
            end
          end)
        end
      })
    end

    -- Java 特殊处理：jdtls
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function(args)
        -- 使用vim.schedule确保通知在合适的时机显示
        vim.schedule(function()
          -- 检查缓冲区是否仍然有效
          if not vim.api.nvim_buf_is_valid(args.buf) then return end

          local buf_ft = vim.bo[args.buf].filetype
          if buf_ft ~= "java" then return end

          notify_info("检测到 Java 文件，正在启动 jdtls...")

          -- 确保 jdtls 插件已加载
          if not pcall(require, "jdtls") then
            notify_error("jdtls 插件未找到，请安装 'mfussenegger/nvim-jdtls'")
            return
          end

          local jdtls = require("jdtls")

          -- 项目根目录检测
          local root_dir = jdtls.setup.find_root({ ".git", "pom.xml", "build.gradle", "gradlew", "mvnw" })
          if not root_dir then
            notify_warning("未找到 Java 项目根目录，jdtls 可能无法正常工作")
            root_dir = vim.fn.getcwd()
          end

          local config = {
            cmd = { "jdtls" }, -- 确保 jdtls 在 PATH 中
            root_dir = root_dir,
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              on_attach(client, bufnr) -- 复用通用 on_attach
              notify_success("jdtls 服务器附加成功")
            end,
          }

          local ok, err = pcall(jdtls.start_or_attach, config)
          if ok then
            notify_success("jdtls 启动成功")
          else
            notify_error("jdtls 启动失败: " .. tostring(err))
          end
        end)
      end,
    })
    -- 添加手动启动LSP的命令，用于调试
    vim.api.nvim_create_user_command('StartLSP', function(opts)
      local ft = opts.args or vim.bo.filetype
      if ft == '' then
        notify_error("请指定文件类型或在当前缓冲区中使用")
        return
      end
      _G.start_lsp_server(ft)
    end, { nargs = '?', complete = function() return filetypes end })

    -- 初始化完成提示
    vim.schedule(function()
      notify_success("LSP 配置加载完成")
    end)
  end,
}
