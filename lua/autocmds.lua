local textYankGroup = vim.api.nvim_create_augroup('text-yank-group', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    group = textYankGroup,
    callback = function() vim.hl.hl_op() end,
})

-- now we have to autostart treesitter ourselves
local treesitterStartGroup = vim.api.nvim_create_augroup('tripathics/treesitter_start_group', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = treesitterStartGroup,
    callback = function(args)
        local bufnr = args.buf
        -- again copied from maria
        if vim.bo[bufnr].filetype ~= 'bigfile' then pcall(vim.treesitter.start, bufnr) end
    end,
})

-- set angular filetypes
local angularFtGroup = vim.api.nvim_create_augroup('tripathics/angular_ft_group', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = angularFtGroup,
    pattern = '*.component.html',
    callback = function() vim.bo.filetype = 'htmlangular' end,
})

local angularlsFixes = vim.api.nvim_create_augroup('tripathics/angularls_fixes', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = angularlsFixes,
    callback = function(ev)
        local angularls_clients = vim.lsp.get_clients { bufnr = ev.buf, name = 'angularls' }
        if #angularls_clients == 0 then return end

        -- potential clients
        local ts_clients = {
            ts_ls = true,
            vtsls = true,
        }

        for _, cl in ipairs(vim.lsp.get_clients { bufnr = ev.buf }) do
            if ts_clients[cl.name] then cl.server_capabilities.referencesProvider = false end
        end
    end,
})
