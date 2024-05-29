-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  -- LSP servers, DAP servers, linters, and formatters
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("nvimtools/none-ls.nvim")
  use("jay-babu/mason-null-ls.nvim")

  -- LSP Java
  use("mfussenegger/nvim-jdtls")
  use("neovim/nvim-lspconfig")
  use("nvimdev/lspsaga.nvim")
  use("mfussenegger/nvim-dap")
  use("Mgenuit/nvim-dap-kotlin")
  use("nvim-neotest/nvim-nio")
  use({"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}})

  -- auto completetion
  -- use("github/copilot.vim")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- auto close chars
  use("m4xshen/autoclose.nvim")

  -- style and icons
  use("folke/tokyonight.nvim")
  use("marko-cerovac/material.nvim")
  use("nvim-tree/nvim-web-devicons")

  use ("SmiteshP/nvim-navic")

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup({
        theme = 'tokyonight',
      })
    end,
  })

  -- required by telescope
  use("nvim-lua/plenary.nvim")
  use("BurntSushi/ripgrep")
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'build' }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- setup tabbar
  use 'lewis6991/gitsigns.nvim'
  use 'romgrk/barbar.nvim'

  if packer_bootstrap then
    require("packer").sync()
  end
end)
