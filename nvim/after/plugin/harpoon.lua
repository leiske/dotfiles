local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>ha', mark.add_file, {desc = "Add file to harpoon list"})
vim.keymap.set('n', '<leader>hl', ui.toggle_quick_menu, { desc = "Show harpoon list"})

vim.keymap.set('n', '<C-j>', function() ui.nav_file(1) end, { desc = "Harpoon to first buffer"})
vim.keymap.set('n', '<C-k>', function() ui.nav_file(2) end, { desc = "Harpoon to second buffer"})
vim.keymap.set('n', '<C-l>', function() ui.nav_file(3) end, { desc = "Harpoon to third buffer"})
vim.keymap.set('n', '<C-;>', function() ui.nav_file(4) end, { desc = "Harpoon to fourth buffer"})

