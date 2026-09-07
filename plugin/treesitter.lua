local add = require('utils.pack').add

add {
    {
        src = 'arborist-ts/arborist.nvim',
        config = function()
            local languages = {
                'angular',
                'bash',
                'c',
                'cpp',
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
                'regex',
                'scss',
                'toml',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            }
            require('arborist').setup {
                prefer_wasm = not vim.fn.has 'linux',
                update_cadence = 'weekly',
                ensure_installed = languages,
            }
        end,
    },
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
