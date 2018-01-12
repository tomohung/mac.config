" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark' " theme
Plug 'vim-airline/vim-airline' " better status bar

" Basic operation
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary' " gc/gcc
Plug 'tpope/vim-surround' " cs<origin><new>/ds/cst/ys/<v-block>S<new>
Plug 'tpope/vim-repeat' " Use the repeat command (.) with supported plugins
Plug 'tpope/vim-unimpaired' " ]q/ ]b/ ]<space>/ ]e/ ]x/ ]u/ ]f/ ]n

" Tools
Plug 'mileszs/ack.vim' " :Ack/:Ack!/:AckAdd/:AckFromSearch/:AckFile
Plug 'tpope/vim-fugitive' " :Gstatus(-/p/C-n/U/dp)/:Gblame/:Gdiff/:Gread/:Gwrite

" Language specific
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-endwise' " wisely add end in ruby/elixir and other languages
Plug 'thoughtbot/vim-rspec' " rspec <leader>rf <leader>rs <leader>rl <leader>ra
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
nnoremap <Leader><Leader> :<C-u>nohlsearch<CR>
" Switch between the last two files
nnoremap <Leader><Tab> <C-^>
" Ack
nnoremap <Leader>/ :Ack!<Space>
" RSpec.vim mappings
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" toggle quickfix window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

" shortcut for open buffer list and enter buffer number/filename
nnoremap <Leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

""" Plugin Config
" For netrw
" let g:netrw_banner = 0 " turn off banner

" airline
let g:airline#extensions#tabline#enabled = 1 " turn on tabline for buffers
" let g:airline_powerline_fonts = 1 " enable powerline special glyph fonts

" set ag with Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

