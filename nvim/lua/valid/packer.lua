
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- File tree
  -- use('nvim-tree/nvim-tree.lua')

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      vim.cmd('colorscheme catppuccin-macchiato')
    end
  }

  use  {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter-context',
    requires = {
        {'nvim-treesitter/nvim-treesitter'}
    },
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {
        {'nvim-treesitter/nvim-treesitter'}
    },
  }

  use 'ThePrimeagen/harpoon'
  -- use 'ThePrimeagen/vim-be-good'
  use 'mbbill/undotree'
  -- use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  -- gc in V mode to comment
  use 'tpope/vim-commentary'
  -- use {
  --   'numToStr/Comment.nvim',
  --   config = function()
  --       require('Comment').setup()
  --   end
  -- }
  -- use 'echasnovski/mini.pairs'
  -- use 'tpope/vim-sleuth'
  -- Colored brackets
  -- use 'HiPhish/nvim-ts-rainbow2'
  -- Sticky headers

  -- Pending keybinds
  use 'folke/which-key.nvim'

  -- use 'lewis6991/impatient.nvim'
  use 'lewis6991/gitsigns.nvim'
  -- use 'takac/vim-hardtime'

  use 'maxmellon/vim-jsx-pretty'
  use 'yuezk/vim-js'

  -- Open current line on GitHub
  use 'ruanyl/vim-gh-line'

  -- status updates for lsp
  use 'j-hui/fidget.nvim'
  use 'chrisbra/Colorizer'

  -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- use 'MunifTanjim/prettier.nvim'
  -- use 'psf/black'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }
  use 'ggandor/leap.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use 'github/copilot.vim'

end)
