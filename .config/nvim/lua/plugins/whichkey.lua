return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<leader>c", group = "NERD Commenter" },
      { "<leader>f", group = "Telescope" },
      { "<leader>h", group = "Gitsigns" },
      { "<leader>o", group = "Orgmode" },
      { "<leader>t", group = "Tablemode" },
      { "<leader>w", group = "Vimwiki" },

      {
        cond = function()
          return vim.bo.filetype == "org"
        end,
        { "<leader>oa", desc = "Orgmode agenda" },
        { "<leader>oc", desc = "Orgmode capture" },
        { "<leader>or", desc = "Refile current headline to destination" },
        { "<leader>oo", desc = "Open hyperlink under cursor" },
        { "<leader>ot", desc = "Set tags on current headline" },
        { "<leader>oA", desc = 'Toggle "Archive" tag on current headline' },
        { "<leader>oe", desc = "Open export options" },
        { "<leader>oK", desc = "Move current headline and its content up" },
        { "<leader>oJ", desc = "Move current headline and its content down" },
      },

      { "Q", "gq}", desc = "Format until end of paragraph" },
      { "Y", "y$", desc = "Yank until end of line" },
      { "<Tab>", ":bnext<CR>", desc = "Switch to next buffer" },
      { "<S-Tab>", ":bprevious<CR>", desc = "Switch to previous buffer" },
      { "<C-q>", 'a<C-r>=strftime("%Y-%m-%d")<CR><Esc>', desc = "Insert current date" },
      { "<C-h>", ":WhichKey<CR>", desc = "Run Which-Key" },
      {
        "<C-l>",
        ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>",
        desc = "Redraw screen",
      },

      { "<C-q>", '<C-R>=strftime("%Y-%m-%d")<CR>', desc = "Insert current date", mode = "i" },
      {
        "<C-q>",
        function()
          return os.date("%Y-%m-%d")
        end,
        desc = "Insert current date",
        mode = "c",
        expr = true,
        silent = false,
      },
      { "w!!", "%!sudo tee > /dev/null %", desc = "Write with sudo", mode = "c" },
    },
  },
}
