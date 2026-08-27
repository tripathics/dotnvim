vim.loader.enable()
vim.g._start_time = vim.uv.hrtime()

require 'settings'
require 'keymaps'
require 'autocmds'
require 'cmds'
require 'lsp'

require('vim._core.ui2').enable {}

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        vim.notify(string.format('Config loaded in %.2f ms', (vim.uv.hrtime() - vim.g._start_time) / 1e6))
    end,
})
