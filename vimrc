" General {{{
set nocompatible  " Ensure we're in vim mode.
set mouse+=a      " Enable text selection.
" }}}
" Colors {{{
set t_Co=256

syntax      enable
colorscheme ir_black

highlight Pmenu ctermbg=lightgrey ctermfg=black
highlight PmenuSel ctermbg=green ctermfg=black cterm=bold

let g:markdown_fenced_languages = ['javascript', 'ruby', 'sh', 'html', 'vim', 'json', 'diff']
" }}}
" Spacing {{{
set tabstop=2      " Two spaces for tab.
set softtabstop=2
set expandtab      " Spaces for tab.
set shiftwidth=2   " Two space indenting.

" Display extra whitespace.
set list listchars=tab:»·,trail:·

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Strip whitespace on save.
augroup StripWhitespace
  autocmd BufWritePre * call Preserve("%s/\\s\\+$//e")
augroup END
" }}}
" Layout {{{
set number         " Show line numbers.
set numberwidth=5  " Width of gutter for line numbers.
set lazyredraw     " Redraw only when needed.
set laststatus=2   " Always display status line.
set scrolloff=4    " Vertical line buffer when scrolling.
set noshowmode     " Disable mode in status line.
set ruler          " Show the cursor position all the time.

" Load file specific indent files.
filetype plugin indent on
" }}}
" Shortcuts {{{
let mapleader=" " " Leader is space.

" Quickly escape to move up and down.
inoremap jj <esc>
inoremap kk <esc>

" Duplicate a selection.
vmap D y'>p

" Maps autocomplete to tab.
imap <Tab> <C-N>

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Hide search highlighting.
map <Leader>h :nohl <CR>

" Opens an edit command with the path of the currently edited file filled in.
map <Leader>e :e +9 <C-R>=escape(expand("%:p:h") . "/", " ") <CR>

" Reload all tabs.
map <Leader>r :tabdo edit \| :tabdo syntax on <CR>

" Opens a tab edit command with the path of the currently edited file filled in.
map <Leader>te :tabe +9 <C-R>=escape(expand("%:p:h") . "/", " ") <CR>

" Disable arrow keys in normal and visual mode.
for prefix in ["n", "v"]
  for key in ["<Up>", "<Down>", "<Left>", "<Right>"]
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Toggle spell check.
nmap <silent> <leader>s :set spell!<CR>

" Add the current file to git.
map <Leader>a :silent :windo !git add %<CR>

" Shortcuts for CMD+S forwarding support.
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Tab shortcuts.
noremap <Leader>1 :tabn 1<CR>
noremap <Leader>2 :tabn 2<CR>
noremap <Leader>3 :tabn 3<CR>
noremap <Leader>4 :tabn 4<CR>
noremap <Leader>5 :tabn 5<CR>
noremap <Leader>6 :tabn 6<CR>
noremap <Leader>7 :tabn 7<CR>
noremap <Leader>8 :tabn 8<CR>
noremap <Leader>9 :tabn 9<CR>
noremap <Leader>0 :tablast<CR>
" }}}
" Search {{{
set incsearch " Search as characters are entered.
set hlsearch  " Highlight search matches.

" Complete to longest unambiguous, and show a menu.
set completeopt=longest,menu
set wildmode=list:longest,list:full

" Run the CtrlP plug-in.
nnoremap <leader>p :CtrlP<CR>

" Configure the CtrlP plug-in.
let g:ctrlp_cache_dir = '/tmp/vim_ctrlp_cache_dir'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }

if executable("ag")
  " Use ag over grep for search.
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }}}
" Backups {{{
set nobackup      " No backup files.
set noswapfile    " No swap files.
set nowritebackup " Don't write backup files.
set viminfo=""    " Disable viminfo.
" }}}
" Miscellaneous {{{
" Case only matters with mixed case expressions.
set ignorecase
set smartcase

