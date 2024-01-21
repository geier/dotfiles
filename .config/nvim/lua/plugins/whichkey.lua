return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        wk = require("which-key")
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
        }, { prefix = '<leader>' })

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
                }, { prefix = '<leader>' })
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
            ["<C-q>"] = { 'a<C-r>=strftime("%Y-%m-%d")<CR><Esc>', "Insert current date" },
            ["<C-h>"] = { ":WhichKey<CR>", "Run Which-Key" },
            ["<C-l>"] = {
                ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>:NoiceDismiss<CR>", " ..."
            },
        })

        -- insert mode
        wk.register({
            ["<C-q>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', "Insert current date" },
        }, { mode = 'i' })

        -- command mode
        wk.register({
            ["<C-q>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', "Insert current date" },
            ["w!!"] = { "%!sudo tee > /dev/null %", "Write with sudo" }, -- not worrking?
        }, { mode = 'c' })
    end
}
