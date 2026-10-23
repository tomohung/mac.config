" Neovim only (requires 0.12+). Space as leader, must be set before any <leader> mapping
let mapleader = " "

" Install vim-plug automatically
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  silent execute '!curl -fLo ' . stdpath('data') . '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'Mofiqul/vscode.nvim' " theme, VSCode dark with treesitter/LSP highlight groups
Plug 'nvim-lualine/lualine.nvim' " status line

" Basic operation
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround' " cs<origin><new>/ds/cst/ys/<v-block>S<new>
Plug 'tpope/vim-repeat' " Use the repeat command (.) with supported plugins
Plug 'tpope/vim-unimpaired' " ]e/ ]x/ ]u/ ]f/ ]n / yo<x> toggles (]q ]b ]<space> are built in)
Plug 'folke/flash.nvim' " s{char}{char} jump / S treesitter select
Plug 'junegunn/vim-easy-align' "vipga= / gaip=
Plug 'andymass/vim-matchup' " better %, matches do..end / if..end

" Tools
Plug 'tpope/vim-fugitive' " :Git (-/p/C-n/U/dp)/:Git blame/:Gdiffsplit/:Gread/:Gwrite
Plug 'tpope/vim-rhubarb' " :GBrowse open code on GitHub
Plug 'lewis6991/gitsigns.nvim' " show git diff in the gutter, stage/reset hunks
Plug 'tpope/vim-dispatch' " asynchronous build and test dispatcher
Plug 'stevearc/aerial.nvim' " symbol outline from LSP/treesitter
Plug 'ibhagwan/fzf-lua' " fuzzy finder for files/grep/LSP
Plug 'vim-test/vim-test' " Run tests <leader>tn <leader>tf <leader>ts <leader>tl
Plug 'tpope/vim-bundler' " :Bopen / gf into gems
Plug 'rizzatti/dash.vim' "<leader>d

" LSP / completion / format
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'mason-org/mason.nvim' " :Mason installs LSP servers / formatters
Plug 'b0o/SchemaStore.nvim' " JSON/YAML schemas
Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }
Plug 'stevearc/conform.nvim'

" Markdown
Plug 'OXY2DEV/markview.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown'] }

" Ruby
Plug 'vim-ruby/vim-ruby'  "]m ]M [m [M ]] [[ [] am/im/aM/iM; better indent than treesitter
Plug 'tpope/vim-endwise' " wisely add end in ruby/elixir and other languages
Plug 'tpope/vim-rails' " :A/:R, :Emodel/:Eview/:Econtroller, :help rails-navigation, :help rails-:Extract

call plug#end()

""" Config
set shiftwidth=2
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set number relativenumber " show line numbers
set cursorline " highlight current line
set signcolumn=yes " keep gutter visible so git/diagnostic signs don't shift text
set showmatch " highlight matching [{()}]
set ignorecase " case insensitive"
set smartcase " case insensitive, only sensitive when first char is capital, and only used when igorenocase is on
set path+=** " :find search down into subfolders
set updatetime=500 " update status like gitsigns by ms
set undofile
set clipboard=unnamed  "copy to clipboard when yank
set foldlevelstart=99 " open files unfolded; zc/zo/za still work with treesitter folds

" reload after save vimrc
autocmd! BufWritePost init.vim,vimrc source $MYVIMRC | redraw
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" auto trim trailing white space; markdown uses two trailing spaces as a line break
function! s:TrimTrailingWhitespace()
  if &filetype ==# 'markdown' | return | endif
  let view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(view)
endfunction
autocmd BufWritePre * call s:TrimTrailingWhitespace()

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

""" Key Mapping
" open vimrc
nnoremap <Leader>vim :exe "tabe" fnameescape(resolve($MYVIMRC))<CR>

" open a new line above when insert mode ; CAUSION: this overwrite default <C-o>
inoremap <C-o> <ESC>O

