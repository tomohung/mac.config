" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

colorscheme codedark

syntax enable
set shiftwidth=2
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set number " show line numbers
" set cursorline " highlight current line
filetype indent on " load filetype-specific indnet files
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]
set hlsearch
set incsearch
set smartcase " case insensitive, only sensitive when first char is capital
set autoread
set ttyfast

let mapleader=","  " leader is comma

" turn off search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set path+=** " search down into subfolders

" set ag with Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" For netrw
let g:netrw_banner = 0 " turn off banner
