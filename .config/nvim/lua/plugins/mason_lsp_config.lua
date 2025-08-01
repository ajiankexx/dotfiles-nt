return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    branch = 'v1.x',
    opts = {
        ensure_installed = {
            'clangd',
            'pyright',
            'jdtls',
            'volar', -- vue
            'ts_ls', -- typescript
            'eslint', -- javascript
            'tailwindcss', -- css
            'bashls',
            'lua_ls',
            'neocmake',
            'jsonls',
            'lemminx', -- xml lsp
            'yamlls',
            'gopls',
            'rust_analyzer',
        },
        automatic_installation = true
    }
}
