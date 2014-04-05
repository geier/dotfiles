" we want Vim, not Vi
 set nocompatible

" vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'

" Plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'thomwiggers/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'scrooloose/nerdcommenter'
Plugin 'davidhalter/jedi-vim'
Plugin 'Lokaltog/powerline'
Plugin 'LaTeX-Box-Team/LaTeX-Box'

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

set showcmd    " display incomplete commands
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

au BufRead,BufNewFile *.ns set filetype=neurosim
au BufRead,BufNewFile *.gp set filetype=gnuplot

"write all files when calling :make
set autowrite

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
"
" Calendar
let g:calendar_monday = 1

cmap w!! %!sudo tee > /dev/null %
" needed for vim outliner
filetype plugin indent on

" vim powerline
set rtp+=/home/cg/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'short'
let g:Powerline_colorscheme = 'solarized'
"nmap P :TagbarToggle<CR>
" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>

au BufRead,BufNewFile *alot.* set filetype=mail
