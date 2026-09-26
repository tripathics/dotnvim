local textYankGroup = vim.api.nvim_create_augroup('text_yank_group', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = textYankGroup,
    callback = function() vim.hl.hl_op() end,
})

local rnuToggleGroup = vim.api.nvim_create_augroup('tripathics/relative_line_numbers', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
    group = rnuToggleGroup,
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = true
        end
    end,
})
vim.api.nvim_create_autocmd('WinLeave', {
    group = rnuToggleGroup,
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = false
        end
    end,
})

-- now we have to autostart treesitter ourselves
local treesitterStartGroup = vim.api.nvim_create_augroup('tripathics/treesitter_start_group', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = treesitterStartGroup,
    callback = function(args)
        local bufnr = args.buf
        -- again copied from maria
        if vim.bo[bufnr].filetype ~= 'bigfile' then
            pcall(vim.treesitter.start, bufnr)
        end
    end,
})

-- some highlight overrides
vim.api.nvim_create_augroup('tripathics/hl-overrides', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
            underdotted = true,
            sp = comment_hl.fg,
        })
        vim.api.nvim_set_hl(0, 'TreesitterContext', {})

        local foldColHl = vim.api.nvim_get_hl(0, { name = 'FoldColumn' })
        vim.api.nvim_set_hl(0, 'FoldColumn', {
            bg = foldColHl.bg,
            fg = nil,
        })
    end,
})

-- mkview and loadview automatically
local fold_group = vim.api.nvim_create_augroup('tripathics/remember_folds', { clear = true })
vim.api.nvim_create_autocmd('BufWinLeave', {
    group = fold_group,
    callback = function()
        if vim.bo.buftype == '' then
            vim.cmd 'silent! mkview'
        end
    end,
})
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = fold_group,
    callback = function()
        if vim.bo.buftype == '' then
            vim.cmd 'silent! loadview'
        end
    end,
})
