return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local which_key = require('which-key')
        local map_set = require('utils').map_set
        which_key.setup({
            delay = vim.o.timeoutlen,
            sort = { "alphanum", "local", "order", "group", "mod" }
        })
        map_set({ 'n' }, 's', '<cmd>WhichKey n s<cr>')
    end,
}
