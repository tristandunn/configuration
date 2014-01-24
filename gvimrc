" Default window size.
set lines=44
let &columns=143

" Custom font family and size.
set guifont=Droid_Sans_Mono:h16.00

set vb            " No audible bell.
set guioptions-=T " Remove toolbar.
set guioptions+=c " Use console dialogs.
set guioptions-=L " Remove left scrollbar.
set guioptions-=r " Remove right scrollbar.

" Switch between tabs with CMD + N.
map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>
imap <D-1> <ESC>:tabn 1<CR>
imap <D-2> <ESC>:tabn 2<CR>
imap <D-3> <ESC>:tabn 3<CR>
imap <D-4> <ESC>:tabn 4<CR>
imap <D-5> <ESC>:tabn 5<CR>
imap <D-6> <ESC>:tabn 6<CR>
imap <D-7> <ESC>:tabn 7<CR>
imap <D-8> <ESC>:tabn 8<CR>
imap <D-9> <ESC>:tabn 9<CR>
