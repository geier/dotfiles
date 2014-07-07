" we want Vim, not Vi
 set nocompatible

" vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'

" Plugins
"
" showing the git status of lines (modified, new, deleted lines after this line)
Plugin 'airblade/vim-gitgutter'

" git plugin (commiting, blame, diff, etc.)
Plugin 'tpope/vim-fugitive'

" my favorite color scheme
Plugin 'thomwiggers/vim-colors-solarized'

" syntax checker for various programming languages
Plugin 'scrooloose/syntastic'

" indenting python properly
Plugin 'hynek/vim-python-pep8-indent'

" easy commenting out of code
Plugin 'scrooloose/nerdcommenter'

" prettier status line
Plugin 'Lokaltog/powerline'

" lightweight LaTeX plugin
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" display marks
Plugin 'kshenoy/vim-signature'

" highlighting for i3-wm's config file
Plugin 'PotatoesMaster/i3-vim-syntax'

" nicer editing of table in rst, markdown, etc.
Plugin 'godlygeek/tabular'

" completion plugin for several languages
Plugin 'Valloric/YouCompleteMe'

" fuzzy file search
Plugin 'kien/ctrlp.vim'



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
