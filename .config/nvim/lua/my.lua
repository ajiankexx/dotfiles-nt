local map_set = require('utils').map_set
local map_del = require('utils').map_del

map_set('n', '<leader>k', function()
    vim.notify('hello, nietuan', nil, { title = 'BigTan' })
end
)
