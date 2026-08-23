local add = require('utils.pack').add

add {
    {
        src = 'olimorris/codecompanion.nvim',
        config = function()
            add { { src = 'nvim-lua/plenary.nvim' } }
            local codecompanion = require 'codecompanion'
            codecompanion.setup {
                adapters = {
                    deepseek = function()
                        return require('codecompanion.adapters').extend('deepseek', {
                            env = {
                                api_key = os.getenv 'DEEPSEEK_API_KEY',
                            },
                        })
                    end,
                },
                strategies = {
                    chat = { adapter = 'opencode' },
                    inline = { adapter = 'opencode' },
                    agent = { adapter = 'opencode' },
                },
            }
        end,
        keys = {
            { '<leader>ca', function() require('codecompanion').actions {} end, desc = 'Code Companion Actions' },
            { '<leader>ct', function() require('codecompanion').toggle() end, desc = 'Code Companion Toggle' },
            {
                '<leader>cv',
                function() require('codecompanion').add { vim.fn.line "'<", vim.fn.line "'>" } end,
                desc = 'Code Companion Toggle',
                mode = 'v',
            },
        },
    },
}
