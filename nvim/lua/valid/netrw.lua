
local netrw_ignore = {'.DS_STORE', '.git', 'node_modules'};

-- vim.g.netrw_banner = 0;

vim.g.netrw_list_hide = table.concat(netrw_ignore, ",");
-- vim.g.netrw_hide = 1;
-- vim.g.netrw_winsize = 15;
-- vim.g.netrw_liststyle = 3;

-- vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro';
