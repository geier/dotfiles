" vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
"
" showing the git status of lines (modified, new, deleted lines after this line)
Plugin 'airblade/vim-gitgutter'

" git plugin (commiting, blame, diff, etc.)
Plugin 'tpope/vim-fugitive'

" colorschemes
Plugin 'ericbn/vim-colors-solarized'
Plugin 'fcpg/vim-fahrenheit'
Plugin 'iCyMind/NeoSolarized'
Plugin 'joshdick/onedark.vim'
Plugin 'morhetz/gruvbox'
Plugin 'mhartington/oceanic-next'

" syntax checker for various programming languages
"Plugin 'scrooloose/syntastic'
Plugin 'benekastah/neomake'

" indenting python properly
Plugin 'hynek/vim-python-pep8-indent'

" easy commenting out of code
Plugin 'scrooloose/nerdcommenter'

" prettier status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

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
" and for python
Plugin 'davidhalter/jedi-vim'

" fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'

" rst support
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'

" Rust
Plugin 'rust-lang/rust.vim'

Plugin 'mhinz/vim-startify'

Plugin 'dag/vim-fish'

" Make the yanked region apparent!
Plugin 'machakann/vim-highlightedyank'

call vundle#end()
filetype plugin indent on

