local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        },
        Javascript = {
            diagnostics = {
                globals = { 'fetch', 'createImageBitmap' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local optsWithDesc = function(desc2)
        return {
            buffer = bufnr,
            remap = false,
            desc = desc2,
        }
    end
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, optsWithDesc("(g)o to (d)efinition"))
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, optsWithDesc("Show hover menu"))
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, optsWithDesc("Show (v)im (w)orkspace (s)ymbols"))
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, optsWithDesc("Open (v)im (d)iagnostic floating window"))
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, optsWithDesc("Goto next diagnostic item"))
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, optsWithDesc("Goto previous diagnostic item"))
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, optsWithDesc("Run (v)im (c)ode (a)ctions"))
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, optsWithDesc("Show (v)im (r)efe(r)ences"))
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, optsWithDesc("(v)im (r)e(n)ame, Rename the symbol in the buffer"))
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, optsWithDesc("Signature Help"))
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

