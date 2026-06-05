local is_mac = vim.fn.has("mac") == 1

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = is_mac and { mason = false } or {},
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      if is_mac then
        local jdtls = vim.fn.exepath("jdtls")
        if jdtls == "" then
          jdtls = "/opt/homebrew/bin/jdtls"
        end
        opts.cmd = { jdtls }
      end
      return opts
    end,
  },
}
