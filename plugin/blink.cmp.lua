local add = require('utils.pack').add

add {
    {
        src = 'saghen/blink.cmp',
        version = vim.version.range '1.*',
        config = function()
            local blink_cmp = require 'blink.cmp'
            blink_cmp.setup {
                keymap = {
                    preset = 'default',
                    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                    ['<C-d>'] = { 'scroll_documentation_down' },
                    ['<C-u>'] = { 'scroll_documentation_up' },
                },

                fuzzy = { implementation = 'rust' },
                completion = {
                    accept = { auto_brackets = { enabled = false } },
                    documentation = {
                        auto_show = false,
                    },
                },
                signature = {
                    enabled = true,
                    trigger = { enabled = false },
                },
                sources = { default = { 'lsp', 'path', 'snippets' } },
            }
        end,
    },
}
