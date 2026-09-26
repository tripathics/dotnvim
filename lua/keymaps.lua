-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ Windows ]]
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<M-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<M-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<M-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<M-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- resizing windows
vim.keymap.set('n', '<M-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<M-Left>', '<cmd>vertical resize -4<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-Right>', '<cmd>vertical resize +4<CR>', { desc = 'Increase window width' })

-- keep everything centered while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and go to center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and go to center' })

-- indentation
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right staying in visual mode' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left staying in visual mode' })

-- folds
-- Create folds in visual mode, close fold if exists in normal mode
vim.keymap.set({ 'n', 'v' }, 'zc', function()
    local mode = vim.api.nvim_get_mode().mode
    if mode:match '[vV\22]' then
        return 'zf'
    elseif vim.fn.foldlevel '.' > 0 then
        return 'zc'
    end
    vim.notify("Nothing selected. Can't fold", vim.log.levels.WARN)
end, { expr = true, desc = 'Create/Close fold' }) -- treesitter keymaps

vim.keymap.set({ 'x', 'o' }, '+', 'an', { remap = true, desc = 'Treesitter: Expand selection' })
vim.keymap.set({ 'x', 'o' }, '-', 'in', { remap = true, desc = 'Treesitter: Shrink selection' })

-- [[ MISC ]]

-- restart nvim
vim.keymap.set('n', '<leader>R', '<cmd>restart<cr>', { desc = 'Restart Neovim' })

-- open package manager
vim.keymap.set('n', '<leader>P', ':packupdate ', { desc = 'Update or see plugins' })

-- cd into current file parent dir
vim.keymap.set('n', '<leader>.', function()
    vim.cmd 'cd %:p:h'
    vim.notify('cd ' .. vim.fn.getcwd(), vim.log.levels.INFO)
end, { desc = 'Change directory to the directory containing the current file' })

-- buffer keymaps
vim.keymap.set('n', '<C-w>c', '<cmd>hide<CR>', { desc = '[C]lose window' })

-- Terminal keymaps
local TERM = vim.uv.os_uname().sysname ~= 'Linux' and 'bash' or nil

vim.keymap.set('n', '<leader>tt', function()
    vim.cmd.tabnew()
    vim.cmd.term(TERM)
end, { desc = 'Open a [t]erminal in new [t]ab' })

vim.keymap.set('n', '<leader>ts', function()
    vim.cmd.vnew()
    vim.cmd.term(TERM)
    vim.cmd.wincmd 'J'
    vim.api.nvim_win_resize(0, -1, 15)
end, { desc = 'Open a [t]erminal [s]mall' })

-- Toggles
vim.keymap.set('n', '<leader>tw', function() vim.cmd 'set wrap!' end, { desc = '[T]oggle word wrap' })
vim.keymap.set('n', '<leader>tg', function() vim.cmd 'setlocal spell!' end, { desc = '[T]oggle spell check' })
