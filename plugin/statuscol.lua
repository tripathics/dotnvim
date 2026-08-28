local add = require('utils.pack').add

local gitsigns_loader = add {
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
}

local gs
local get_gitsigns = function()
    if not gs then
        gitsigns_loader()
        gs = require 'gitsigns'
    end
    return gs
end

add {
    src = 'nvim-mini/mini.statuscolumn',
    config = function()
        local gitsigns = get_gitsigns()

        local function active(data)
            local gitsigns_sign = gitsigns.statuscolumn(data.buf_id)
            return '%s%=%l%C' .. gitsigns_sign
        end

        require('mini.statuscolumn').setup {
            content = {
                active = active,
                inactive = nil,
            },
            dim_inactive = false,
        }
    end,
}
