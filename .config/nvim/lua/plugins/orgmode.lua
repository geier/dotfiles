return {
  'nvim-orgmode/orgmode',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  event = 'VeryLazy',
  config = function()

    -- Setup treesitter
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
      },
      ensure_installed = { 'org' },
    })

    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/org/**/*',
      org_default_notes_file = '~/org/refile.org',
      org_todo_keywords = {'TODO', 'WAITING', '|', 'DONE', 'DELEGATED',
      'private', 'cg', 'internal', 'bm', 'qcokain', 'kiss', 'kiss',
     },
     org_todo_keyword_faces = {
         cg = ':foreground #458588 :weight bold',
         internal = ':foreground #458588 :weight bold',
         bm = ':foreground #458588 :weight bold',
         qcokain = ':foreground #458588 :weight bold',
         kiss = ':foreground #458588 :weight bold',
         hsu = ':foreground #458588 :weight bold',
         sales = ':foreground #458588 :weight bold',
         recruiting = ':foreground #458588 :weight bold',
         nerdistan = ':foreground #458588 :weight bold',
         private = ':foreground #458588 :weight bold',
         A = ':foreground #fb4934 :weight bold',
         DELEGATED = ':background #FFFFFF :slant italic :underline on',
     },
 })
  end,
}
----------
-- orgmode
----------
-- require('orgmode').setup({
--   org_agenda_files = {'~/org/*', },
--   org_default_notes_file = '~/org/refile.org',
-- 
--   org_todo_keywords = {'TODO', 'WAITING', '|', 'DONE', 'DELEGATED',
--     'private',
--     'ga', 'internal', 'ca',
--     'mbp', 'mo360', 'vabe',
-- },
--   org_todo_keyword_faces = {
--     ga = ':foreground #458588 :weight bold',
--     internal = ':foreground #458588 :weight bold',
--     ca = ':foreground #458588 :weight bold',
--     mbp = ':foreground #458588 :weight bold',
--     vabe = ':foreground #458588 :weight bold',
--     mo360 = ':foreground #458588 :weight bold',
--     sales = ':foreground #458588 :weight bold',
--     recruiting = ':foreground #458588 :weight bold',
--     nerdistan = ':foreground #458588 :weight bold',
--     private = ':foreground #458588 :weight bold',
--     A = ':foreground #fb4934 :weight bold'
--   }
-- })

-- require('orgmode').setup_ts_grammar()
