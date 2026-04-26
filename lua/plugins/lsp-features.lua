-- LSP 功能增强：Document Highlight、Inlay Hint、CodeLens、Inline Completion 等
---@diagnostic disable: undefined-global
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    document_highlight = {
      enable = true,
    },
    inlay_hints = {
      enable = true,
    },
    codelens = {
      enable = true,
    },
    inline_completion = {
      enable = true,
    },
    on_type_formatting = {
      enable = true,
    },
    linked_editing_range = {
      enable = true,
    },
  },
  config = function(_, opts)
    local function augroup(name)
      return vim.api.nvim_create_augroup("lsp_" .. name, { clear = false })
    end

    local M = {}

    M.on_attach = function(client, bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      if opts.document_highlight.enable and client.server_capabilities.documentHighlightProvider then
        local group = augroup("document_highlight")
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      if opts.inlay_hints.enable and client:supports_method("textDocument/inlayHint", bufnr) then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      if opts.codelens.enable and client:supports_method("textDocument/codeLens", bufnr) then
        vim.lsp.codelens.enable(true, { bufnr = bufnr })
      end

      if opts.inline_completion.enable and client:supports_method("textDocument/inlineCompletion", bufnr) then
        vim.lsp.inline_completion.enable(true)
        -- inline completion keymaps (buffer-local)
        vim.keymap.set("i", "<M-CR>", function()
          if not vim.lsp.inline_completion.get() then return "<M-CR>" end
        end, {
          buffer = bufnr,
          expr = true,
          replace_keycodes = true,
          desc = "Get the current inline completion",
        })
        vim.keymap.set("i", "<M-]>", function()
          vim.lsp.inline_completion.select({ count = 1 })
        end, {
          buffer = bufnr,
          desc = "Next inline completion",
        })
        vim.keymap.set("i", "<M-[>", function()
          vim.lsp.inline_completion.select({ count = -1 })
        end, {
          buffer = bufnr,
          desc = "Prev inline completion",
        })
      end

      if opts.on_type_formatting.enable and client:supports_method("textDocument/onTypeFormatting", bufnr) then
        vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
      end

      if opts.linked_editing_range.enable and client:supports_method("textDocument/linkedEditingRange", bufnr) then
        vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
      end
    end

    M.on_detach = function(client, bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      for _, c in ipairs(clients) do
        if c.id ~= client.id and c.server_capabilities.documentHighlightProvider then
          return
        end
      end
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = augroup("document_highlight"),
      })
    end

    _G.lsp_features = M
  end,
}
