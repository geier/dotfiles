return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { '<C-p>',      function() require 'telescope.builtin'.find_files() end },
        { '<leader>ff', function() require 'telescope.builtin'.find_files() end },
        { '<leader>fg', function() require 'telescope.builtin'.live_grep() end },
        { '<leader>fb', function() require 'telescope.builtin'.buffers() end },
        { '<leader>fr', function() require 'telescope.builtin'.buffers() end },
    },
    config = function()
        local finders = require "telescope.builtin"
        local actions = require "telescope.actions"
        local sorters = require "telescope.sorters"
        local telescope = require "telescope"

        telescope.setup({
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
                                local current_picker = require("telescope.actions.state").get_current_picker(
                                prompt_bufnr)
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
        })
    end,
}
