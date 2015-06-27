" General {{{
set nocompatible  " Ensure we're in vim mode.
" }}}
" Colors {{{
syntax      enable
colorscheme ir_black
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
augroup StripeWhitespace
autocmd BufWritePre * call Preserve("%s/\\s\\+$//e")
augroup END
" }}}
" Layout {{{
set number         " Show line numbers.
set numberwidth=5  " Width of gutter for line numbers.
set relativenumber " Enable relative line numbers.
set lazyredraw     " Redraw only when needed.
set laststatus=2   " Always display status line.
set scrolloff=4    " Vertical line buffer when scrolling.
set noshowmode     " Disable mode in status line.
set ruler          " Show the cursor position all the time.

" Load file specific indent files.
filetype plugin indent on
" }}}
" Search {{{
set incsearch " Search as characters are entered.
set hlsearch  " Highlight search matches.

" Complete to longest unambiguous, and show a menu.
set completeopt=longest,menu
set wildmode=list:longest,list:full
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

" Look a word up in Dictionary.app
nmap <silent> <Leader>d :!open dict://<cword><CR><CR>

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

" Hide stupid files.
let g:netrw_list_hide  = "^\.bundle\/,"
let g:netrw_list_hide .= "^\.capistrano\/,"
let g:netrw_list_hide .= "^\.chef\/,"
let g:netrw_list_hide .= "^\.jekyll-assets-cache\/,"
let g:netrw_list_hide .= "^\.git\/,"
let g:netrw_list_hide .= "^\.sass-cache\/$,"
let g:netrw_list_hide .= "^\.vagrant,"
let g:netrw_list_hide .= "^\.\/$,"
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
" }}}
" Formats {{{
" Enable spell check and set text width for Markdown files.
au BufRead,BufNewFile *.{md,markdown} setlocal spell textwidth=80

" Enable spell check and set text width for git commits.
au FileType gitcommit setlocal spell textwidth=80
" }}}
" Bundles {{{
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dockyard/vim-easydir'
Plug 'godlygeek/tabular'

Plug 'digitaltoad/vim-jade', { 'for' : ['jade'] }
Plug 'othree/html5.vim', { 'for' : ['eruby', 'html'] }
Plug 'pangloss/vim-javascript', { 'for' : ['eruby', 'html', 'javascript'] }
Plug 'robotvert/vim-nginx', { 'for' : 'nginx' }
Plug 'tpope/vim-bundler', { 'for' : 'ruby' }
Plug 'tpope/vim-endwise', { 'for' : 'ruby' }
Plug 'tpope/vim-markdown', { 'for' : 'markdown' }
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby', { 'for' : 'ruby' }
Plug 'wavded/vim-stylus', { 'for' : 'stylus' }

call plug#end()

if has('gui_macvim') && has('gui_running')
  " Disable tool tips.
  set noballooneval
  set balloonexpr=
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
