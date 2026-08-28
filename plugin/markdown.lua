local add = require('utils.pack').add

add {
    {
        src = 'MeanderingProgrammer/render-markdown.nvim',
        name = 'render-markdown',
        config = function()
            local render_md = require 'render-markdown'
            render_md.setup {
                latex = { enabled = false },
                file_types = { 'markdown', 'codecompanion' },
                code = {
                    enabled = true,
                    language = false,
                },
            }
            vim.keymap.set(
                'n',
                '<leader>tm',
                function() require('render-markdown').buf_toggle() end,
                { desc = 'Toggle render markdown' }
            )
        end,
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
            -- vim.api.nvim_create_user_command('MarkdownPreviewBuild', function()
            --     for p in vim.o.packpath:gmatch '[a-zA-Z0-9/.]+' do
            --         local dirs = vim.fs.find(
            --             { 'markdown-preview.nvim' },
            --             { limit = math.huge, type = 'directory', path = p }
            --         )
            --         if #dirs == 1 then
            --             local obj = vim.system({ 'bash', '-c', 'cd ' .. dirs[1] .. ' && npm run build' }):wait()
            --             print(vim.inspect(obj))
            --         end
            --     end
            -- end)
        end,
    },
}
