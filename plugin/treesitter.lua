local add = require('utils.pack').add

if vim.fn.has 'linux' == 1 then
    add {
        src = 'romus204/tree-sitter-manager.nvim',
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
            require('tree-sitter-manager').setup {
                ensure_installed = languages,
                auto_install = false,
            }
        end,
    }
end

add {
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
}
