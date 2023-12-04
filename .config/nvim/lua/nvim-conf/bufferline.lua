local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
    vim.notify("failed to load bufferline")
    return
end

require("bufferline").setup{
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
    }
}