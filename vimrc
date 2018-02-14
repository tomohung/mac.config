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
Plug 'vim-ruby/vim-ruby'  "]m ]M [m [M ]] [[ [] am/im/aM/iM

" Tools
Plug 'mileszs/ack.vim' " :Ack/:Ack!/:AckAdd/:AckFromSearch/:AckFile
Plug 'tpope/vim-fugitive' " :Gstatus(-/p/C-n/U/dp)/:Gblame/:Gdiff/:Gread/:Gwrite
Plug 'tpope/vim-dispatch' " asynchronous build and test dispatcher
Plug 'majutsushi/tagbar' " display tags in a winsow
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'ctrlpvim/ctrlp.vim'

" Language specific
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-endwise' " wisely add end in ruby/elixir and other languages
Plug 'thoughtbot/vim-rspec' " rspec <leader>rf <leader>rs <leader>rl <leader>ra
Plug 'elixir-editors/vim-elixir'
Plug 'godlygeek/tabular' " required by vim-markdown
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
set noswapfile " no swap file
set nobackup

autocmd! BufWritePost .vimrc,vimrc source $MYVIMRC | redraw " reload after save vimrc

""" Key Mapping
"space as leader, Spacemacs-stype
let mapleader = " "

" open vimrc
nnoremap <Leader>vimrc :tabe $MYVIMRC<CR>

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

" fugitive git bindings
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gh :Silent Glog<CR>
nnoremap <Leader>gH :Silent Glog<CR>:set nofoldenable<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>gp :Git push<CR>

" tagbar toggle
nmap <Leader>tt :TagbarToggle<CR>

" toggle quickfix window
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

" shortcut for open buffer list and enter buffer number/filename
nnoremap <Leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

" expand %% as current directory in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

""" Plugin Config
" For netrw
" let g:netrw_banner = 0 " turn off banner

" airline
let g:airline#extensions#tabline#enabled = 1 " turn on tabline for buffers
let g:airline#extensions#tagbar#enabled = 0
" let g:airline_powerline_fonts = 1 " enable powerline special glyph fonts

" set ag with Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" set Dispath for vim-rspec
let g:rspec_command = "Dispatch rspec {spec}"

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
