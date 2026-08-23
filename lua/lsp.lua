----
--- Diagnostic config
----
local default_virtual_text_config = {
    current_line = true,
    virt_text_pos = 'eol_right_align',
}

-- Diagnostic config
vim.diagnostic.config {
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = '󰌵 ',
        },
    },
    virtual_text = default_virtual_text_config,
}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', 'gk', function()
    local new_virtual_lines = not vim.diagnostic.config().virtual_lines
    if new_virtual_lines == true then
        vim.diagnostic.config {
            virtual_lines = true,
            virtual_text = false,
        }
        vim.notify 'Virtual lines visible'
    else
        vim.diagnostic.config {
            virtual_lines = false,
            virtual_text = default_virtual_text_config,
        }
        vim.notify 'Virtual lines hidden'
    end
end, { desc = 'Toggle diagnoistic virtual lines' })

--- Setup keymaps and autocmds for given buffer
---@param client_id integer
---@param bufnr integer
---@return boolean
local function onAttach(client_id, bufnr)
    local client = assert(vim.lsp.get_client_by_id(client_id))
    if not client then return false end

    ---Map keys for LSP actions
    ---@param keys string
    ---@param func function|string
    ---@param desc string
    ---@param mode string|string[]|nil
    local keymap = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = 'LSP: ' .. desc })
    end

    -- those color previews beside colors in say css
    if client:supports_method('textDocument/documentColor', bufnr) then
        vim.lsp.document_color.enable(true, { bufnr }, { style = 'virtual' })
    end

    keymap('grn', vim.lsp.buf.rename, 'Rename')

    if client:supports_method 'textDocument/documentHighlight' then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('tripathics/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            group = under_cursor_highlights_group,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = under_cursor_highlights_group,
            callback = vim.lsp.buf.clear_references,
        })
    end

    return true
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('tripathics/lsp-group', { clear = true }),
    callback = function(ev) onAttach(ev.data.client_id, ev.buf) end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
        local ok, blink = pcall(require, 'blink.cmp')
        if ok then vim.lsp.config('*', { capabilities = blink.get_lsp_capabilities(nil, true) }) end
        local servers = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file) return vim.fn.fnamemodify(file, ':t:r') end)
            :totable()
        vim.lsp.enable(servers)
    end,
})
