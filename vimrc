" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline' " better status bar

" Basic operation
Plug 'mileszs/ack.vim' " :Ack/:Ack!/:AckAdd/:AddFromSearch/:AckFile
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary' " gc/gcc
Plug 'tpope/vim-surround' " cs<origin><new> ds/cst/ys <v-block>S<new>
Plug 'tpope/vim-repeat' " Use the repeat command (.) with supported plugins

Plug 'tpope/vim-fugitive' " Git wrapper
" Language specific
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-endwise' "wisely add end in ruby/elixir and other languages
call plug#end()

colorscheme codedark

""" Config
syntax enable
filetype plugin indent on " load filetype-specific indnet files and plugin
set shiftwidth=2
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set number " show line numbers
" set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]
set hlsearch
set incsearch
set ignorecase " case insensitive"
set smartcase " case insensitive, only sensitive when first char is capital, and only used when igorenocase is on
set autoread
set path+=** " :find search down into subfolders

""" Key Mapping
"space as leader, Spacemacs-stype
let mapleader = " "

" turn off search highlight
nnoremap <C-l> :<C-u>nohlsearch<CR>
" Switch between the last two files
nnoremap <Leader><Tab> <C-^>
" Ack
nnoremap <Leader>/ :Ack!<Space>

""" Plugin Config
" For netrw
" let g:netrw_banner = 0 " turn off banner

" airline
let g:airline#extensions#tabline#enabled = 1 " turn on tabline for buffers

" set ag with Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