" insert mode move to begin/end
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" turn off search highlight
nnoremap <Leader>no :<C-u>nohlsearch<CR>
" Switch between the last two files
nnoremap <Leader><Tab> <C-^>
" Explore current directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR><CR>
nnoremap <Leader>E :e.<CR>
" Only keep current window
nnoremap <Leader>on :only<CR>
" Only keep current buffer
nnoremap <silent> <leader>bo :%bd\|e#\|bd#<CR>

" copy current file name (relative/absolute) to system clipboard
" relative path  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>ch :let @*=expand("%:p:h")<CR>

" duplicate the block ending at cursor, only works at the later pair, e.g. }]end
imap <F1> <ESC>V%ygPO<ESC>j
nmap <F1> V%ygPO<ESC>j

" vim-test mappings
nmap <Leader>tn :TestNearest<CR>
nmap zrn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>
nmap zf :TestFile<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tl :TestLast<CR>
nmap zra :TestLast<CR>
nmap <Leader>tv :TestVisit<CR>

nmap zh ^
nmap zl $
vmap zh ^
vmap zl $
nmap zif ddIels<ESC>==
imap zif <ESC>ddIels<ESC>==

nmap <C-J> j^
imap <C-J> <ESC>j^
nmap <C-K> k^
imap <C-K> <ESC>k^

nmap <C-y> yygP<CR>
vmap <C-y> ygP<CR>
imap <C-y> <Esc>yygP<CR>
nmap <A-L> :set rnu!<CR>

" fugitive git bindings
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Git commit -v -q<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gl :Git pull<CR>
" :GBrowse opens through :Browse when defined; fugitive's netrw fallback calls
" netrw#BrowseX with an argument count Neovim 0.12's netrw rejects (E118)
command! -nargs=1 Browse lua vim.ui.open(<q-args>)
" open current line / selection on GitHub (was vim-gh-line)
nnoremap <Leader>gh :.GBrowse<CR>
xnoremap <Leader>gh :GBrowse<CR>

" symbol outline (was tagbar)
nnoremap <Leader>tt :AerialToggle!<CR>

" toggle quickfix window
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

" expand %% as current directory in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Dash
nmap <silent> <leader>d <Plug>DashSearch

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" fzf-lua (was fzf.vim / ack.vim / bufexplorer)
nnoremap <c-p> :FzfLua files<CR>
nnoremap <c-b> :FzfLua buffers<CR>
nnoremap <Leader>fr :FzfLua oldfiles<CR>
nnoremap <Leader>/ :FzfLua live_grep<CR>
nnoremap <Leader>? :FzfLua grep_cword<CR>
xnoremap <Leader>? :<C-u>FzfLua grep_visual<CR>
nnoremap <Leader>fs :FzfLua lsp_document_symbols<CR>
nnoremap <Leader>fS :FzfLua lsp_live_workspace_symbols<CR>
nnoremap <Leader>fd :FzfLua diagnostics_document<CR>
nnoremap <Leader>fD :FzfLua diagnostics_workspace<CR>
nnoremap <Leader>fc :FzfLua git_status<CR>
nnoremap <Leader>fk :FzfLua keymaps<CR>
nnoremap <Leader>fh :FzfLua helptags<CR>
nnoremap <Leader>f. :FzfLua resume<CR>

" markdown
nnoremap <Leader>mv :Markview toggle<CR>
nnoremap <Leader>mp :MarkdownPreviewToggle<CR>

