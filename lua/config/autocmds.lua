-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufReadCmd", {
  group = vim.api.nvim_create_augroup("jar_source_reader", { clear = true }),
  pattern = "jar:file:/*",
  callback = function(ev)
    local after = vim.api.nvim_buf_get_name(ev.buf):match("jar:file:/+(.*)$")
    if not after then
      return
    end
    local jpath, ipath = after:match("^(.-)!/(.*)$")
    if not jpath then
      return
    end
    local lines = vim.fn.systemlist({ "unzip", "-p", "/" .. jpath, ipath })
    if vim.v.shell_error ~= 0 then
      return
    end
    vim.bo[ev.buf].modifiable = true
    vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
    vim.bo[ev.buf].modified = false
    vim.bo[ev.buf].modifiable = false
    local ft = vim.filetype.match({ filename = ipath })
    if ft then
      vim.bo[ev.buf].filetype = ft
    end
  end,
})
