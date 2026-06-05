-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- Scope LazyVim's "Root Dir" pickers to the cwd (the folder you open nvim in)
-- instead of walking up to the nearest .git. This makes <leader>ff and
-- <leader>sg search only the current folder, not the parent monorepo.
vim.g.root_spec = { "cwd" }
