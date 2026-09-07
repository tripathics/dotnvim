local add = require('utils.pack').add

local gitsigns_loader = add {
    src = 'lewis6991/gitsigns.nvim',
    events = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local gitsigns = require 'gitsigns'
        gitsigns.setup {
            on_attach = function(bufnr)
                ---Map keys for working with hunks
                ---@param keys string
                ---@param func function|string
                ---@param desc string
                ---@param mode string|string[]|nil
                local function map(keys, func, desc, mode)
                    mode = mode or 'n'
                    local modes = type(mode) == 'table' and mode or { mode }

                    if vim.tbl_contains(modes, 'x') or vim.tbl_contains(modes, 'v') then
                        local original = func
                        func = function()
                            if vim.fn.mode():match '[vV\22]' then -- in visual mode
                                local start, finish = vim.fn.line 'v', vim.fn.line '.'
                                original { math.min(start, finish), math.max(start, finish) }
                            else
                                original()
                            end
                        end
                    end

                    vim.keymap.set(modes, keys, func, {
                        desc = 'GitSigns: ' .. desc,
                        buf = bufnr,
                    })
                end

                map('[c', function() gitsigns.nav_hunk 'prev' end, 'Prev git change', { 'n', 'v' })
                map(']c', function() gitsigns.nav_hunk 'next' end, 'Next git change', { 'n', 'v' })

                -- blame
                map('<leader>ht', gitsigns.toggle_current_line_blame, '[T]oggle current line blame')
                map('<leader>hb', gitsigns.blame_line, '[B]lame line')
                map('<leader>hB', gitsigns.blame, '[B]lame')

                -- hunks
                map('<leader>hp', gitsigns.preview_hunk, '[H]unk [p]review')
                map('<leader>hr', gitsigns.reset_hunk, '[H]unk [r]eset', { 'n', 'v' })
                map('<leader>hR', gitsigns.reset_buffer, '[R]eset buffer')
                map('<leader>hs', gitsigns.stage_hunk, '[H]unk [s]tage', { 'n', 'v' })
                map('<leader>hS', gitsigns.stage_buffer, '[S]tage buffer')
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

        require('mini.statuscolumn').setup {
            content = {
                active = function(data)
                    local buftype = vim.bo[data.buf_id].buftype
                    if buftype == 'help' or buftype == 'terminal' then return '%C%l' end

                    local gitsigns_sign = gitsigns.statuscolumn(data.buf_id)
                    if vim.v.virtnum > 0 then return '%=%C↳' .. gitsigns_sign end
                    return '%=%C%l' .. gitsigns_sign
                end,
                inactive = nil,
            },
            dim_inactive = false,
        }
    end,
}
