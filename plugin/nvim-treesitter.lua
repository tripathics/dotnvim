local add = require('utils.pack').add

local parsers = {
    'angular',
    'bash',
    'c',
    'cpp',
    'fish',
    'gitcommit',
    'go',
    'graphql',
    'html',
    'hyprlang',
    'java',
    'javascript',
    'json',
    'json5',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rasi',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
}

local loaders = add {
    {
        src = 'tripathics/nvim-treesitter',
        config = function()
            local ts = require 'nvim-treesitter'
            ts.setup { prefer_git = true }
        end,
        commands = {
            { 'TSInstall', { nargs = '+', bang = true } },
            { 'TSInstallFromGrammar', { nargs = '+', bang = true } },
            { 'TSUpdate', { nargs = '*' } },
            { 'TSUninstall', { nargs = '+' } },
        },
    },
}
local load_ts = loaders['tripathics/nvim-treesitter']

vim.api.nvim_create_user_command('TSInstallParsers', function()
    load_ts()
    require('nvim-treesitter').install(parsers)
end, { desc = 'Install all configured treesitter parsers', nargs = 0 })

vim.api.nvim_create_user_command('TSUpdateParsers', function()
    load_ts()
    require('nvim-treesitter').update(parsers)
end, { desc = 'Update all configured treesitter parsers', nargs = 0 })

add {
    {
        src = 'nvim-treesitter/nvim-treesitter-context',
        config = function()
            local ts_context = require 'treesitter-context'
            ts_context.setup {
                enable = true,
                -- Avoid the sticky context from growing a lot.
                max_lines = 3,
                -- Match the context lines to the source code.
                multiline_threshold = 1,
                -- Disable it when the window is too small.
                min_window_height = 20,
                -- line_numbers = true,
                trim_scope = 'inner',
            }
        end,
        events = { 'FileType' },
        keys = {
            {
                '[n',
                function()
                    vim.schedule(function() require('treesitter-context').go_to_context() end)
                end,
                desc = 'Jump to upper context',
            },
            {
                '<leader>tc',
                function() require('treesitter-context').toggle() end,
                desc = 'Toggle treesitter context',
            },
        },
    },
}
