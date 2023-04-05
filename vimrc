" General {{{
set mouse+=a     " Enable text selection.
set nocompatible " Ensure we're in vim mode.
set shortmess+=c " Don't pass messages to |ins-completion-menu|.

let &t_SI = "\<esc>[5 q" " Beam for insert mode.
let &t_EI = "\<esc>[2 q" " Block for normal mode.
let &t_SR = "\<esc>[3 q" " Underline for replace mode.

" Add directory to path to help with going to files.
set path+=app

" Assume POSIX shell in vim.
let g:is_posix=1
" }}}
" Colors {{{
set t_Co=256

syntax      enable
colorscheme ir_black

highlight ALEError ctermbg=black ctermfg=lightred
highlight ALEInfo ctermbg=black ctermfg=lightred
highlight ALEStyleError ctermbg=black ctermfg=lightred
highlight ALEStyleWarning ctermbg=black ctermfg=lightred
highlight ALEWarning ctermbg=black ctermfg=lightred
highlight Pmenu ctermbg=black ctermfg=grey
highlight PmenuSel ctermbg=black ctermfg=white cterm=bold
highlight CocSearch ctermbg=black ctermfg=white cterm=bold
highlight CocMenuSel ctermbg=blue ctermfg=black

highlight clear SpellBad
highlight SpellBad ctermbg=lightred ctermfg=black

let g:markdown_fenced_languages = ['javascript', 'ruby', 'sh', 'html', 'vim', 'json', 'diff']

let g:any_jump_colors = {
      \"plain_text":         "Operator",
      \"preview":            "Operator",
      \"preview_keyword":    "Operator",
      \"heading_text":       "Keyword",
      \"heading_keyword":    "Operator",
      \"group_text":         "Operator",
      \"group_name":         "Function",
      \"more_button":        "Operator",
      \"more_explain":       "Operator",
      \"result_line_number": "Operator",
      \"result_text":        "Title",
      \"result_path":        "Operator",
      \"help":               "Title"
      \}
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

" Use <TAB> and <S+TAB> for autocomplete.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <CR> to confirm completion.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Hide search highlighting.
map <Leader>h :nohl <CR>

" Opens an edit command with the path of the currently edited file filled in.
map <Leader>e :e +9 <C-R>=escape(expand("%:p:h") . "/", " ") <CR>

" Opens a tab edit command with the path of the currently edited file filled in.
map <Leader>te :tabe +9 <C-R>=escape(expand("%:p:h") . "/", " ") <CR>

" Disable arrow keys in normal and visual mode.
for prefix in ["n", "v"]
  for key in ["<Up>", "<Down>", "<Left>", "<Right>"]
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Toggle spell check.
nmap <silent> <leader>ts :set spell!<CR>

" Copy selection to the clipboard.
vmap <Leader>c "*y

" Shortcuts for CMD+S forwarding support.
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Tab shortcuts.
noremap <Leader>w :quit<CR>
noremap <Leader>[ :tabprevious<CR>
noremap <Leader>] :tabnext<CR>
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

" Shortcuts for the RSpec plug-in.
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>n :TestNearest<CR>
nmap <silent> <Leader>s :TestSuite<CR>
nmap <silent> <Leader>t :TestFile<CR>

" Shortcuts for git commands.
function! GitAddFile()
  call ExecuteCommandInPane("git add " . expand("%:~:."), 0, 0, 3)
  call ExecuteCommandInPane("git status", 0, 0, 3)
endfunction

map <Leader>ga  :call GitAddFile()<CR>
map <Leader>gd  :call ExecuteCommandInPane("git diff", 1, 1)<CR>
map <Leader>gdc :call ExecuteCommandInPane("git diff --cached", 1, 1)<CR>
map <Leader>gp  :call ExecuteCommandInPane("git pull", 0, 0, 3)<CR>
map <Leader>gs  :call ExecuteCommandInPane("git status", 0, 0, 3)<CR>

" Shortcuts for Rails commands.
map <Leader>bo :call ExecuteCommandInPane("bundle outdated", 0, 0, 2)<CR>
map <Leader>r  :call ExecuteCommandInPane("rubocop", 0, 0, 2)<CR>
map <Leader>rc :call ExecuteCommandInPane("bundle exec rake check", 0, 0, 2)<CR>
map <Leader>yo :call ExecuteCommandInPane("yarn outdated", 1, 0, 2)<CR>
" }}}
" Search {{{
set incsearch " Search as characters are entered.
set hlsearch  " Highlight search matches.

" Complete to longest unambiguous, and show a menu.
set completeopt=longest,menu
set wildmode=list:longest,list:full

" Run the fzf plug-in.
nnoremap <leader>p :FZF<CR>

if executable("rg")
  " Use rg over grep for search.
  set grepprg="rg --files --hidden"

  " Use rg in fzf.
  let $FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"
endif

" Customize the default fzf options.
let $FZF_DEFAULT_OPTS="--inline-info --layout=reverse --tabstop=2"