" Hide uncommon directories and files.
let g:netrw_list_hide  = "^\.apt-update,"
let g:netrw_list_hide .= "^\.babelrc$,"
let g:netrw_list_hide .= "^\.buildkite\/,"
let g:netrw_list_hide .= "^\.bundle\/,"
let g:netrw_list_hide .= "^\.capistrano\/,"
let g:netrw_list_hide .= "^\.chef\/,"
let g:netrw_list_hide .= "^\.circleci\/,"
let g:netrw_list_hide .= "^\.dockerignore,"
let g:netrw_list_hide .= "^\.eslintignore$,"
let g:netrw_list_hide .= "^\.eslintrc$,"
let g:netrw_list_hide .= "^\.jekyll-assets-cache\/,"
let g:netrw_list_hide .= "^\.git\/,"
let g:netrw_list_hide .= "^\.github\/,"
let g:netrw_list_hide .= "^\.gitignore$,"
let g:netrw_list_hide .= "^\.pryrc$,"
let g:netrw_list_hide .= "^\.rspec$,"
let g:netrw_list_hide .= "^\.sass-cache\/$,"
let g:netrw_list_hide .= "^\.sass-lint.yml$,"
let g:netrw_list_hide .= "^\.slugignore$,"
let g:netrw_list_hide .= "^\.vagrant,"
let g:netrw_list_hide .= "^\.yarnrc,"
let g:netrw_list_hide .= "^\.\/$,"
let g:netrw_list_hide .= "^node_modules\/$,"
let g:netrw_list_hide .= "^tmp\/$"

" Speed up vim-gitgutter.
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Execute a command while preserving the cursor position.
function! Preserve(command)
  let _s=@/
  let l = line(".")
  let c = col(".")

  execute a:command

  let @/=_s
  call cursor(l, c)
endfunction

" Enable per-project .vimrc files.
set exrc

" Disable unsafe commands in local .vimrc files.
set secure

" Customize ALE configuration.
let g:ale_fix_on_save = 1
let g:ale_fixers = { "ruby": ["rubocop"] }
let g:ale_ruby_rubocop_executable = "bundle"
" }}}
" Formats {{{
" Enable spell check and set text width for Markdown files.
au BufRead,BufNewFile *.{md,markdown} setlocal spell textwidth=80

" Enable spell check and set text width for git commits.
au FileType gitcommit setlocal spell textwidth=80

" Treat ES6 files as JavaScript.
au BufNewFile,BufRead *.es6 set filetype=javascript

" UsetThe Silver Searcher for grepping.
if executable('ag')
  " Use ag command over grep command.
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " The ag command is fast enough that CtrlP doesn't need to cache.
  let g:ctrlp_use_caching = 0
endif
" }}}
" Bundles {{{
let g:projectionist_heuristics = {
  \ "app/&spec/": {
    \ "app/*.rb": {"alternate": "spec/{}_spec.rb"},
    \ "spec/*_spec.rb": {"alternate": "app/{}.rb"}
  \ }
\ }

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dockyard/vim-easydir'
Plug 'godlygeek/tabular'
Plug 'w0rp/ale'

Plug 'kchmck/vim-coffee-script', { 'for' : 'coffee' }
Plug 'leafgarland/typescript-vim', { 'for' : 'typescript' }
Plug 'othree/html5.vim', { 'for' : ['eruby', 'html'] }
Plug 'pangloss/vim-javascript', { 'for' : ['eruby', 'html', 'javascript'] }
Plug 'peitalin/vim-jsx-typescript', { 'for' : 'typescript' }
Plug 'rhysd/vim-crystal', { 'for' : 'crystal' }
Plug 'slim-template/vim-slim', { 'for' : 'slim' }
Plug 'tpope/vim-bundler', { 'for' : 'ruby' }
Plug 'tpope/vim-endwise', { 'for' : 'ruby' }
Plug 'tpope/vim-markdown', { 'for' : 'markdown' }
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby', { 'for' : 'ruby' }

call plug#end()
" }}}

" vim:foldmethod=marker:foldlevel=0
