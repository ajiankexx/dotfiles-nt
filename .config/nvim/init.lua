if vim.g.vscode  then
    require('core')
    require('key_mapping')
else
    require('core')
    require('key_mapping')
    require('markdown_support')
    require('package_manager')
    require('lazy').setup({ spec = require('plugins') })
    require('copy')
end
