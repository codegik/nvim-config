-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>;", ":set wrap!<CR>")
vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<M-Right>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<M-Left>", ":vertical resize +2<CR>", { silent = true })
