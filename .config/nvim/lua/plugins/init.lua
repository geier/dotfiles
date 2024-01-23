return {
    -- 
    "folke/which-key.nvim",

    -- status column
    'luukvbaal/statuscol.nvim',

    -- display marks
    'kshenoy/vim-signature',

    -- show icons, needs patched font
    'nvim-tree/nvim-web-devicons',

    -- show changed, added and deleted lines in the markers column
    -- using an empty `opts` tells lazy to call the plugins setup()
    {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, opts = { } },

    -- replace the UI for messages, cmdline, popupmenu
    {
        'folke/noice.nvim',
        requires = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify'
        },
        opts = { },
    },

    --------------------
    -- highlight text as in a Word
    'pocco81/high-str.nvim',

    -- undotree
    'mbbill/undotree',

    -- indenting python properly
    { 'hynek/vim-python-pep8-indent', ft = "python" },

    -- javascript and react
    { 'maxmellon/vim-jsx-pretty', ft = "javascript" },

    -- proper folding for python
   'tmhedberg/SimpylFold',  -- can probably me replaced by braceless

    -- text objects for indented languages (python)
    'tweekmonster/braceless.vim',   -- TODO enable

    -- Motions for CamelCase and snake_case
    'bkad/CamelCaseMotion',

    -- easy commenting out of code
    'scrooloose/nerdcommenter',

    -- Table Mode
    'dhruvasagar/vim-table-mode',
    -- TODO
    -- vim.g.table_mode_map_prefix = "<leader>tm",

    -- Showing recently used files when starting neovim
    'mhinz/vim-startify',

    -- wiki functionality for vim
--    use 'vimwiki/vimwiki' --{ 'branch': 'dev' }
    'mattn/calendar-vim',
    --use 'lervag/wiki.vim'
    -- use 'SidOfc/mkdx'
    {
    'bouk/vim-markdown', branch = 'wikilinks', ft = "markdown",
    },

    -- show content of registers on pressing `""`
    { 'gennaro-tedesco/nvim-peekup', keys = {} },

    -- Move current selection up (down) with A-k (A-j)
    'matze/vim-move',  -- does not work on mac os

    -- change/add/delete `sourroundings`
    'tpope/vim-surround',

    -- make some plugins (like vim-surround) repeatable with .
    'tpope/vim-repeat',

    -- semantic highlighter for python code
    --    'numirias/semshi', {'do': ':UpdateRemotePlugins'}

    'tell-k/vim-autopep8',

    -- Better spell checking
    'vigoux/LanguageTool.nvim',

    ------------------------------------------------------------------
    -- LSP and automcomplete
    ------------------------------------------------------------------
    -- everything else can be found in lsp.lua
    -- Pretty list of diagnostics and references
    'folke/trouble.nvim',
    ------------------------------------------------------------------

    'ekickx/clipboard-image.nvim',


    {'akinsho/git-conflict.nvim', config = function()
        require('git-conflict').setup()
    end},

    -- copilot 
    'github/copilot.vim',

    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',

    'nvim-orgmode/orgmode',

    --'romgrk/hologram.nvim'

    -- yaml support, for k8s
    {
      "someone-stole-my-name/yaml-companion.nvim",
      requires = {
          { "neovim/nvim-lspconfig" },
          { "nvim-lua/plenary.nvim" },
          { "nvim-telescope/telescope.nvim" },
      },
      config = function()
        require("telescope").load_extension("yaml_schema")
      end,
      ft = 'yaml',
    }


  }
