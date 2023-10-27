local whichkey_status_ok, wk = pcall(require, "which-key")
if not whichkey_status_ok then
    vim.notify("failed to load whichkey")
    return
end

-------------
-- Which key
-------------
require("which-key").setup {}

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
--vim.cmd('autocmd FileType * lua setKeybinds()')

-----------
-- Mappings
-----------

-- normal mode
wk.register({
    ["Q"] = { "gq}", "Format until end of paragraph" },
    ["Y"] = { "y$", "Yank until end of line" },
    ["<Tab>"] = { ":bnext<CR>", "Switch to next buffer" },
    ["<S-Tab>"] = { ":bprevious<CR>", "Switch to previous buffer" },
    ["<C-q>"] = { 'a<C-r>=strftime("%Y-%m-%d")<CR><Esc>', "Insert current date"},
    ["<C-h>"] = { ":WhichKey<CR>", "Run Which-Key" },
    ["<C-l>"] = {
        ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>:NoiceDismiss<CR>", " ..."
    },
})

-- insert mode
wk.register({
    ["<C-q>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', "Insert current date" },
}, {mode='i'})

-- command mode
wk.register({
    ["<C-q>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', "Insert current date" },
    ["w!!"] = { "%!sudo tee > /dev/null %", "Write with sudo" },  -- not worrking?
}, {mode='c'})

-- make n and N always go in the same direction
-- nnoremap <expr> n  'Nn'[v:searchforward]
-- nnoremap <expr> N  'nN'[v:searchforward]
