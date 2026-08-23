local isLinux = vim.fn.has 'linux' == 1
local add = require('utils.pack').add
local picker_util = require 'utils.picker'

local fzf_lua_spec = {
    src = 'ibhagwan/fzf-lua',
    keys = isLinux and picker_util.keymaps or {},
    config = function()
        if not isLinux then return end

        local vertical_picker_layout = {
            winopts = {
                preview = {
                    layout = 'vertical',
                    vertical = 'up:60%',
                },
            },
        }

        local fzf_lua = require 'fzf-lua'
        fzf_lua.setup({
            files = { previewer = false },
            oldfiles = { previewer = false },
            buffers = vertical_picker_layout,
            grep = vertical_picker_layout,
            blines = vertical_picker_layout,

            lsp = {
                winopts = vertical_picker_layout,
                code_actions = { previewer = false },
            },
        }, true)

        picker_util.map_pickers {
            blines = fzf_lua.blines,
            buffers = fzf_lua.buffers,
            builtin = fzf_lua.builtin,
            files = fzf_lua.files,
            oldfiles = fzf_lua.oldfiles,
            resume = fzf_lua.resume,
            undotree = fzf_lua.undotree,
            git_status = fzf_lua.git_status,
            git_commits = fzf_lua.git_commits,
            help_tags = fzf_lua.help_tags,
            keymaps = fzf_lua.keymaps,
            live_grep = fzf_lua.live_grep,
            lsp_declarations = fzf_lua.lsp_declarations,
            lsp_definitions = fzf_lua.lsp_definitions,
            lsp_document_symbols = fzf_lua.lsp_document_symbols,
            lsp_implementations = fzf_lua.lsp_implementations,
            lsp_references = fzf_lua.lsp_references,
            lsp_workspace_symbols = fzf_lua.lsp_workspace_symbols,
        }
    end,
}

local loaders = add { fzf_lua_spec }

if isLinux then
    picker_util.register_ui_select(
        loaders[fzf_lua_spec.src],
        function() pcall(require('fzf-lua').register_ui_select) end
    )
end
