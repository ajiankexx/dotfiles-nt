vim.g.AutoPairsShortcutBackInsert = '<c-b>'
-- We map this manually in key_mapping.lua
vim.g.AutoPairsMapCR = 0
vim.cmd[[autocmd Filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '```':'```', '"""':'"""', "'''":"'''"}]]
