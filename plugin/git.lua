local add = require('utils.pack').add

add {
    src = 'tpope/vim-fugitive',
    config = function()
        local keys = {
            { '<leader>gs', vim.cmd.Git, desc = 'Git status' },
            {
                '<leader>gl',
                function() vim.cmd.Git 'log --oneline --graph' end,
                desc = 'Git log oneline',
            },
            { '<leader>gL', ':Git log --name-status ', desc = 'Git log this file' },
            { '<leader>gc', '<cmd>0Gclog!<CR>', desc = 'Git log this file' },
            { '<leader>gd', '<cmd>Gvdiffsplit!<CR>', desc = 'Git diff this' },
            { '<leader>gD', ':Gvdiffsplit HEAD~1 ', desc = 'Git Diff command' },
            { 'gu', '<cmd>diffget //2<CR>', desc = 'Get ours' },
            { 'gh', '<cmd>diffget //3<CR>', desc = 'Get theirs' },
        }

        for _, key in ipairs(keys) do
            vim.keymap.set('n', key[1], key[2], { desc = key[3] })
        end
    end,
}
