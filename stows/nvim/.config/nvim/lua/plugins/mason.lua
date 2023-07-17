-- lua/plugins/mason.lua

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup({
  -- The directory in which to install packages.
  -- TODO: Replace with plenary.path
  install_root_dir = vim.fn.stdpath('data') .. '/' .. 'lsp_servers',
  registries = {
    "lua:mason-registry.index",
    "github:mason-org/mason-registry",
  },
  providers = {
    "mason.providers.registry-api",
    "mason.providers.client",
  },
})

mason_lspconfig.setup({})
