 set nocompatible "Vim, not vi

" plugin setup done in extra file
if filereadable(expand("~/.vim/plugins.vim"))
     source ~/.vim/plugins.vim
endif

" put backup, swp, and undo files into central location
if has("unix")
    silent !mkdir -p ~/.vim/{backup,swp,undo}/
endif
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/
set undodir=~/.vim/undo/
set undofile

" auto folds schreiben und laden
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" colours, plugins
syntax enable
if exists("+termguicolors")
    set termguicolors
endif
set background=dark

let g:gruvbox_italic=1
let g:gruvbox_contrast='medium'
:silent! colorscheme gruvbox

" isplay control chars
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

" allow project specific vimrc files
set exrc

" nicer autocompletion
set wildmenu
set wildmode=full

" history? yes please!
set history=5000

set incsearch     " do incremental searching
"set showbreak=>>>\  
if exists('&inccommand')  " use live substitution if available (neovim)
  set inccommand=split
endif

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

" run Neomake when writing a file if it is installed
" as plugins are only loaded after the vimrc is processed,
" if_exists(':Neomake') will always be false if called from within
" the vimrc
function Run_neomake()
    if exists(':Neomake')
        Neomake
    endif
endfunction
autocmd! BufWritePost * call Run_neomake()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


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
let g:airline_theme='gruvbox'

"nmap P :TagbarToggle<CR>
" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>

" alot files are mail
au BufRead,BufNewFile *alot.* set filetype=mail

nnoremap <leader>jd :YcmCompleter GoTo<CR>

" using fish shell doesn't work properly with Vundle
set shell=sh


let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md', }]
