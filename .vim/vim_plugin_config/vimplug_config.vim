
" start_symbol_kaiserqzyue
" We add a empty line above to make sure the script append it correctly.
" vim-plug config
call plug#begin('~/.vim/plugged')
" add status bar below
Plug 'vim-airline/vim-airline'
" CtrlP for find files
" Plug 'kien/ctrlp.vim'
" coc to complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" now we use coc, so these two are not used anymore
" YouCompleteMe for code completion.
" Plug 'ycm-core/YouCompleteMe'
" for python fix and notations
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" this can be replaced with coc-git
" gitgutter to see the difference of git repositories' files
" Plug 'airblade/vim-gitgutter'
" Nerd Tree to navigation in folders.
Plug 'preservim/nerdtree'
" onedark theme
Plug 'joshdick/onedark.vim'
" highlight for programming languages
Plug 'sheerun/vim-polyglot'
" undotree to show history of files
Plug 'mbbill/undotree'
" tagbar for outlines of files
Plug 'preservim/tagbar'
" nerd commenter for add comments for lines
Plug 'preservim/nerdcommenter'
" vim-which-key to cheat
Plug 'liuchengxu/vim-which-key'
" nerdtree git status plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
" vimwiki plugin
Plug 'vimwiki/vimwiki'
" vim indent line
Plug 'Yggdroot/indentLine'
" auto-pairs for brakets.
Plug 'jiangmiao/auto-pairs'
" for surrouding, change braces conveniently
Plug 'tpope/vim-surround'
" alignment tool
Plug 'godlygeek/tabular'
" now we are using LeaderF to find files.
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()
" we add a empty line below to make sure the script append it coreectly.
" end_symbol_kaiserqzyue

