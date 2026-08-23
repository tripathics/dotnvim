local add = require('utils.pack').add

add {
    {
        src = 'j-hui/fidget.nvim',
        name = 'fidget',
        config = function() require('fidget').setup {} end,
    },
}
