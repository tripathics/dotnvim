-- [[ Setting options ]]

-- Use <space> as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Editing ]]
-- indentation (2 spaces, JS)
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.breakindent = true

-- [[ Look and feel ]]
-- fonts
vim.opt.guifont = 'Lilex:h14'
vim.opt.termguicolors = true

vim.opt.showmode = false
-- cursor
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor'
-- left gutter
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.signcolumn = 'yes'

-- folds
vim.wo.foldcolumn = '1'
vim.opt.foldlevelstart = 99
vim.wo.foldtext = ''

vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
    foldclose = '',
    foldopen = '',
    foldsep = ' ',
    foldinner = ' ',
    msgsep = '─',
}

-- scrolling
vim.o.scrolloff = 2

vim.opt.linebreak = true
vim.opt.list = true -- list (show) invisible characters
vim.opt.listchars = { tab = '» ', trail = '·' }

-- how/when we split
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.undofile = true
vim.opt.confirm = true
vim.opt.mouse = 'a'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- completion (took from maria solos)
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumheight = 15
