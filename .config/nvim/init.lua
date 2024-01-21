-- TODO get this back into table mode settings
vim.cmd("let g:table_mode_map_prefix = '<leader>tm'")

----------
-- lazy --
---------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

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

    list          = true,
    listchars     = 'tab:▶ ,trail:●,nbsp:⎵',

    -- virtualedit   = 'block',
    backspace     = 'indent,eol,start',

   -- shortmess     = 'filnxtToOIc',

    completeopt   = 'menuone,noselect',

    formatoptions = 'jcroql',  -- see `help fo-table` for meaning

    mouse = 'a', -- sometimes the mouse does help e.g. split resizing

    scrolloff     = 8,


}

local win_opts = {
    cursorline = false,
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
end

for k, v in pairs(buf_opts) do
    vim.o[k] = v
    vim.bo[k] = v
end

for k, v in pairs(win_opts) do
    vim.o[k] = v
    vim.wo[k] = v
end

---------------
-- Autocommands
---------------

-- Save cursor position, folds etc on leaving a buffer
vim.cmd('autocmd BufWinLeave * silent! mkview')
-- and reload on entering it
vim.cmd('autocmd BufWinEnter * silent! loadview')
-- Highlight yanked area for 500ms
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500} ')

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

-----------
-- wiki.vim
-----------
g.wiki_filetypes = {'md'}
g.wiki_link_extension = 'md'
g.wiki_link_target_type = 'md'
g.wiki_root = '~/workspace/wiki/'
g.vimwiki_use_calendar = 0

-------
-- mkdx
-------
g['mkdx#settings'] =  {
    highlight = { enable = 1 },
    links = { conceal = 1 },
}

------------
-- CamelCase
------------
g.camelcasemotion_key = '<leader>'

--------------------------
-- gruvbox (color scheme)
--------------------------
g.gruxbox_italic = 1
g.gruvbox_contrast_dark = 'medium'


-----------
-- Calendar
-----------
g.calendar_keys = { goto_next_month = '<C-Right>', goto_prev_month = '<C-Left>',
                    goto_next_year = '<C-Down>', goto_prev_year = '<C-Up>',
}
g.calendar_monday = 1
g.calendar_diary = '/Users/cg/workspace/wiki/diary'


----------
-- orgmode
----------
require('orgmode').setup({
  org_agenda_files = {'~/org/*', },
  org_default_notes_file = '~/org/refile.org',

  org_todo_keywords = {'TODO', 'WAITING', '|', 'DONE', 'DELEGATED',
    'private',
    'ga', 'internal', 'ca',
    'mbp', 'mo360', 'vabe',
},
  org_todo_keyword_faces = {
    ga = ':foreground #458588 :weight bold',
    internal = ':foreground #458588 :weight bold',
    ca = ':foreground #458588 :weight bold',
    mbp = ':foreground #458588 :weight bold',
    vabe = ':foreground #458588 :weight bold',
    mo360 = ':foreground #458588 :weight bold',
    sales = ':foreground #458588 :weight bold',
    recruiting = ':foreground #458588 :weight bold',
    nerdistan = ':foreground #458588 :weight bold',
    private = ':foreground #458588 :weight bold',
    A = ':foreground #fb4934 :weight bold'
  }
})

require('orgmode').setup_ts_grammar()




------------------
-- require configs
------------------
require "nvim-conf.aerial"
require "nvim-conf.noice"
require "nvim-conf.bufferline"
require "nvim-conf.lsp"
require "nvim-conf.lualine"
require "nvim-conf.neo-tree"
require "nvim-conf.statuscolumn"
require "nvim-conf.telescope"
require "nvim-conf.treesitter"
require "nvim-conf.whichkey"  -- better load it last, also contains most mappings
