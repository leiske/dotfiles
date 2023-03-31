
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

      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
      'williamboman/mason.nvim',
      build = function()
	pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
      'williamboman/mason.nvim',
      build = function()
	pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter', 
    build = function()
      pcall(vim.cmd, 'TSUpdate')
    end,
  }
}
})
-- use {
  --   'nvim-telescope/telescope.nvim', tag = '0.1.1',
  --   -- or                            , branch = '0.1.x',
  --   requires = { {'nvim-lua/plenary.nvim'} }
  -- }

  --  use({ 
    --	  'rose-pine/neovim',
    --	  as = 'rose-pine',
    --	  config = function()
      --		  vim.cmd('colorscheme rose-pine')
      --	  end
      --  })

      -- use({ 
	--   'sainnhe/everforest',
	--   as = 'everforest',
	--   config = function()
	  -- vim.cmd('colorscheme everforest')
	  --   end
	  -- })

	  -- use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })


	  -- -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	  -- use {
	    --   'VonHeikemen/lsp-zero.nvim',
	    --   branch = 'v1.x',
	    --   requires = {
	      -- -- LSP Support
	      -- {'neovim/nvim-lspconfig'},             -- Required
	      -- {'williamboman/mason.nvim'},           -- Optional
	      -- {'williamboman/mason-lspconfig.nvim'}, -- Optional

	      -- -- Autocompletion
	      -- {'hrsh7th/nvim-cmp'},         -- Required
	      -- {'hrsh7th/cmp-nvim-lsp'},     -- Required
	      -- {'hrsh7th/cmp-buffer'},       -- Optional
	      -- {'hrsh7th/cmp-path'},         -- Optional
	      -- {'saadparwaiz1/cmp_luasnip'}, -- Optional
	      -- {'hrsh7th/cmp-nvim-lua'},     -- Optional

	      -- -- Snippets
	      -- {'L3MON4D3/LuaSnip'},             -- Required
	      -- {'rafamadriz/friendly-snippets'}, -- Optional
	      --   }
	      -- }
	      -- end)
