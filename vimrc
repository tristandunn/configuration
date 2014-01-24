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
" }}}
" Layout {{{
set number        " Show line numbers.
set numberwidth=5 " Width of gutter for line numbers.
set lazyredraw    " Redraw only when needed.
set laststatus=2  " Always display status line.
set scrolloff=4   " Vertical line buffer when scrolling.
set noshowmode    " Disable mode in status line.

" Load file specific indent files.
filetype plugin indent on
" }}}
" Search {{{
set incsearch " Search as characters are entered.
set hlsearch  " Highlight search matches.
" }}}
" Shortcuts {{{
let mapleader=" " " Leader is space.

" Quickly escape to move up and down.
inoremap jj <esc>
inoremap kk <esc>

" Duplicate a selection.
vmap D y'>p

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
" }}}
" Backups {{{
set nobackup      " No backup files.
set noswapfile    " No swap files.
set nowritebackup " Don't write backup files.
set viminfo=""    " Disable viminfo.
" }}}
" Miscellaneous {{{
" Hide stupid files.
let g:netrw_list_hide = ".bundle,.git\/$,^\.\/$"
" }}}
" Bundles {{{
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "dockyard/vim-easydir"
Bundle "gmarik/vundle"
Bundle "godlygeek/tabular"
Bundle "othree/html5.vim"
Bundle "pangloss/vim-javascript"
Bundle "tpope/vim-bundler"
Bundle "tpope/vim-endwise"
Bundle "tpope/vim-markdown"
Bundle "tpope/vim-rails"
Bundle "vim-ruby/vim-ruby"

filetype plugin indent on
" }}}

" vim:foldmethod=marker:foldlevel=0
