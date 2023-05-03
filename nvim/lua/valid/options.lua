-- Fat cursor
-- vim.o.guicursor = ""

-- vim.g.hardtime_default_on = 1;

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 50

-- Used for which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.o.swapfile = false
vim.o.undodir = os.getenv("HOME").. "/.config/nvim/undodir"
vim.o.undofile = true

vim.o.scrolloff = 8

vim.o.splitbelow = true
vim.o.splitright = true
