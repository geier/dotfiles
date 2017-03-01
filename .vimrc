 set nocompatible "Vim, not vi   " in neovim

" plugin setup done in extra file
if filereadable(expand("~/.vim/plugins.vim"))
     source ~/.vim/plugins.vim
endif

" put backup, swp, and undo files into central location {{{
if has("unix")
    silent !mkdir -p ~/.vim/{backup,swp,undo}/
endif
set backupdir=~/.vim/backup/  " in neovim (different location)
set directory=~/.vim/swp/  " in neovim (different location)
set undodir=~/.vim/undo/  " in neovim (different location)
set undofile
"}}}

" auto folds schreiben und laden
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" colours  {{{
syntax enable
if exists("+termguicolors")
    set termguicolors
endif
set background=dark

let g:gruvbox_italic=1
let g:gruvbox_contrast='medium'
:silent! colorscheme gruvbox
"}}}

" general settings {{{
" display control chars
set list listchars=tab:»·,trail:·,nbsp:+  " in neovim (
set showbreak=>>>\

"highlight the cursor line
set cursorline
set modeline
set laststatus=2  " in neovim
" show command in statusline
set showcmd
set statusline=%<[%n]\ %F\ \ Filetype=\%Y\ \ %r\ %1*%m%*%w%=%(Line:\ %l%)%4(%)Column:\ %5(%c%V/%{strlen(getline(line('.')))}%)\ %4(%)%p%%

" numbers
set number

" allow project specific vimrc files
set exrc

" nicer autocompletion
set wildmenu  " in neovim
set wildmode=full

" falten an markern als default
set foldmethod=marker

"write all files when calling :make
set autowrite

" history? yes please!
set history=5000

" don't insert newlines automatically
set textwidth=0

set hlsearch " highlight all search search pattern matches in neovim
set incsearch " do incremental searching  " in neovim

" allow backspacing over everything in insert mode
set backspace=indent,eol,start  " in neovim

" using fish shell doesn't work properly with Vundle, fugitive and probably
" other stuff
set shell=sh

if exists('&inccommand')  " use live substitution if available (neovim)
  set inccommand=split
endif

" ignore pattern for files: ignore that TeX crap
set wildignore+=*.*~,*.acn,*.acr,*.alg,*.aux,*.bbl,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,
set wildignore+=*.glg,*.glo,*.gls,*.ist,*.latexmain,*.log,*.nav,*.nlo,*.out,*.pdf*,
set wildignore+=*.run.xml,*.slg,*.snm,*.syg,*.syi,*.synctex.gz,*.tdo,*.toc,
"}}}

" Filetype specific settings {{{
" alot files are mail
au BufRead,BufNewFile *alot.* set filetype=mail
au BufRead,BufFilePre,BufNewFile *.md set filetype=markdown

autocmd FileType text setlocal textwidth=72
autocmd FileType txt setlocal textwidth=72
autocmd FileType mail setlocal textwidth=72 nonumber
autocmd FileType tex  setlocal textwidth=0 number wrap linebreak nolist
autocmd FileType rst  setlocal textwidth=80
autocmd FileType cpp setlocal ts=4 sw=4 expandtab sts=4
"}}}

" latex plugin stuff {{{
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
" Tex completion on alt+tab
autocmd FileType tex imap <buffer> <M-TAB> <Plug>Tex_Completion
" }}}

" mappings {{{
" Don't use Ex mode, use Q for formatting
map Q gq}
"
"map <C-m> :make

cmap w!! %!sudo tee > /dev/null %

"nmap P :TagbarToggle<CR>
" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>

" switch to next/previous buffer with Tab/shift+Tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
"}}}

" Plugin Configuration {{{
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

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='gruvbox'

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md', }]
let g:vimwiki_global_ext = 0  " not all .md files are vimwiki files
let g:vimwiki_map_prefix = '<Leader>e'


" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_filetype_blacklist = {
	\ 'python': 1,
	\}

" using CamelCaseMotion with leader
call camelcasemotion#CreateMotionMappings('<leader>')
"}}}
