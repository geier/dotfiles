-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
    -- git plugin (commiting, blame, diff, etc.)
	use 'tpope/vim-fugitive'

	--'airblade/vim-gitgutter'

    -- colorschemes
	use 'gruvbox-community/gruvbox'

    -- syntax checker for various programming languages
    -- 'scrooloose/syntastic'
	--'benekastah/neomake'

    -- indenting python properly
	use 'hynek/vim-python-pep8-indent'

    -- proper folding for python
	use 'tmhedberg/SimpylFold'

    -- text objects for indented languages (python)
	use 'tweekmonster/braceless.vim'

    -- Motions for CamelCase and snake_case
	use 'bkad/CamelCaseMotion'

    -- easy commenting out of code
	use 'scrooloose/nerdcommenter'

    -- prettier status line
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'

    -- lightweight LaTeX plugin
	--'LaTeX-Box-Team/LaTeX-Box'

    -- display marks
	use 'kshenoy/vim-signature'

    -- highlighting for i3-wm's config file
	use 'PotatoesMaster/i3-vim-syntax'

    -- File Browser
	use 'scrooloose/nerdtree'
	use 'Xuyuanp/nerdtree-git-plugin'

    -- rst support
	use 'Rykka/riv.vim'
	use 'Rykka/InstantRst'

    -- Table Mode
	use 'dhruvasagar/vim-table-mode'

    -- Rust
	use 'rust-lang/rust.vim'

    -- Typescript
	use 'leafgarland/typescript-vim'

    -- Showing recently used files when starting neovim
	use 'mhinz/vim-startify'

	use 'dag/vim-fish'

    -- Make the yanked region apparent!
	use 'machakann/vim-highlightedyank'

    -- wiki functionality for vim
	use 'vimwiki/vimwiki' --{ 'branch': 'dev' }

    -- telescope is a fuzzy finder for filenames, their contents and more
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'  -- dependency of telescope
	use 'nvim-lua/popup.nvim'  -- dependency of telescope

    -- integration for neuron
	use 'oberblastmeister/neuron.nvim'

	--'majutsushi/tagbar'

    -- show content of registers on pressing `""`
	use 'gennaro-tedesco/nvim-peekup'

    -- Move current selection up (down) with A-k (A-j)
	use 'matze/vim-move'  -- does not work on mac os

    -- change/add/delete `sourroundings`
	use 'tpope/vim-surround'


    -- semantic highlighter for python code
    --	'numirias/semshi', {'do': ':UpdateRemotePlugins'}

	use 'tell-k/vim-autopep8'

    -- Better spell checking
	use 'vigoux/LanguageTool.nvim'

    -- NeoVim lsp config
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'

    -- Pretty list of diagnostics and references
    use 'folke/trouble.nvim'

    --'~/workspace/clipboard-image.nvim/'
    use 'kyazdani42/nvim-web-devicons'


    use 'lewis6991/gitsigns.nvim'

    use 'folke/which-key.nvim'

    -- lsp signature hint when you type 
    use 'ray-x/lsp_signature.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    use 'kristijanhusak/orgmode.nvim'


end)
