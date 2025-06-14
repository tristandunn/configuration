" ir_black color scheme via http://blog.infinitered.com

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "ir_black"

" =============================================================================
" UI Elements
" =============================================================================

hi Cursor          guifg=black   guibg=white   gui=NONE      ctermfg=black    ctermbg=white    cterm=reverse
hi CursorLine      guifg=NONE    guibg=#121212 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=BOLD
hi CursorColumn    guifg=NONE    guibg=#121212 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=BOLD
hi LineNr          guifg=#3D3D3D guibg=black   gui=NONE      ctermfg=darkgray ctermbg=NONE     cterm=NONE
hi MatchParen      guifg=#f6f3e8 guibg=#857b6f gui=BOLD      ctermfg=white    ctermbg=darkgray cterm=NONE
hi NonText         guifg=#070707 guibg=black   gui=NONE      ctermfg=black    ctermbg=NONE     cterm=NONE
hi Normal          guifg=#f6f3e8 guibg=black   gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=NONE
hi Visual          guifg=NONE    guibg=#262D51 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=REVERSE
hi VisualNOS       guifg=NONE    guibg=#262D51 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=REVERSE
hi Search          guifg=NONE    guibg=#2F2F00 gui=underline ctermfg=NONE     ctermbg=NONE     cterm=underline
hi IncSearch       guifg=black   guibg=yellow  gui=NONE      ctermfg=black    ctermbg=yellow   cterm=NONE
hi StatusLine      guifg=#CCCCCC guibg=#202020 gui=italic    ctermfg=white    ctermbg=darkgray cterm=NONE
hi StatusLineNC    guifg=black   guibg=#202020 gui=NONE      ctermfg=blue     ctermbg=darkgray cterm=NONE
hi VertSplit       guifg=#202020 guibg=#202020 gui=NONE      ctermfg=darkgray ctermbg=darkgray cterm=NONE
hi Title           guifg=#f6f3e8 guibg=NONE    gui=bold      ctermfg=NONE     ctermbg=NONE     cterm=NONE
hi TabLine         guifg=white   guibg=grey    gui=NONE      ctermfg=white    ctermbg=grey     cterm=NONE
hi TabLineSel      guifg=white   guibg=black   gui=NONE      ctermfg=white    ctermbg=black    cterm=NONE
hi WildMenu        guifg=green   guibg=yellow  gui=NONE      ctermfg=black    ctermbg=yellow   cterm=NONE
hi ModeMsg         guifg=black   guibg=#C6C5FE gui=BOLD      ctermfg=black    ctermbg=cyan     cterm=BOLD
hi ErrorMsg        guifg=white   guibg=#FF6C60 gui=BOLD      ctermfg=white    ctermbg=red      cterm=NONE
hi WarningMsg      guifg=white   guibg=#FF6C60 gui=BOLD      ctermfg=white    ctermbg=red      cterm=NONE
hi Error           guifg=NONE    guibg=NONE    gui=undercurl ctermfg=white    ctermbg=red      cterm=NONE guisp=#FF6C60
hi Folded          guifg=#a0a8b0 guibg=#384048 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=NONE
hi LongLineWarning guifg=NONE    guibg=#371F1C gui=underline ctermfg=NONE     ctermbg=NONE     cterm=underline
hi Pmenu           guifg=#f6f3e8 guibg=#444444 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=NONE
hi PmenuSel        guifg=#000000 guibg=#cae682 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=NONE
hi PmenuSbar       guifg=black   guibg=white   gui=NONE      ctermfg=black    ctermbg=white    cterm=NONE
hi SpecialKey      guifg=#808080 guibg=#343434 gui=NONE      ctermfg=NONE     ctermbg=NONE     cterm=NONE

" =============================================================================
" Syntax Highlighting
" =============================================================================

hi Comment     guifg=#7C7C7C guibg=NONE gui=NONE ctermfg=darkgray  ctermbg=NONE cterm=NONE
hi String      guifg=#A8FF60 guibg=NONE gui=NONE ctermfg=green     ctermbg=NONE cterm=NONE
hi Number      guifg=#FF73FD guibg=NONE gui=NONE ctermfg=magenta   ctermbg=NONE cterm=NONE
hi Constant    guifg=#99CC99 guibg=NONE gui=NONE ctermfg=cyan      ctermbg=NONE cterm=NONE
hi Identifier  guifg=#C6C5FE guibg=NONE gui=NONE ctermfg=cyan      ctermbg=NONE cterm=NONE
hi Function    guifg=#FFD2A7 guibg=NONE gui=NONE ctermfg=brown     ctermbg=NONE cterm=NONE
hi Statement   guifg=#6699CC guibg=NONE gui=NONE ctermfg=lightblue ctermbg=NONE cterm=NONE
hi Keyword     guifg=#96CBFE guibg=NONE gui=NONE ctermfg=blue      ctermbg=NONE cterm=NONE
hi Conditional guifg=#6699CC guibg=NONE gui=NONE ctermfg=blue      ctermbg=NONE cterm=NONE
hi Operator    guifg=white   guibg=NONE gui=NONE ctermfg=white     ctermbg=NONE cterm=NONE
hi Delimiter   guifg=#00A0A0 guibg=NONE gui=NONE ctermfg=cyan      ctermbg=NONE cterm=NONE
hi Type        guifg=#FFFFB6 guibg=NONE gui=NONE ctermfg=yellow    ctermbg=NONE cterm=NONE
hi Special     guifg=#E18964 guibg=NONE gui=NONE ctermfg=white     ctermbg=NONE cterm=NONE
hi Todo        guifg=#8f8f8f guibg=NONE gui=NONE ctermfg=red       ctermbg=NONE cterm=NONE
hi PreProc     guifg=#96CBFE guibg=NONE gui=NONE ctermfg=blue      ctermbg=NONE cterm=NONE

