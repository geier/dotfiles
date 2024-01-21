return {
    'stevearc/aerial.nvim',
    keys = {
        {'<leader>a', '<cmd>AerialToggle!<CR>' },
    },
    config = function()
        require('aerial').setup({
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
                vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
            end
        })
  end
}
