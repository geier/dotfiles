local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
    vim.notify("failed to load telescope")
    return
end

local finders = require "telescope.builtin"
local actions = require "telescope.actions"
local sorters = require "telescope.sorters"

require("telescope").setup(
    {
        defaults = {
            prompt_prefix = " ❯ ",
            sorting_strategy = "ascending",
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-h>"] = "which_key",
                }
            },
            layout_config = {
                 prompt_position = "top",
            },
            file_sorter = sorters.get_fzy_sorter,
            generic_sorter = sorters.get_fzy_sorter

        },
        pickers = {
            find_files = {
                mappings = {
                    n = {
                        ["<C-h>"] = function(prompt_bufnr)
                            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                            local opts = {
                                hidden = true,
                                default_text = current_picker:_get_prompt(),
                            }
                            require("telescope.actions").close(prompt_bufnr)
                            require("telescope.builtin").find_files(opts)
                        end,
                    },
                },
            },
        }
    }
)

function TelescopeOpen(fn)
    finders[fn]()
end

local builtin = require('telescope.builtin')
-- I'm still used to Ctrl-P
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


--better sorting of results
require('telescope').load_extension('fzy_native')