""" Plugin Config
" vim-test make test commands execute using dispatch.vim
let test#strategy = "dispatch"
let test#ruby#rspec#executable = 'rspec'

" ruby-vim indentation styles; normal/indent/outdent
" let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'variable'

" matchup: show off-screen match in a popup instead of the status line
let g:matchup_matchparen_offscreen = {'method': 'popup'}

lua << EOF
require('vscode').setup({})
vim.cmd.colorscheme('vscode')

require('lualine').setup({ options = { theme = 'vscode' } })

require('nvim-autopairs').setup({ check_ts = true })

require('flash').setup({})
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash jump' })
vim.keymap.set('n', 'S', function() require('flash').treesitter() end, { desc = 'Flash treesitter select' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Flash remote' })

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map('n', ']c', function()
      if vim.wo.diff then return vim.cmd.normal({ ']c', bang = true }) end
      gs.nav_hunk('next')
    end, 'Next hunk')
    map('n', '[c', function()
      if vim.wo.diff then return vim.cmd.normal({ '[c', bang = true }) end
      gs.nav_hunk('prev')
    end, 'Prev hunk')
    map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
    map('x', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage selection')
    map('x', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset selection')
    map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
    map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Select hunk')
  end,
})

require('aerial').setup({ backends = { 'lsp', 'treesitter' } })

require('fzf-lua').setup({})

-- Treesitter: parsers + highlight/folds (indent stays with vim-ruby / builtin)
require('nvim-treesitter').install({
  'ruby', 'embedded_template', 'html', 'css', 'javascript', 'json', 'yaml', 'toml',
  'markdown', 'markdown_inline', 'lua', 'vim', 'vimdoc', 'query', 'bash', 'sql',
  'dockerfile', 'diff', 'gitcommit', 'git_config', 'regex', 'elixir',
})
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      -- vim-endwise detects keywords through regex syntax, which treesitter turns off
      if vim.list_contains({ 'ruby', 'eruby', 'elixir', 'vim', 'lua', 'sh' }, args.match) then
        vim.bo[args.buf].syntax = 'ON'
      end
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})

-- Treesitter text objects: af/if function, ac/ic class, ar/ir block (was vim-textobj-rubyblock), aa/ia argument
require('nvim-treesitter-textobjects').setup({ select = { lookahead = true } })
for lhs, capture in pairs({
  af = '@function.outer', ['if'] = '@function.inner',
  ac = '@class.outer', ic = '@class.inner',
  ar = '@block.outer', ir = '@block.inner',
  aa = '@parameter.outer', ia = '@parameter.inner',
}) do
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    require('nvim-treesitter-textobjects.select').select_textobject(capture, 'textobjects')
  end)
end

require('mason').setup()

require('blink.cmp').setup({
  keymap = { preset = 'default' }, -- <C-space> open, <C-n>/<C-p> select, <C-y> accept, <C-e> close
  completion = { documentation = { auto_show = true } },
  signature = { enabled = true },
})

require('conform').setup({
  formatters_by_ft = {
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
  },
  default_format_opts = { lsp_format = 'fallback' }, -- ruby formats through ruby-lsp
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set({ 'n', 'x' }, '<leader>F', function() require('conform').format() end, { desc = 'Format' })

-- LSP. Neovim 0.12 built-in maps: K hover, grn rename, gra code action, grr references,
-- gri implementation, gO document symbols, [d ]d diagnostics, <C-]> definition (via tagfunc)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Line diagnostics' })
vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.lsp.config('ruby_lsp', {
  -- use StandardRB when the project depends on it, otherwise let ruby-lsp detect (RuboCop or none)
  before_init = function(params, config)
    local gemfile = config.root_dir and vim.fs.joinpath(config.root_dir, 'Gemfile')
    if gemfile and vim.fn.filereadable(gemfile) == 1
        and table.concat(vim.fn.readfile(gemfile), '\n'):match('gem%s+["\']standard["\']') then
      params.initializationOptions.formatter = 'standard'
      params.initializationOptions.linters = { 'standard' }
    end
  end,
})
vim.lsp.config('jsonls', {
  settings = { json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } } },
})
vim.lsp.config('yamlls', {
  settings = { yaml = { schemaStore = { enable = false, url = '' }, schemas = require('schemastore').yaml.schemas() } },
})
vim.lsp.enable({ 'ruby_lsp', 'jsonls', 'yamlls', 'marksman' })
EOF

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
