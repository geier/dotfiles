
set shiftwidth=4    " Autoeinrückung: 4 Leerzeichen einrücken zum Zeilenbeginn, sonst tab
set softtabstop=4   " Anzahl der Leerzeichen, die einem Tab entsprechen
set cindent         " Setzt shiftwidth Leerzeichen am Zeilenanfang und tabstop / softtabstop sonst
set expandtab       " Tabs are 4 Spaces and Spaces are Spaces!

set textwidth=0
set wrapmargin=0
set wrap
set linebreak

set formatoptions=t

set nolist
set virtualedit=
set display+=lastline

" make vim show latex symbols as unicode symbols in normal mode
set conceallevel=2
" concealing in lines where the cursor is makes the cursor stutter when moving
"set concealcursor=nvc
let g:tex_conceal="abdgms"  " accents, bold, delimiters, greek, math, sub/superscript

" navigieren wie angezeigt:
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>

