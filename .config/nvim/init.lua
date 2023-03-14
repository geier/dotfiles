local fn = vim.fn
local cmd = vim.cmd

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('plugins')
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

----------------------
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

    list          = true,
    listchars     = 'tab:▶ ,trail:●,nbsp:⎵',

    -- virtualedit   = 'block',
    backspace     = 'indent,eol,start',

   -- shortmess     = 'filnxtToOIc',

    completeopt   = 'menuone,noselect',

    formatoptions = 'jcroql',  -- see `help fo-table` for meaning

    mouse = 'a', -- sometimes the mouse does help e.g. split resizing


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

---------
-- Colors
---------

local theme = 'kanagawa'
local lightline_theme = theme

vim.api.nvim_command('colorscheme ' .. theme)

---------------
-- Autocommands
---------------

-- Save cursor position, folds etc on leaving a buffer
vim.cmd('autocmd BufWinLeave * silent! mkview')
-- and reload on entering it
vim.cmd('autocmd BufWinEnter * silent! loadview')

-----------
-- Mappings
-----------

U.map('n', 'Q', 'gq}')  -- don't use ex mode, use Q for formatting
U.map('n', 'w!!', '%!sudo tee > /dev/null %')
U.map('n', 'Y', 'y$')  -- make Y work as C or D
-- make ctrl-l remove highlights and re-apply syntax highlighting
U.map('n', '<C-l>', ':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>')
-- switch to next/previous buffer with Tab/shift+Tab
U.map('n', '<Tab>', ':bnext<CR>')
U.map('n', '<S-Tab>', ':bprevious<CR>')

U.map('n', '<C-q>', 'a<C-R>=strftime("%Y-%m-%d")<CR><Esc>')
U.map('i', '<C-q>', '<C-R>=strftime("%Y-%m-%d")<CR>')
U.map('c', '<C-q>', '<C-R>=strftime("%Y-%m-%d")<CR>')

-- make n and N always go in the same direction
-- nnoremap <expr> n  'Nn'[v:searchforward]
-- nnoremap <expr> N  'nN'[v:searchforward]


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
local g = vim.g
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


-------------------------
-- Calendar
-------------------------
g.calendar_keys = { goto_next_month = '<C-Right>', goto_prev_month = '<C-Left>',
                    goto_next_year = '<C-Down>', goto_prev_year = '<C-Up>',
}
g.calendar_monday = 1
g.calendar_diary = '/Users/cg/workspace/wiki/diary'


------------------------
-- airline (status bar)
------------------------
--g.airline_powerline_fonts = 1
--g["airline#extensions#tabline#enabled"] = 1
--g["airline#extensions#tabline#fnamemod"] = ':t'
--g.airline_theme = 'gruvbox'

------------
-- lspconfig
------------
require'lspconfig'.pyright.setup{}
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local function preview_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

----------
---- compe
----------
--require'compe'.setup {
--  enabled = true;
--  autocomplete = false;
--  debug = false;
--  min_length = 1;
--  preselect = 'enable';
--  throttle_time = 80;
--  source_timeout = 200;
--  incomplete_delay = 400;
--  max_abbr_width = 100;
--  max_kind_width = 100;
--  max_menu_width = 100;
--  documentation = true;
--
--  source = {
--    path = true;
--    buffer = true;
--    calc = true;
--    nvim_lsp = true;
--    nvim_lua = true;
--    vsnip = false;
--    ultisnips = false;
--    orgmode = true;
--  };
--}

--local function keymap(k,m) vim.api.nvim_set_keymap('i', k, m, {noremap=true, silent=true, expr=true}) end
--keymap('<C-Space>', 'compe#complete()')


----------
-- lualine
----------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      lualine_a = {'buffers'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
  extensions = {}
}

-------------
-- Which key
-------------
require("which-key").setup {
  }
local wk = require('which-key')
wk.register({
    o = {
        a = "orgmode agenda prompt",
        c = "orgmode capture prompt",
    },
    c = 'NERD Commenter',
    w = 'vimwiki',
    t = 'tablemode',
    h = 'gitsigns',
    f = 'telecsope',
}, {prefix = '<leader>' })

vim.cmd('autocmd FileType * lua setKeybinds()')
function setKeybinds()
    local fileTy = vim.api.nvim_buf_get_option(0, "filetype")

    if fileTy == 'org' then
        wk.register({
            o = {
                a = 'orgmode agenda',
                r = 'Refile current headline to destination',
                o = 'Open hyperlink under cursor',
                t = 'Set tags on current headline',
                A = 'Toggle "Archive" tag on current headline',
                e = 'Open export options',
                K = 'Move current headline + its content up by one headline',
                J = 'Move current headline + its content down by one headline',
             -- $ = 'Archive current headline to archive location',
            },
        }, {prefix = '<leader>'})
    end
end

---------
-- bug fix for neovim <0.5 release
---------
--
-- Neovim is trying to Automatically detect terminal background and set bg=dark
-- or bg=light, only occurs for me on Mac OS in tmux
-- This leads to nvim opening a file and changing the first character to g and
-- starts entering a command as if from one types :0000/2b2b/3636^G from normal
-- mode.
--
-- This is a know issue, see https://github.com/neovim/neovim/issues/11393
--vim.cmd('cnoremap 3636 <c-u>undo<CR>')

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


local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}


------------------
-- require configs
------------------
require "nvim-conf.cmp"
require "nvim-conf.nvim-tree"
require "nvim-conf.telescope"
