if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
" Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-fugitive'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'neoclide/coc.nvim'
Plug 'scrooloose/syntastic' 
" Initialize plugin system
Plug 'sheerun/vim-polyglot'
Plug 'agude/vim-eldar'

call plug#end()

" My Settings
set nu
inoremap jj <Esc>
set visualbell
colorscheme eldar
syntax on
filetype plugin indent on

" Syntastic Beginner Settings before manual :help syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" Conqer of Completion
"hi! CocErrorSign guifg=#d1666a
"hi! CocInfoSign guibg=#353b45
"hi! CocWarningSign guifg=#d1cd66
"
"let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
"let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
"let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
"let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
"let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
"let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
"let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
