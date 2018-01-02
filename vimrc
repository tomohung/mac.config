syntax enable
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set number " show line numbers
set cursorline " highlight current line
filetype indent on " load filetype-specific indnet files
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]
set hlsearch
set incsearch

let mapleader=","  " leader is comma

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

