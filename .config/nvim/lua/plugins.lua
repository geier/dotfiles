-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Packer not found")
    return
end


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

    -- javascript and react
    use 'maxmellon/vim-jsx-pretty'

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

    -- File Browser
    use {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        }
      }

    -- Table Mode
    use 'dhruvasagar/vim-table-mode'
    vim.g.table_mode_map_prefix = "<leader>tm",

    -- Typescript
    use 'leafgarland/typescript-vim'

    -- Showing recently used files when starting neovim
    use 'mhinz/vim-startify'

    -- wiki functionality for vim
    use 'vimwiki/vimwiki' --{ 'branch': 'dev' }
    use 'mattn/calendar-vim'
    --use 'lervag/wiki.vim'
    -- use 'SidOfc/mkdx'
    use {
    'bouk/vim-markdown', branch = 'wikilinks',
    }

    -- telescope is a fuzzy finder for filenames, their contents and more
    use 'nvim-lua/plenary.nvim'  -- dependency of telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- 'majutsushi/tagbar'
    -- alternative to tagbar/ctags
    use 'simrat39/symbols-outline.nvim'
    use 'stevearc/aerial.nvim'

    -- show content of registers on pressing `""`
    use 'gennaro-tedesco/nvim-peekup'

    -- Move current selection up (down) with A-k (A-j)
    use 'matze/vim-move'  -- does not work on mac os

    -- change/add/delete `sourroundings`
    use 'tpope/vim-surround'

    -- make some plugins (like vim-surround) repeatable with .
    use 'tpope/vim-repeat'

    -- semantic highlighter for python code
    --    'numirias/semshi', {'do': ':UpdateRemotePlugins'}

    use 'tell-k/vim-autopep8'

    -- Better spell checking
    use 'vigoux/LanguageTool.nvim'

    ------------------------------------------------------------------
    -- LSP and automcomplete
    ------------------------------------------------------------------
    -- NeoVim lsp config
    use 'neovim/nvim-lspconfig'

    use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })

    -- lsp signature hint when you type
    use 'ray-x/lsp_signature.nvim'
    require "lsp_signature".setup({})
    -- Pretty list of diagnostics and references
    use 'folke/trouble.nvim'

    -- mason
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    })
    ------------------------------------------------------------------

    use 'ekickx/clipboard-image.nvim'

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

    use {'akinsho/git-conflict.nvim', config = function()
        require('git-conflict').setup()
    end}

    -- show which keys can be pressed (after one press)
    use 'folke/which-key.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    use 'nvim-orgmode/orgmode'

    use 'romgrk/hologram.nvim'

    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

    -- yaml support, for k8s
    use {
      "someone-stole-my-name/yaml-companion.nvim",
      requires = {
          { "neovim/nvim-lspconfig" },
          { "nvim-lua/plenary.nvim" },
          { "nvim-telescope/telescope.nvim" },
      },
      config = function()
        require("telescope").load_extension("yaml_schema")
      end,
    }

end)
