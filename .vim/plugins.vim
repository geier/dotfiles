call plug#begin('~/.vim/plugged')

" Plugs
"
" showing the git status of lines (modified, new, deleted lines after this line)
Plug 'airblade/vim-gitgutter'

" git plugin (commiting, blame, diff, etc.)
Plug 'tpope/vim-fugitive'

" colorschemes
Plug 'ericbn/vim-colors-solarized'
Plug 'fcpg/vim-fahrenheit'
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" syntax checker for various programming languages
"Plug 'scrooloose/syntastic'
Plug 'benekastah/neomake'

" indenting python properly
Plug 'hynek/vim-python-pep8-indent'

" proper folding for python
Plug 'tmhedberg/SimpylFold'

" text objects for indented languages (python)
Plug 'tweekmonster/braceless.vim'

" Motions for CamelCase and snake_case
Plug 'bkad/CamelCaseMotion'

" easy commenting out of code
Plug 'scrooloose/nerdcommenter'

" prettier status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" lightweight LaTeX plugin
Plug 'LaTeX-Box-Team/LaTeX-Box'

" display marks
Plug 'kshenoy/vim-signature'

" highlighting for i3-wm's config file
Plug 'PotatoesMaster/i3-vim-syntax'

" nicer editing of table in rst, markdown, etc.
Plug 'godlygeek/tabular'

" completion plugin for several languages
Plug 'Valloric/YouCompleteMe'
" and for python
Plug 'davidhalter/jedi-vim'

" fuzzy file search
Plug 'ctrlpvim/ctrlp.vim'

" rst support
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Rust
Plug 'rust-lang/rust.vim'

Plug 'mhinz/vim-startify'

Plug 'dag/vim-fish'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" nice wrapper around your favorite (installed) grep-like tool
" call `:Grepper` (hit enter), type search pattern
Plug 'mhinz/vim-grepper'

" Move current selection up (down) with A-k (A-j)
Plug 'matze/vim-move'

" change/add/delete `sourroundings`
Plug 'tpope/vim-surround'

call plug#end()
