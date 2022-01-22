-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- git plugin (commiting, blame, diff, etc.)
	use 'tpope/vim-fugitive'

    -- colorschemes
	use 'gruvbox-community/gruvbox'
    use 'rebelot/kanagawa.nvim'

    -- indenting python properly
	use 'hynek/vim-python-pep8-indent'

    -- proper folding for python
	use 'tmhedberg/SimpylFold'  -- can probably me replaced by braceless

    -- text objects for indented languages (python)
	use 'tweekmonster/braceless.vim'   -- TODO enable

    -- Motions for CamelCase and snake_case
	use 'bkad/CamelCaseMotion'

    -- easy commenting out of code
	use 'scrooloose/nerdcommenter'

    -- prettier status line
    use 'nvim-lualine/lualine.nvim'

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

    -- wiki functionality for vim
	use 'vimwiki/vimwiki' --{ 'branch': 'dev' }

    -- telescope is a fuzzy finder for filenames, their contents and more
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'  -- dependency of telescope
	use 'nvim-lua/popup.nvim'  -- dependency of telescope

    -- integration for neuron
	use 'oberblastmeister/neuron.nvim'

	-- 'majutsushi/tagbar'
    -- alternative to tagbar/ctags
    use 'simrat39/symbols-outline.nvim'

    -- show content of registers on pressing `""`
	use 'gennaro-tedesco/nvim-peekup'

    -- Move current selection up (down) with A-k (A-j)
	use 'matze/vim-move'  -- does not work on mac os

    -- change/add/delete `sourroundings`
	use 'tpope/vim-surround'

    -- make some plugins (like vim-surround) repeatable with .
    use 'tpope/vim-repeat'

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

    -- show changed, added and deleted lines in the markers column
    use {'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }

    -- show which keys can be pressed (after one press)
    use 'folke/which-key.nvim'

    -- lsp signature hint when you type
    use 'ray-x/lsp_signature.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    use 'nvim-orgmode/orgmode'

    -- navigate between tmux and vim splits with the same keybindings
    use { 'alexghergh/nvim-tmux-navigation', config = function()
        require'nvim-tmux-navigation'.setup {
            disable_when_zoomed = true -- defaults to false
        }

        vim.api.nvim_set_keymap('n', "<C-a><Left>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-a><Down>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-a><Up>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-a><Right>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-a><C-a>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-\\>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", { noremap = true, silent = true })
    end
}

end)
