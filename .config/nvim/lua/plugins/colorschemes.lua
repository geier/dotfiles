return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme kanagawa]])
            require("kanagawa").setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
            })
        end,
    },
    { 'gruvbox-community/gruvbox',   lazy = true },
    { 'folke/tokyonight.nvim',       lazy = true },
    { 'catppuccin/nvim',             as = 'catppuccin', lazy = true },
    { 'marko-cerovac/material.nvim', lazy = true },
    { 'sainnhe/sonokai',             lazy = true },
    { 'sainnhe/edge',                lazy = true },
    { 'loctvl842/monokai-pro.nvim',  lazy = true },
    { 'projekt0n/github-nvim-theme', lazy = true },
}
