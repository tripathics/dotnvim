local add = require('utils.pack').add

add {
    {
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
    },
    {
        src = 'lewis6991/gitsigns.nvim',
        events = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gs = require 'gitsigns'

                    ---Map keys for working with hunks
                    ---@param keys string
                    ---@param func function|string
                    ---@param desc string
                    ---@param mode string|string[]|nil
                    local function map(keys, func, desc, mode)
                        mode = mode or { 'n', 'v', 'x' }
                        vim.keymap.set(mode, keys, func, { desc = 'GitSigns: ' .. desc, buf = bufnr })
                    end

                    map('[c', function() gs.nav_hunk 'prev' end, 'Prev git change')
                    map(']c', function() gs.nav_hunk 'next' end, 'Next git change')

                    -- blame
                    map('<leader>ht', gs.toggle_current_line_blame, '[T]oggle current line blame')
                    map('<leader>hb', gs.blame_line, '[B]lame line')
                    map('<leader>hB', gs.blame, '[B]lame')

                    -- hunks
                    map('<leader>hp', gs.preview_hunk, '[H]unk [p]review')
                    map('<leader>hr', gs.reset_hunk, '[H]unk [r]eset')
                    map('<leader>hR', gs.reset_buffer, '[R]eset buffer')
                    map('<leader>hs', gs.stage_hunk, '[H]unk [s]tage')
                    map('<leader>hS', gs.stage_buffer, '[S]tage buffer')
                end,
            }
        end,
    },
}
