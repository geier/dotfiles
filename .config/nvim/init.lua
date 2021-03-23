--------------------------------------------------------------------------------
-- Check if Plug is installed and download it if not
--------------------------------------------------------------------------------
local vim_plug_install_path = vim.fn['stdpath']('config') .. '/autoload/plug.vim'

local f = io.open(vim_plug_install_path, 'r')
if f == nil then
    os.execute(('curl -fLo %s --create-dirs %s'):format(
		vim_plug_install_path,
		'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	))
    vim.api.nvim_command('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
else
	f:close()
end

------------
local api = vim.api
local cmd = api.nvim_command

local U = {}

-- Key mapping
function U.map(mode, key, result, opts)
    opts =
        vim.tbl_extend(
        "keep",
        opts or {},
        {
            noremap = true,
            silent = true,
            expr = false
        }
    )

    api.nvim_set_keymap(mode, key, result, opts)
end
-------------
-- Options --
-------------

local global_opts = {
    encoding      = 'utf-8',
    termguicolors = true,

    smarttab      = true,

    ignorecase    = true,
    smartcase     = true,

    splitbelow    = true,
    splitright    = true,

    showmode      = true,

    history       = 5000,
    autowrite     = true,
    undofile      = true,

    updatetime    = 300,
    ttimeoutlen   = 10,
    timeoutlen    = 500,

    title         = true,

    wildmenu      = true,
    wildmode      = 'full',
    hidden        = true,

    hlsearch      = true,
    incsearch     = true,

    -- virtualedit   = 'block',
    backspace     = 'indent,eol,start',

   -- shortmess     = 'filnxtToOIc',

    completeopt   = 'menuone,noinsert,noselect',

    formatoptions = 'jcroql',  -- see `help fo-table` for meaning


}

local win_opts = {
    cursorline = true,
    number     = true,
    foldmethod = 'expr',
    foldexpr   = 'nvim_treesitter#foldexpr()',
    foldenable = true,
}

local buf_opts = {
    autoindent  = true,
    smartindent = true,

    infercase   = true,

    expandtab   = true,

    shiftwidth  = 4,
    softtabstop = 4,
    tabstop     = 4,

    textwidth   = 80,
}

for k, v in pairs(global_opts) do
	vim.o[k] = v
    -- vim.api.nvim_set_option(k, v)
end

for k, v in pairs(buf_opts) do
	vim.o[k] = v
	vim.bo[k] = v
    -- vim.api.nvim_set_option(k, v)
    -- vim.api.nvim_buf_set_option(0, k, v)
end

for k, v in pairs(win_opts) do
	vim.o[k] = v
	vim.wo[k] = v
    -- vim.api.nvim_set_option(k, v)
    -- vim.api.nvim_win_set_option(0, k, v)
end

-------------
-- Plugins --
-------------

local plugins = {
	'airblade/vim-gitgutter',
    -- git plugin (commiting, blame, diff, etc.)
	'tpope/vim-fugitive',
    -- colorschemes
	'ericbn/vim-colors-solarized',
	'fcpg/vim-fahrenheit',
	'iCyMind/NeoSolarized',
	'joshdick/onedark.vim',
	'morhetz/gruvbox',
	'mhartington/oceanic-next',

    -- syntax checker for various programming languages
    -- 'scrooloose/syntastic'
	'benekastah/neomake',

    -- indenting python properly
	'hynek/vim-python-pep8-indent',

    -- proper folding for python
	'tmhedberg/SimpylFold',

    -- text objects for indented languages (python)
	'tweekmonster/braceless.vim',

    -- Motions for CamelCase and snake_case
	'bkad/CamelCaseMotion',

    -- easy commenting out of code
	'scrooloose/nerdcommenter',

    -- prettier status line
	'vim-airline/vim-airline',
	'vim-airline/vim-airline-themes',

    -- lightweight LaTeX plugin
	'LaTeX-Box-Team/LaTeX-Box',

    -- display marks
	'kshenoy/vim-signature',

    -- highlighting for i3-wm's config file
	'PotatoesMaster/i3-vim-syntax',

    -- completion plugin for several languages
	--'Valloric/YouCompleteMe',
    -- and for python
	'davidhalter/jedi-vim',

    -- fuzzy file search
	'scrooloose/nerdtree',
	'Xuyuanp/nerdtree-git-plugin',

    -- rst support
	'Rykka/riv.vim',
	'Rykka/InstantRst',

    -- Table Mode
	'dhruvasagar/vim-table-mode',

    -- Rust
	'rust-lang/rust.vim',

    -- Typescript
	'leafgarland/typescript-vim',

	'mhinz/vim-startify',

	'dag/vim-fish',

    -- Make the yanked region apparent!
	'machakann/vim-highlightedyank',

	'vimwiki/vimwiki', --{ 'branch': 'dev' }

    -- telescope is a fuzzy finder for filenames, their contents and more
	'nvim-telescope/telescope.nvim',
	'nvim-lua/plenary.nvim',  -- dependency of telescope
	'nvim-lua/popup.nvim',  -- dependency of telescope

	'oberblastmeister/neuron.nvim',

	'majutsushi/tagbar',

	'gennaro-tedesco/nvim-peekup',

    -- Move current selection up (down) with A-k (A-j)
	'matze/vim-move',

    -- change/add/delete `sourroundings`
	'tpope/vim-surround',


    -- semantic highlighter for python code
    --	'numirias/semshi', {'do': ':UpdateRemotePlugins'},

	'tell-k/vim-autopep8',

	'junegunn/fzf.vim',
	'BurntSushi/ripgrep',

	--'ihsanturk/neuron.vim',

    -- Better spell checking
	'vigoux/LanguageTool.nvim',
}


local path = vim.fn['stdpath']('data') .. '/plugged'
vim.fn['plug#begin'](path)

for _,p in pairs(plugins) do
    if type(p) == 'table' then
        vim.fn['plug#'](unpack(p))
    else
        vim.fn['plug#'](p)
    end
end

vim.fn['plug#end']()

---------
-- Colors
---------

local theme = 'gruvbox'
local lightline_theme = theme

vim.api.nvim_command('colorscheme ' .. theme)

-------
-- Mappings
-----------

U.map('n', 'Q', 'gq}')  -- don't use ex mode, use Q for formatting 
U.map('n', 'w!!', '%!sudo tee > /dev/null %')
U.map('n', 'Y', 'y$')  -- make Y work as C or D,
-- make ctrl-l remove highlights and re-apply syntax highlighting
U.map('n', '<C-l>', ':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>')
U.map('n', '<Tab>', ':bnext<CR>')
U.map('n', '<S-Tab>', ':bprevious<CR>')



-- switch to next/previous buffer with Tab/shift+Tab
--nnoremap <Tab> :bnext<CR>
--nnoremap <S-Tab> :bprevious<CR>

-- make n and N always go in the same direction
-- nnoremap <expr> n  'Nn'[v:searchforward]
-- nnoremap <expr> N  'nN'[v:searchforward]




-------
-- Telescope
--
-- Find files using Telescope command-line sugar.
--nnoremap <leader>ff <cmd>Telescope find_files<cr>
--nnoremap <leader>fg <cmd>Telescope live_grep<cr>
--nnoremap <leader>fb <cmd>Telescope buffers<cr>
--nnoremap <leader>fh <cmd>Telescope help_tags<cr>
--
---- Using lua functions
--nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

require'neuron'.setup {
    virtual_titles = true,
    mappings = true,
    run = nil, -- function to run when in neuron dir
    neuron_dir = "~/workspace/wiki", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
    leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
}

------------
-- Telescope

local finders = require "telescope.builtin"
local actions = require "telescope.actions"
local sorters = require "telescope.sorters"

require("telescope").setup(
    {
        defaults = {
            prompt_position = "top",
            prompt_prefix = " ❯ ",
            sorting_strategy = "ascending",
            mappings = {
                i = {
                    ["<ESC>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-o>"] = function()
                        return
                    end,
                    ["<TAB>"] = function()
                        return
                    end
                }
            },
            file_sorter = sorters.get_fzy_sorter,
            generic_sorter = sorters.get_fzy_sorter
        }
    }
)


function TelescopeOpen(fn)
    finders[fn]()
end

-- Ctrl-p = fuzzy finder
U.map("n", "<C-P>", "<CMD>lua require('telescope.builtin').find_files()<CR>")
U.map("n", "<leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>")
U.map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>")
U.map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")
U.map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")


----------
-- vimwiki
----------
local g = vim.g
g.vimwiki_map_prefix = '<Leader>e'  -- <Leader>w is taken by CamelMotion
g.vimwiki_list = {{path = '~/workspace/wiki', syntax = 'markdown', ext = '.md'}}
g.vimwiki_global_ext = 0  -- not all .md files are vimwiki files
g.vimwiki_table_mappings = 0  -- we use table mode
g.vimwiki_table_auto_fmt = 0  -- we use table mode
--g.vimwiki_auto_header = 1  -- automatically set header for new files

--------------------------
-- gruvbox (color scheme)
--------------------------
g.gruxbox_italic = 1
g.gruvbox_contrast = 'medium'

------------------------
-- airline (status bar)
------------------------
g.airline_powerline_fonts = 1
g["airline#extensions#tabline#enabled"] = 1
g["airline#extensions#tabline#fnamemod"] = ':t'
g.airline_theme = 'gruvbox'
