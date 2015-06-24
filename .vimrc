 set nocompatible "Vim, not vi

" plugin setup done in extra file
if filereadable(expand("~/.vim/plugins"))
	source ~/.vim/plugins
endif

" backups into
if has("unix")
    if !isdirectory(expand("~/tmp/."))
        !mkdir -p ~/tmp/
    endif
endif
set backupdir=~/tmp

" auto folds schreiben und laden
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview


"autocmd VimEnter * echo "Welcome back Christian :)"
autocmd VimLeave * echo "Cya in Hell."

" colours, plugins
syntax enable
set background=dark
colorscheme solarized

" display control chars
set list listchars=tab:»·,trail:·
"highlight the cursor line
set cursorline
" modeline
set modeline
" statusline
set laststatus=2
" show command in statusline
set showcmd
set statusline=%<[%n]\ %F\ \ Filetype=\%Y\ \ %r\ %1*%m%*%w%=%(Line:\ %l%)%4(%)Column:\ %5(%c%V/%{strlen(getline(line('.')))}%)\ %4(%)%p%%

" highlight all search search pattern matches
set hlsearch

" nicer autocompletion
set wildmenu
set wildmode=full

" history? yes please!
set history=5000

set incsearch     " do incremental searching
"set showbreak=>>>\  

" wrap
set textwidth=0
autocmd FileType text setlocal textwidth=72
autocmd FileType txt setlocal textwidth=72
autocmd FileType mail setlocal textwidth=72
autocmd FileType tex  setlocal textwidth=0 number wrap linebreak nolist
autocmd FileType rst  setlocal textwidth=80
autocmd FileType cpp setlocal ts=4 sw=4 expandtab sts=4

" numbers
set number
autocmd FileType mail setlocal nonumber

" falten an markern als default
set foldmethod=marker

"write all files when calling :make
set autowrite
" run Neomake when writing a file
autocmd! BufWritePost * Neomake

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if v:version >= 703
	set undodir=~/.vim/undo " where to save undo histories
	set undofile                " Save undo's after file closes
endif

" latex plugin stuff
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
" Tex completion on alt+tab
autocmd FileType tex imap <buffer> <M-TAB> <Plug>Tex_Completion 

" Don't use Ex mode, use Q for formatting
map Q gq}
" 
"map <C-m> :make

cmap w!! %!sudo tee > /dev/null %

" airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"nmap P :TagbarToggle<CR>
" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>

" alot files are mail
au BufRead,BufNewFile *alot.* set filetype=mail

nnoremap <leader>jd :YcmCompleter GoTo<CR>
