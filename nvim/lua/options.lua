local options = {
  -- Set highlight on search
  hlsearch = false,
  incsearch = true,

  -- Make line numbers default
  number = true,
  relativenumber = true,

  -- Enable break indent
  breakindent = true,

  -- Case insensitive searching UNLESS /C or capital in search
  ignorecase = true,
  smartcase = true,

  -- Keep signcolumn on by default
  signcolumn = 'yes',

  -- Decrease update time
  updatetime = 50,

  -- Used for which-key
  timeout = true,
  timeoutlen = 300,

  -- Set completeopt to have a better completion experience
  completeopt = 'menuone,noselect',

  -- NOTE: You should make sure your terminal supports this
  termguicolors = true,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,

  smartindent = true,

  -- Persistent undos (sort of?)
  swapfile = false,
  undodir = os.getenv("HOME").. "/.config/nvim/undodir",
  undofile = true,

  scrolloff = 8,

  -- more natural placement of new windows
  splitbelow = true,
  splitright = true,

  -- highlight horizontally the line the cursor is on
  cursorline = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- only run on work machine, maybe move away from IS_BASH lol
if (not IS_BASH) then
  vim.g.gh_github_domain = os.getenv("WORK_GH_DOMAIN");
end

vim.g.gh_line_map_default = 1
