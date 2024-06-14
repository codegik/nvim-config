local setup, null_ls = pcall(require, "null-ls")
if not setup then
  print("Error loading null-ls")
  return
end

local formatting = null_ls.builtins.formatting
-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

null_ls.setup({
  sources = {
    formatting.prettier,
    formatting.stylua,
    formatting.ktlint,
    formatting.ocamlformat,
    formatting.google_java_format,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<S-F>", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      -- local event = "BufWritePre"
      -- local async = event == "BufWritePost"
      -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      -- vim.api.nvim_create_autocmd(event, {
      --   buffer = bufnr,
      --   group = group,
      --   callback = function()
      --     vim.lsp.buf.format({ bufnr = bufnr, async = async })
      --   end,
      --   desc = "[lsp] format on save",
      -- })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<S-F>", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})
