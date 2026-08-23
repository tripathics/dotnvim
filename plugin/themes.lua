local add = require('utils.pack').add

add({
    {
        src = 'rose-pine/neovim',
        name = 'rose-pine',
        events = { 'ColorSchemePre' },
        pattern = { 'rose-pine', 'rose-pine-moon', 'rose-pine-dawn', 'rose-pine-main' },
    },
    { src = 'rebelot/kanagawa.nvim', config = function() vim.cmd.colorscheme 'kanagawa-dragon' end },
    {
        src = 'neanias/everforest-nvim',
        events = { 'ColorSchemePre' },
        pattern = 'everforest',
        config = function()
            require('everforest').setup {
                background = 'hard',
                italics = true,
                on_highlights = function(hl, palette)
                    hl.LspReferenceText = { bg = palette.bg1 }
                    hl.LspReferenceRead = { bg = palette.bg1 }
                    hl.LspReferenceWrite = { bg = palette.bg1, underline = true }

                    -- nvim-treesitter/nvim-treesitter-context
                    hl.TreesitterContext = { bg = palette.bg2 }
                    hl.TreesitterContextBottom = { bg = palette.bg2, underline = true, sp = palette.grey0 }

                    -- diagnostics
                    hl.DiagnosticUnderlineHint = { undercurl = true, sp = palette.purple, fg = palette.none }
                end,
            }
        end,
    },
}, true)
