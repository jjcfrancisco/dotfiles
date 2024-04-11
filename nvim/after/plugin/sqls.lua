require('lspconfig').sqls.setup({
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr) -- require sqls.nvim
  end,
  settings = {
    sqls = {
      connections = {
        {
          driver = 'postgresql',
          dataSourceName = 'host=database.dev.livingmap.com port=5432 user=admin password=WKRJGBRKHERROVTU dbname=dev1 sslmode=disable',
        },
        {
          driver = 'postgresql',
          dataSourceName = 'host=database.dev.livingmap.com port=5432 user=admin password=WKRJGBRKHERROVTU dbname=dev_imdf sslmode=disable',
        },
        {
          driver = 'postgresql',
          dataSourceName = 'host=34.147.152.115 port=5432 user=postgres password=NArzKYNaB4fVK911 dbname=dev1_language sslmode=disable',
        },
      },
    },
  },
})

