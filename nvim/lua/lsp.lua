-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        'java',
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'tsx',
        'javascript',
        'html',
        'css',
        'typescript',
        'vimdoc',
        'vim',
        'php',
        'query',
        'regex',
        'bash',
        'markdown',
        'markdown_inline',
        'groovy',
    },

    modules = {},
    sync_install = true,
    ignore_install = {},

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-h>',
            node_incremental = '<c-h>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-h>',
        },
    },
    textobjects = {
        enable = true,
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
  }

-- this is what I have defined in Mason prior to the v11 update
local lsp_servers = {
  "graphql",
  "groovyls",
  -- php
  "intelephense",
  "java_language_server",
  "lua_ls",
  "terraformls",
  -- typescript
  "ts_ls",
  "ts_query_ls",
}

vim.lsp.enable(lsp_servers)

-- set formatting based on file types here
vim.filetype.add({
    extension = {
        -- yaml = 'helm',
      -- using ansible templating for docker compose yaml files
        j2 = 'yaml',
        hbs = 'html',
        tf = 'terraform',
    },
    pattern = {
        ['.*%.blade%.php'] = 'blade',
    },
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- vim.lsp.config[server_name] = {
-- 	capabilities = capabilities,
-- 	settings = masonServers[server_name],
-- 	filetypes = (masonServers[server_name] or {}).filetypes,
-- }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

cmp.setup {
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- refers to docs in the right panel
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- close completions menu
        ['<C-e>'] = cmp.mapping.abort(),
        -- complete means open up the completions menu
        ['<C-h>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
                fallback()
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
    },
}
