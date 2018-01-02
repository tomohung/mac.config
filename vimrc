" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
call plug#end()

colorscheme codedark

syntax enable
set shiftwidth=2
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set number " show line numbers
set cursorline " highlight current line
filetype indent on " load filetype-specific indnet files
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]
set hlsearch
set incsearch
set autoread

let mapleader=","  " leader is comma

" turn off search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set path+=** " search down into subfolders
