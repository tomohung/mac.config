set nocompatible              " be iMproved, required
filetype off                  " required

" in order to solve shell: fish problem when using vim
set shell=/bin/bash

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'majutsushi/tagbar'
Plugin 'elixir-lang/vim-elixir'
Plugin 'rizzatti/dash.vim'

"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:ctrlp_show_hidden = 1

nmap <F8> :TagbarToggle<CR>

"lazyredraw make faster when viewing html/haml
set lazyredraw

set background=dark
colorscheme solarized
let g:solarized_termcolors=256
set number
set hlsearch

set encoding=utf-8
set fileencodings=utf-8

set shiftwidth=2
set tabstop=2
set expandtab

set fileformat=unix

set cursorline
set autoread

"for air-line
set laststatus=2

" for vim-ruby
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
