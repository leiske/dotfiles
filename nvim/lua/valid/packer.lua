
-- Install lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  'wbthomason/packer.nvim',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/playground',
  'ThePrimeagen/harpoon',
  'ThePrimeagen/vim-be-good',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-sleuth',
  'echasnovski/mini.pairs',
  'folke/which-key.nvim',
  'j-hui/fidget.nvim',
  'HiPhish/nvim-ts-rainbow2',

  {
    'sainnhe/everforest',
    as = 'everforest',
    build = function()
      vim.cmd('colorscheme everforest')
    end
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
},
-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
{ -- LSP Configuration & Plugins
'neovim/nvim-lspconfig',
dependencies = {
-- Automatically install LSPs to stdpath for neovim
'williamboman/mason.nvim',
'williamboman/mason-lspconfig.nvim',

-- Useful status updates for LSP
-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
{ 'j-hui/fidget.nvim', opts = {} },

-- Additional lua configuration, makes nvim stuff amazing!
'folke/neodev.nvim',
    },
  },
  { -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
},
})

