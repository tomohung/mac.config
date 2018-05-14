" Install vim-plug automatically
if has('nvim') " for neovim
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else " for vim
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
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
Plug 'easymotion/vim-easymotion' "<leader><leader>w

" Tools
Plug 'mileszs/ack.vim' " :Ack/:Ack!/:AckAdd/:AckFromSearch/:AckFile
Plug 'tpope/vim-fugitive' " :Gstatus(-/p/C-n/U/dp)/:Gblame/:Gdiff/:Gread/:Gwrite
Plug 'airblade/vim-gitgutter' " show git diff in the gutter
Plug 'tpope/vim-dispatch' " asynchronous build and test dispatcher
Plug 'majutsushi/tagbar' " display tags in a winsow
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips' " Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
Plug 'janko-m/vim-test' " Run tests <leader>tn <leader>tf <leader>ts <leader>tl
Plug 'tpope/vim-bundler' " gem install gem-catgs; gem ctags; will generate all tags from gemfile
Plug 'jlanzarotta/bufexplorer' " BufExplorer <leader>be
Plug 'vim-syntastic/syntastic' " syntax checking hacks
Plug 'christoomey/vim-tmux-navigator' " vim-tmux navigation
Plug 'rizzatti/dash.vim' "<leader>d
Plug 'ruanyl/vim-gh-line' " <leader>gh

" Language specific
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elixir-editors/vim-elixir'
Plug 'mattn/emmet-vim' " exapnding abbreviations html

" Ruby
Plug 'vim-ruby/vim-ruby'  "]m ]M [m [M ]] [[ [] am/im/aM/iM
Plug 'tpope/vim-endwise' " wisely add end in ruby/elixir and other languages
Plug 'tpope/vim-rails' " :A/:R, :Emodel/:Eview/:Econtroller, :help rails-navigation, :help rails-:Extract
runtime macros/matchit.vim "extend match, ex: in ruby, begin..end, if..end
Plug 'kana/vim-textobj-user' " dependency for vim-textobj-ruby
Plug 'nelstrom/vim-textobj-rubyblock' " vir/var

call plug#end()

colorscheme codedark

""" Config
syntax enable
filetype plugin indent on " load filetype-specific indnet files and plugin
set shiftwidth=2
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set number " show line numbers
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]
set hlsearch
set incsearch
set ignorecase " case insensitive"
set smartcase " case insensitive, only sensitive when first char is capital, and only used when igorenocase is on
set autoread
set path+=** " :find search down into subfolders
" set noswapfile " no swap file
" set nobackup
set updatetime=500 " update status like git-gutter by ms

autocmd! BufWritePost .vimrc,vimrc source $MYVIMRC | redraw " reload after save vimrc
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" auto trim trailing white space
autocmd BufWritePre *.* :%s/\s\+$//e

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

""" Key Mapping
"space as leader, Spacemacs-stype
let mapleader = " "

" open vimrc
nnoremap <Leader>vim :tabe $MYVIMRC<CR>

" next line when insert mode ; CAUSION: this overwrite default <C-o>
imap <C-o> <ESC>o

" turn off search highlight
nnoremap <Leader>no :<C-u>nohlsearch<CR>
" Switch between the last two files
nnoremap <Leader><Tab> <C-^>
" Ack
nnoremap <Leader>/ :Ack!<Space>
" Explore current directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>E :e.<CR>

" vim-test mappings
map <Leader>tn :TestNearest<CR>
map <Leader>tf :TestFile<CR>
map <Leader>ts :TestSuite<CR>
map <Leader>tl :TestLast<CR>
map <Leader>tv :TestVisit<CR>

" fugitive git bindings
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>gp :Git push<CR>

" tagbar toggle
nmap <Leader>tt :TagbarToggle<CR>

" toggle quickfix window
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

" expand %% as current directory in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Dash
nnoremap <silent> <leader>d <Plug>DashSearch

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

" Ctrl P
let g:ctrlp_show_hidden = 1

" vim-test make test commands execute using dispatch.vim
let test#strategy = "dispatch"
let test#ruby#rspec#executable = 'make rspec'

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" ruby-vim indentation styles; normal/indent/outdent
let g:ruby_indent_access_modifier_style = 'indent'

" UltiSnips Trigger config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

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
