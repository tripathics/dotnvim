local add = require('utils.pack').add

add {
    {
        src = 'vi6jm/scry.nvim',
        git_host = 'codeberg',
        config = function()
            require('scry').setup {
                auto = false,
                filetypes = { 'markdown', 'codecompanion' },
            }
        end,
        keys = {
            {
                '<bs>',
                function() vim.cmd 'Scry toggle' end,
                desc = 'Toggle scry markdown render',
            },
        },
    },
    {
        src = 'iamcco/markdown-preview.nvim',
        events = { 'FileType' },
        pattern = 'markdown',
        config = function()
            vim.api.nvim_create_user_command(
                'MarkdownPreviewBuild',
                function() vim.fn['mkdp#util#install']() end,
                { desc = 'Install Markdown Preview' }
            )
        end,
    },
}