" =============================================================================
" Language-specific Highlighting
" =============================================================================

" Ruby
hi link rubyClass            Keyword
hi link rubyModule           Keyword
hi link rubyKeyword          Keyword
hi link rubyOperator         Operator
hi link rubyIdentifier       Identifier
hi link rubyInstanceVariable Identifier
hi link rubyGlobalVariable   Identifier
hi link rubyClassVariable    Identifier
hi link rubyConstant         Type

hi rubyRegexp                 guifg=#B18A3D guibg=NONE gui=NONE ctermfg=brown      ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter        guifg=#FF8000 guibg=NONE gui=NONE ctermfg=brown      ctermbg=NONE cterm=NONE
hi rubyEscape                 guifg=white   guibg=NONE gui=NONE ctermfg=cyan       ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#00A0A0 guibg=NONE gui=NONE ctermfg=blue       ctermbg=NONE cterm=NONE
hi rubyControl                guifg=#6699CC guibg=NONE gui=NONE ctermfg=blue       ctermbg=NONE cterm=NONE
hi rubyStringDelimiter        guifg=#336633 guibg=NONE gui=NONE ctermfg=lightgreen ctermbg=NONE cterm=NONE

" Java
hi link javaScopeDecl          Identifier
hi link javaCommentTitle       javaDocSeeTag
hi link javaDocTags            javaDocSeeTag
hi link javaDocParam           javaDocSeeTag
hi link javaDocSeeTagParam     javaDocSeeTag

hi javaDocSeeTag guifg=#CCCCCC guibg=NONE gui=NONE ctermfg=darkgray ctermbg=NONE cterm=NONE

" XML / HTML
hi link xmlTag      Keyword
hi link xmlTagName  Conditional
hi link xmlEndTag   Identifier
hi link htmlTag     Keyword
hi link htmlTagName Conditional
hi link htmlEndTag  Identifier

" JavaScript
hi link javaScriptNumber Number

" =============================================================================
" Syntax Group Linking
" =============================================================================

hi link Character      Constant
hi link Boolean        Constant
hi link Float          Number
hi link Repeat         Statement
hi link Label          Statement
hi link Exception      Statement
hi link Include        PreProc
hi link Define         PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc
hi link StorageClass   Type
hi link Structure      Type
hi link Typedef        Type
hi link Tag            Special
hi link SpecialChar    Special
hi link SpecialComment Special
hi link Debug          Special

" =============================================================================
" Spelling
" =============================================================================

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellLocal
highlight clear SpellRare

highlight SpellBad   guibg=lightred  guifg=black
highlight SpellCap   guibg=lightblue guifg=black
highlight SpellLocal guibg=yellow    guifg=black
highlight SpellRare  guibg=red       guifg=black

" =============================================================================
" Plugins / Misc
" =============================================================================

highlight GitSignsAdd    guibg=black gui=NONE ctermfg=green  ctermbg=NONE cterm=NONE
highlight GitSignsChange guibg=black gui=NONE ctermfg=yellow ctermbg=NONE cterm=NONE
highlight GitSignsDelete guibg=black gui=NONE ctermfg=red    ctermbg=NONE cterm=NONE
highlight SignColumn     guibg=black gui=NONE ctermfg=NONE   ctermbg=NONE cterm=NONE

" ============================================================================
" Floating Windows
" =============================================================================

hi! link NormalFloat Normal

hi NormalFloat guibg=#151515 guifg=#f6f3e8
hi FloatBorder guifg=#7C7C7C guibg=black
hi FloatTitle  guifg=#FFD2A7 guibg=black   gui=bold
hi FloatCode   guifg=#00A0A0 gui=NONE

hi link FloatKeyword        Keyword
hi link FloatString         String
hi link FloatNumber         Number
hi link FloatDiagnosticWarn WarningMsg
hi link FloatDiagnosticHint ModeMsg
