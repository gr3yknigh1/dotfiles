-- lua/plugins/lsp/mason/mason_lspconfig.lua

local language_servers = require('plugins.lsp.language_servers')

require('mason-lspconfig').setup({
  ensure_installed = language_servers,
  automatic_installation = false,
})
