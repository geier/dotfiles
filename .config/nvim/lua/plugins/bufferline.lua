return {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', lazy = true },
    lazy = false,
    config = function()
        require "bufferline".setup({
    options = {
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,

        separator_style = "slant", -- "slant", "thick", "thin" | { 'any', 'any' },
        indicator = {
            -- icon = " ",
            -- style = 'icon',
            style = "icon",
        },
        offsets = {
            {
                filetype = "neo-tree",
                text = "EXPLORER",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "undotree",
                text = "UNDO",
                text_align = "center",
            },
        },
        hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
        },
    },
})
    end
}
