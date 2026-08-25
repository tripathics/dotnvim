local add = require('utils.pack').add

vim.api.nvim_create_user_command('PackAdd', function(args)
    local short_url = args.args
    add({ { src = short_url } }, true)
end, { desc = 'Add package using user/repo short URL', nargs = 1 })
