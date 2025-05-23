require('core')
require('key_mapping')
require('markdown_support')
require('package_manager')
require('lazy').setup({ spec = require('plugins') })
require('my')
require('debug')

function hello()
    print("hello, nietuan")
end
