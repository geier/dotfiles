vim.api.nvim_set_keymap('n', "<leader>tt", "<cmd>Neotree toggle filesystem<CR>", { noremap = true, silent = true })
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "󰌶 ", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
    default_component_configs = {
        icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
        },
        git_status = {
            symbols = {
                renamed   = "󰁕",
                unstaged  = "󰄱",
            },
        },
    },
    document_symbols = {
        kinds = {
            File = { icon = "󰈙", hl = "Tag" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Property = { icon = "󰆧", hl = "@property" },
            Enum = { icon = "󰒻", hl = "@number" },
            Function = { icon = "󰊕", hl = "Function" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Struct = { icon = "󰌗", hl = "Type" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
    },
    enable_git_status = true,
    enable_diagnostics = true,
    source_selector = {
        winbar = true,
        statusline = false,
        sources = {
            { source = "filesystem", display_name = " 󰉓 Files " },
            { source = "git_status", display_name = " 󰊢 Git " },
            {source = "buffers", display_name = "  Buffers" },
        },
    },
    git_status = {
        symbols = {
            -- Change type
            added     = "✚", -- or "", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖",-- this can only be used in the git_status source
            renamed   = "",-- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
        }
    },
})

-- 󰌷
