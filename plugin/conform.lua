local add = require('utils.pack').add

local function toggle_format_on_save()
    vim.g.format_on_save = not (vim.g.format_on_save or false)

    local state = vim.g.format_on_save and 'Enabled' or 'Disabled'
    vim.notify(state .. ': Format on save', vim.log.levels.INFO)
end

add {
    {
        src = 'stevearc/conform.nvim',
        events = { 'BufWritePre' },
        config = function()
            local conform = require 'conform'

            conform.setup {
                formatters_by_ft = {
                    lua = { 'stylua' },
                    htmlangular = { 'prettier' },
                    html = { 'prettier' },
                },
                default_format_opts = {
                    lsp_format = 'fallback',
                },
                notify_on_error = true,
                notify_no_formatters = true,
            }
            vim.g.format_on_save = true -- format on save by default

            local group = vim.api.nvim_create_augroup('tripathics/format_on_save', { clear = true })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = group,
                callback = function()
                    -- if not vim.g.format_on_save then return end

                    require('conform').format {
                        lsp_format = 'fallback',
                        timeout_ms = 500,
                    }
                end,
            })
        end,
        keys = {
            {
                '<leader>b',
                function() require('conform').format() end,
                desc = 'Format buffer',
            },
            {
                '<leader>tb',
                toggle_format_on_save,
                desc = 'Toggle format on save',
            },
        },
    },
}
