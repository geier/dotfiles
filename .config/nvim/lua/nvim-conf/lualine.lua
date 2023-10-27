local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
    vim.notify("failed to load lualine")
    return
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = { "dashboard", "lazy", "alpha" },
        },
        always_divide_middle = true,
        ignore_focus = {},
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            -- winbar = 100,
        },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        -- show the complete path to the file, but shorten it
        -- if it gets too long
        lualine_c = {
            {
                'filename',
                path = 3,
                file_status = true, -- display file status (readonly status, modified status)
                symbols = { modified = ' ', readonly = ' ' },
            },
        },
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
    tabline = {},
    extensions = {}
}

