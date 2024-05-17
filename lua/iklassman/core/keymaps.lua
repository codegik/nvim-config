-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- Markdown preview toggle
keymap.set("n", "<leader>v", ":MarkdownPreviewToggle<CR>") -- split window vertically


-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<CR>") --  go to previous buffer
keymap.set("n", "<leader>=", ":NvimTreeResize +5<CR>") --  go to previous buffer
keymap.set("n", "<leader>-", ":NvimTreeResize -5<CR>") --  go to previous buffer

-- set line wrap
keymap.set("n", "<leader>w", ":set wrap!<CR>")

-- visual mode
keymap.set("v", "<TAB>", ">gv") -- don't leave visual mode after indenting
keymap.set("v", "<S-TAB>", "<gv") -- don't leave visual mode after indenting
keymap.set({"v", "x"}, '"', 'c""<ESC>hp') -- double quotes around selected text
keymap.set("v", '\'', "c''<ESC>hp") -- single quotes around selected text
keymap.set("v", '(', 'c()<ESC>hp') -- parenthesis around selected text
keymap.set("v", '{', 'c{}<ESC>hp') -- brackets around selected text
keymap.set("v", '[', 'c[]<ESC>hp') -- square brackets around selected text
keymap.set("v", '(', 'c()<ESC>hp') -- parenthesis around selected text
keymap.set("v", '<', 'c<><ESC>hp') -- tag around selected text
keymap.set("n", 'd"', 'di"hPl2x') -- remove double quotes around selected text
keymap.set("n", 'd\'', 'di\'hPl2x') -- remove single quotes around selected text
keymap.set("n", 'd(', 'di(hPl2x') -- remove parenthesis around selected text
keymap.set("n", 'd{', 'di{hPl2x') -- remove brackets around selected text
keymap.set("n", 'd[', 'di[hPl2x') -- remove square brackets around selected text
keymap.set("n", 'd<', 'di<hPl2x') -- remove tag around selected text

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- open terminal at bottom and enable navigation
keymap.set("n", "<leader>tt", ":split<CR>:terminal<CR>")
keymap.set("t", "<Esc>", "<C-\\><C-n>")
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- navigate between windows
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

--------------------------
------ Tab Bar -----------
--------------------------

-- Move to previous/next
keymap.set('n', '<leader>h', '<Cmd>BufferPrevious<CR>')
keymap.set('n', '<leader>l', '<Cmd>BufferNext<CR>')
-- Re-order to previous/next
keymap.set('n', '<leader>j', '<Cmd>BufferMovePrevious<CR>')
keymap.set('n', '<leader>k', '<Cmd>BufferMoveNext<CR>')
-- Goto buffer in position...
keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>')
keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>')
keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>')
keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>')
keymap.set('n', '<leader>5', '<Cmd>BufferGoto 5<CR>')
keymap.set('n', '<leader>6', '<Cmd>BufferGoto 6<CR>')
keymap.set('n', '<leader>7', '<Cmd>BufferGoto 7<CR>')
keymap.set('n', '<leader>8', '<Cmd>BufferGoto 8<CR>')
keymap.set('n', '<leader>9', '<Cmd>BufferGoto 9<CR>')
keymap.set('n', '<leader>0', '<Cmd>BufferLast<CR>')
-- Pin/unpin buffer
--keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>')
-- Close buffer
keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR>')
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
keymap.set('n', '<leader>p', '<Cmd>BufferPick<CR>')
-- Sort automatically by...
keymap.set('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>')
keymap.set('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>')
keymap.set('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>')




