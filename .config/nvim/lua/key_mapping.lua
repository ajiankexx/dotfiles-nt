local map_set = require('utils').map_set
local map_del = require('utils').map_del

map_del({ 'x', 'n' }, 'gc')
map_del({ 'n' }, '<c-w>d')
map_del({ 'n' }, '<c-w><c-d>')

map_set({ 'n' }, 'Y', 'y$')
map_set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to + reg' })
map_set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from + reg' })
map_set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste before from + reg' })
map_set({ 'n' }, '<leader>ay', function()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command('normal! ggVGy')
    vim.api.nvim_win_set_cursor(0, cur)
    vim.defer_fn(function() vim.fn.setreg('+', vim.fn.getreg('"')) end, 0)
end, { desc = 'Yank all to + reg' })
map_set({ 'n' }, '<leader>Y', '"+y$', { desc = 'Yank till eol to + reg' })
map_set({ 'n' }, '<leader>sc', '<cmd>set spell!<cr>', { desc = 'Toggle spell check' })
map_set({ 'n' }, '<leader><cr>', '<cmd>nohlsearch<cr>', { desc = 'No hlsearch' })
map_set({ 'n' }, '<leader>h', '<cmd>set nosplitright<cr><cmd>vsplit<cr><cmd>set splitright<cr>',
    { desc = 'Split right' })
map_set({ 'n' }, '<leader>l', '<cmd>set splitright<cr><cmd>vsplit<cr>',
    { desc = 'Split left' })
map_set({ 'i', 'c', 'x', 'v', 'n' }, '<c-n>', '<c-\\><c-n>')
map_set({ 'n' }, '<up>', '<cmd>res +5<cr>')
map_set({ 'n' }, '<down>', '<cmd>res -5<cr>')
map_set({ 'n' }, '<left>', '<cmd>vertical resize -5<cr>')
map_set({ 'n' }, '<right>', '<cmd>vertical resize +5<cr>')
map_set({ 'n' }, '<leader>i', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
map_set({ 'i' }, '<m-cr>', '<esc><cr>')
map_set({ 'i' }, '<c-h>', '<left>')
map_set({ 'i' }, '<c-j>', '<down>')
map_set({ 'i' }, '<c-k>', '<up>')
map_set({ 'i' }, '<c-l>', '<right>')

-- TODO: update this with nvim-cmp
-- map_set('n', 'gcl', '<plug>(coc-codelens-action)', opts)

local mapped_punc = {
    [','] = '，',
    ['.'] = '。',
    [':'] = '：',
    ['?'] = '？',
    ['\\'] = '、'
    -- FIX: can not work now
    -- [';'] = '；',
}
map_set({ 'n', 'i' }, '<c-space>', function()
    -- We must check the status before the toggle
    if vim.g.rime_enabled then
        for k, _ in pairs(mapped_punc) do
            map_del({ 'i' }, k .. '<space>')
        end
    else
        -- Chinese punctuations
        for k, v in pairs(mapped_punc) do
            map_set({ 'i' }, k .. '<space>', v)
        end
    end
    vim.cmd('RimeToggle')
end)
