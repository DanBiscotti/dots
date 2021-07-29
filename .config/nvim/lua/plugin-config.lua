--vim.updatetime=100 -- git gutter
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Enable the following language servers
local nvim_lsp = require 'lspconfig'
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- Compe setup
require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}
