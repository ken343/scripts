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
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim'

" Initialize plugin system
call plug#end()

" My Settings
set nu
inoremap jj <Esc>
set visualbell
colorscheme ron

" Conqer of Completion
hi! CocErrorSign guifg=#d1666a
hi! CocInfoSign guibg=#353b45
hi! CocWarningSign guifg=#d1cd66