" Swap fzf options to open in tab by default.
let g:fzf_action = {
  \ 'return': 'tabe',
  \ 'ctrl-t': 'e',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p50%,60%' }
endif

" Automatically center search results.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
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
let g:netrw_list_hide  = "^\.bundle\/,"
let g:netrw_list_hide .= "^\.dockerignore,"
let g:netrw_list_hide .= "^\.eslintignore$,"
let g:netrw_list_hide .= "^\.eslintrc$,"
let g:netrw_list_hide .= "^\.jekyll-assets-cache\/,"
let g:netrw_list_hide .= "^\.jekyll-cache\/,"
let g:netrw_list_hide .= "^\.git\/,"
let g:netrw_list_hide .= "^\.gitattributes,"
let g:netrw_list_hide .= "^\.gitignore$,"
let g:netrw_list_hide .= "^\.lighthouseci,"
let g:netrw_list_hide .= "^\.netlify,"
let g:netrw_list_hide .= "^\.pryrc$,"
let g:netrw_list_hide .= "^\.rspec$,"
let g:netrw_list_hide .= "^\.yarn,"
let g:netrw_list_hide .= "^\.yarnrc,"
let g:netrw_list_hide .= "^\.\/$,"
let g:netrw_list_hide .= "^_site\/$,"
let g:netrw_list_hide .= "^coverage\/$,"
let g:netrw_list_hide .= "^Gemfile.lock,"
let g:netrw_list_hide .= "^node_modules\/$,"
let g:netrw_list_hide .= "^tags$,"
let g:netrw_list_hide .= "^tmp\/$,"
let g:netrw_list_hide .= "^\yarn.lock"

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

" Lower the key sequence delay.
set ttimeoutlen=50

" Customize ALE configuration.
let g:ale_fix_on_save = 1
let g:ale_fixers = { "ruby": ["rubocop"] }
let g:ale_ruby_rubocop_executable = "bundle"
let g:ale_virtualtext_cursor = "disabled"

" Disable mapping to not break coc.nvim completion.
let g:endwise_no_mappings = 1

" Only jump to references of the same file type.
let g:any_jump_references_only_for_current_filetype = 1

" Customize the mocha executable and file pattern for vim-test.
let g:test#javascript#mocha#executable = 'bin/mocha'
let g:test#javascript#mocha#file_pattern = 'spec\/javascripts\/.*\.spec\.js$'
" }}}
" Formats {{{
" Enable spell check and set text width for Markdown files.
au BufRead,BufNewFile *.{md,markdown} setlocal spell textwidth=80

" Enable spell check and set text width for git commits.
au FileType gitcommit setlocal spell textwidth=80

" Treat ES6 files as JavaScript.
au BufNewFile,BufRead *.es6 set filetype=javascript
" }}}
" tmux {{{
" Run RSpec in the second pane.
let g:rspec_command = "call ExecuteCommandInPane(\"rspec {spec}\", 0, 0, 2)"

" Automatically rebalance windows on vim resize.
autocmd VimResized * :wincmd =

" Remap NetrwRefresh to allow <C-l> to be used by vim-tmux-navigator.
nmap <leader><leader><leader><leader><leader><leader>l <Plug>NetrwRefresh

" Define function to execute command in specific tmux pane.
function! ExecuteCommandInPane(...)
  if !a:0
    echohl ErrorMsg |
      echo "\rExecuteCommandInPane: No command provided." |
    echohl None

    return 0
  end

  let command = a:1
  let focus   = a:0 < 2 ? 0 : a:2
  let zoom    = a:0 < 3 ? 0 : a:3
  let pane    = a:0 < 4 ? 2 : a:4

  call system("tmux send-keys -t " . pane . " C-c")
  call system("tmux send-keys -t " . pane . " clear Enter")
  call system("tmux send-keys -t " . pane . " " . fnameescape(command) . " Enter")

  if focus
    call system("tmux select-pane -t " . pane)
  end

  if zoom
    call system("tmux resize-pane -t " . pane . " -Z")
  end
endfunction

" Use the custom pane runner in vim-test.
let g:test#custom_strategies = {"pane": function("ExecuteCommandInPane")}
let g:test#strategy = "pane"
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
Plug 'christoomey/vim-tmux-navigator'
Plug 'dockyard/vim-easydir'
Plug 'godlygeek/tabular'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', { 'branch' : 'release' }
Plug 'othree/html5.vim', { 'for' : ['eruby', 'html'] }
Plug 'pangloss/vim-javascript', { 'for' : ['eruby', 'html', 'javascript'] }
Plug 'pechorin/any-jump.vim'
Plug 'slim-template/vim-slim', { 'for' : 'slim' }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise', { 'for' : 'ruby' }
Plug 'tpope/vim-markdown', { 'for' : 'markdown' }
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby', { 'for' : 'ruby' }
Plug 'vim-test/vim-test'
Plug 'w0rp/ale'
Plug 'wsdjeg/vim-fetch'

call plug#end()
" }}}
" {{{ Pasting
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" }}}

" vim:foldmethod=marker:foldlevel=0
