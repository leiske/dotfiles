local wk = require('which-key')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = 'Ensure leader(space) isn\'t used' })

-- File Explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open File (Ex)plorer' });

-- Easier exit of insert mode
vim.keymap.set('i', 'jk', '<esc>', { desc = 'Easily escape from insert mode' });

-- Center cursor on screen after moving half-page
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center your cursor when you move down half-page' });
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center your cursor when you move up half-page' });
-- vim.keymap.set('n', '<C-o>', '<C-o>zz',{ desc = 'Center your cursor when returning to a file'});
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Your (n)ext search term will be centered' });
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Your (n)ext search term will be centered' });

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"',
  { expr = true, silent = true, desc = 'Remap for dealing with word wrap' })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"',
  { expr = true, silent = true, desc = 'Remap for dealing with word wrap' })

-- [[ highlight on yank ]]
-- see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('yankhighlight', { clear = true })
vim.api.nvim_create_autocmd('textyankpost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Telescope binds

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

local function getCurrentBufferWorkingDirectory()
  local currentFile = vim.api.nvim_buf_get_name(0);
  -- Looking for this format '*/packages/myPackage/src/foo.js'
  -- so i can restrict my working dir to just myPackage
  local _, packageNameStartIndex = string.find(currentFile, 'packages', 1, true)

  if (packageNameStartIndex == nil) then
    -- this is done to match my work that always follows this convention
    print('not under a parent directory with the name packages')
    return
  end

  local packageWithChildren = currentFile:sub(packageNameStartIndex + 1, #currentFile)
  local packageName = packageWithChildren:sub(1, string.find(packageWithChildren, '/', 2));
  local packageWorkingDir = currentFile:sub(1, packageNameStartIndex) .. packageName;

  if (packageWorkingDir == nil or packageWorkingDir == '') then
    print('could not find packages directory')
    return
  end

  -- Returning '*/packages/myPackage'
  return packageWorkingDir
end

local function gotoDefinition()
  require('telescope.builtin').lsp_definitions({
    initial_mode = 'normal',
    on_complete = {
      function(picker)
        -- remove this on_complete callback
        picker:clear_completion_callbacks()
        -- if we have exactly one match, select it
        if picker.manager.linked_states.size == 1 then
          require('telescope.actions').select_default(picker.prompt_bufnr)
        end
      end,
    }
  })
end

wk.register({
  ['<leader>'] = {
    s = {
      name = 'search',
      f = { require('telescope.builtin').find_files, '[S]earch [F]iles' },
      p = { function()
        local packageWorkingDir = getCurrentBufferWorkingDirectory()
        require('telescope.builtin').find_files({ cwd = packageWorkingDir })
      end, '[S]earch package' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
      n = { '<cmd>enew<cr>', 'New File' },
    },
    g = {
      name = 'goto/github',
      d = { function() gotoDefinition() end, 'Goto definition using lsp (ignores *.d.ts files)' },
      h = { ':GHInteractive<cr>', 'open current line in GitHub' },
      b = { ':GBInteractive<cr>', 'open current line blame in GitHub' },
    },
    t = {
      name = 'toggle',
      b = { ':Gitsigns toggle_current_line_blame<CR>', 'toggle git blame for current line' },
    },
    c = {
      n = { ':cn<CR>zz', 'Next Quickfix' },
      p = { ':cp<CR>zz', 'Previous Quickfix' },
      l = { ':clist<CR>', 'Open Quickfix List' },
      c = { ':cclose<CR>', 'Close Quickfix List' },
    },
  }
})

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move selected lines down by 1' })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move selected lines up by 1' })

vim.keymap.set('x', '<leader>p', '\'_dP', { desc = 'paste over a selected word while retaining your copied item' })
vim.keymap.set('n', '<leader>Y', '\'*Y', { desc = '(Y)ank to system clipboard' })
vim.keymap.set('v', '<leader>y', '\'*y', { desc = '(y)ank to system clipboard' })

vim.keymap.set('v', '<leader>d', '\'_d', { desc = '(d)elete while retaining your copied item' })
vim.keymap.set('n', '<leader>d', '\'_d', { desc = '(d)elete while retaining your copied item' })

vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = '(f)ormat the current buffer' })

vim.keymap.set('t', '<esc>', '<C-\\><C-N>', { desc = 'Escape from terminal mode' })

vim.keymap.set('n', '0', '^', { desc = 'Changes 0 to go to first non-blank character on line' })
vim.keymap.set('v', '0', '^', { desc = 'Changes 0 to go to first non-blank character on line' })

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = 'Add file to harpoon list' })
vim.keymap.set('n', '<leader>hl', ui.toggle_quick_menu, { desc = 'Show harpoon list' })

vim.keymap.set('n', '<C-j>', function() ui.nav_file(1) end, { desc = 'Harpoon to first buffer' })
vim.keymap.set('n', '<C-k>', function() ui.nav_file(2) end, { desc = 'Harpoon to second buffer' })
vim.keymap.set('n', '<C-l>', function() ui.nav_file(3) end, { desc = 'Harpoon to third buffer' })
vim.keymap.set('n', '<C-;>', function() ui.nav_file(4) end, { desc = 'Harpoon to fourth buffer' })


-- lsp stuff
vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, { desc = 'Run (v)im (c)ode (a)ctions' })
vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end,
  { desc = '(v)im (r)e(n)ame, Rename the symbol in the buffer' })
vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end,
  { desc = 'Open (v)im (d)iagnostic floating window' })
vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, { desc = 'Show (v)im (r)efe(r)ences' })

require('leap').add_default_mappings()

vim.keymap.set("n", "<leader>rt", ":!./run.sh <CR>", { desc = "Run the script for whatever repo" })
vim.keymap.set("n", "<leader>re", ":e run.sh <CR>", { desc = "Edit the run script for whatever repo" })
