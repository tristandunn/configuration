" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set nobackup
set noswapfile
set nowritebackup
set history=32    " Keep 32 lines of command line history.
set ruler         " Show the cursor position all the time.
set showcmd       " Display incomplete commands.
set incsearch     " Do incremental searching.

" Alternate to escape.
ino jj <esc>

" Disable arrow keys in normal and visual mode.
for prefix in ['n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Switch syntax highlighting on, when the terminal has colors.
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  " Always set autoindenting on.
  set autoindent
endif

" Softtabs, 2 spaces.
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line.
set laststatus=2

" Space is the leader character.
let mapleader = " "

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands.
map <Leader>m :Rmodel
map <Leader>c :Rcontroller
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest

" Hide search highlighting.
map <Leader>h :nohl <CR>

" Opens an edit command with the path of the currently edited file filled in.
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in.
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command.
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Maps autocomplete to tab.
imap <Tab> <C-N>

" Duplicate a selection.
" Visual mode: D
vmap D y'>p

" No Help, please.
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name.
imap <C-F> <C-R>=expand("%")<CR>

" Display extra whitespace.
set list listchars=tab:»·,trail:·

" Edit routes.
command! Rroutes :e config/routes.rb
command! RTroutes :tabe config/routes.rb

" Color scheme.
colorscheme ir_black
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers.
set number
set numberwidth=5

" Snippets are activated by Shift+Tab.
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options.
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full

" Case only matters with mixed case expressions.
set ignorecase
set smartcase

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Disable viminfo.
:set viminfo=""
