-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  print("Error loading lspconfig")
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  print("Error loading cmp-nvim-lsp")
  return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  print("Error loading typescript")
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gD", "<Cmd>Lspsaga peek_definition<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "<leader>i", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>rv", "<cmd>lua require'jdtls'.extract_variable()<CR>", opts) -- smart rename
  keymap.set("v", "<leader>rv", "<cmd>lua require'jdtls'.extract_variable(true)<CR>", opts) -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>f", "<cmd>Lspsaga finder<CR>", opts)
  keymap.set('n', '<leader>t', '<cmd>Lspsaga term_toggle<CR>', opts)
  keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure kotlin server
lspconfig["kotlin_language_server"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure ocaml server
lspconfig["ocamllsp"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


-- configure python server
lspconfig["pylsp"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


-- configure java server
local home = os.getenv('HOME')
local jdtls_dir = "/opt/homebrew/Cellar/jdtls/1.35.0/libexec"
lspconfig["jdtls"].setup({
  cmd = {
    home .. '/.sdkman/candidates/java/17.0.3.6.1-amzn/bin/java',
    '-javaagent:' .. home .. '/.local/share/lib/lombok.jar',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Dosgi.checkConfiguration=true',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dosgi.sharedConfiguration.area=' .. jdtls_dir .. '/config_mac',
    '-Dosgi.sharedConfiguration.area.readOnly=true',
    '-Dosgi.configuration.cascaded=true',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar',
    '-data', home .. '/.cache/jdtls/workspace',
    '-configuration', home .. '/.cache/jdtls/config',
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})


