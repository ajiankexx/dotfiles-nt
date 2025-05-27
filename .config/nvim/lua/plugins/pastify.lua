return {
    'ajiankexx/pastify.nvim',
    event = 'VeryLazy',
    keys = {
        {
            '<C-RightMouse>',
            '<cmd>Pastify<cr>',
            mode = { 'i', 'n' },
            desc = 'Paste image from system clipboard'
        },
    },
    cmd = { 'Pastify', 'PastifyAfter' },
    ft = vim.g.markdown_support_filetype,
    config = function()
        require('pastify').setup {
            opts = {
                filename = function() return vim.fn.expand("%:t:r") .. '_' .. os.date('%Y-%m-%d_%H-%M-%S') end,
                local_path = '/.assets/',
                save = 'local',
            },
            ft = {
                markdown = '![]($IMG$)',

            }
        }
    end
}
