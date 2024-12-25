return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-tree/nvim-tree.lua',
        'nvimdev/lspsaga.nvim',
    },
    config = function()
        require('nvim-dap-virtual-text').setup({})
        local dap, dap_ui = require('dap'), require('dapui')
        dap_ui.setup()
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = vim.fn.expand('~') .. '/codelldb/extension/adapter/codelldb',
                args = { '--port', '${port}' },
            }
        }

        dap.configurations.cpp = {
            {
                name = 'Launch file',
                type = 'codelldb',
                request = 'launch',
                program = function()
                    -- TODO: cmake path?
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
            -- {
            --   name = 'Attach to process',
            --   type = 'codelldb',
            --   request = 'launch',
            --   program = function()
            --     return vim.fn.input('Process PID: ', vim.fn.getcwd() .. '/', 'file')
            --   end,
            --   cwd = '${workspaceFolder}',
            --   stopOnEntry = false,
            -- },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                local port = (config.connect or config).port
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                })
            else
                cb({
                    type = 'executable',
                    command = vim.fn.expand('~') .. '/.virtualenvs/debugpy/bin/python',
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                    },
                })
            end
        end
        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file',
                console = 'integratedTerminal',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                pythonPath = function()
                    local python_path = vim.fn.system('which python')
                    python_path = python_path:gsub('\n', '')
                    return python_path
                end,
            },
        }
        vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '⭕', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '🚫', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint', { text = '📔', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
        local dap_ui_visible = false
        local nvim_tree_visible = false
        local nvim_tree_api = require('nvim-tree.api')
        local function dap_ui_toggle()
            dap_ui_visible = not dap_ui_visible
            dap_ui.toggle()
            if dap_ui_visible then
                if nvim_tree_api.tree.is_visible() then
                    nvim_tree_visible = true
                    nvim_tree_api.tree.close()
                end
            else
                if nvim_tree_visible then
                    nvim_tree_visible = false
                    nvim_tree_api.tree.toggle({
                        cwd = require('utils').get_root_directory(),
                        focus = false,
                    })
                end
            end
        end
        local map_set = require('utils').map_set
        map_set({ 'n' }, '<leader>D', dap_ui_toggle, { desc = 'Toggle debug ui' })
        map_set({ 'n' }, '<c-b>', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
        map_set({ 'n' }, '<f4>', dap.terminate, { desc = 'Debug terminate' })
        map_set({ 'n' }, '<f5>', dap.continue, { desc = 'Debug continue' })
        map_set({ 'n' }, '<f6>', dap.restart, { desc = 'Debug restart' })
        map_set({ 'n' }, '<f9>', dap.step_back, { desc = 'Debug back' })
        map_set({ 'n' }, '<f10>', dap.step_over, { desc = 'Debug next' })
        map_set({ 'n' }, '<f11>', dap.step_into, { desc = 'Debug step into' })
        map_set({ 'n' }, '<f12>', dap.step_out, { desc = 'Debug step out' })
    end,
}
