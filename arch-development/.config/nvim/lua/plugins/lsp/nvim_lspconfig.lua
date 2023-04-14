-- lua/plugins/lsp/nvim_lspconfig.lua
--
-- LSP's configurations
-- Referencing to luasnip configuration from repo:
-- <https://github.com/sbulav/dotfiles/blob/master/nvim/lua/config/cmp.lua>

local utils     = require('utils')
local lspconfig = require('lspconfig')
local language_servers = require('plugins.lsp.language_servers')

local function custom_lsp_attach(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Diagnostic
  vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set('n', '<Leader>dN', vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set('n', '<Leader>dt', '<cmd>Telescope diagnostics<CR>', { buffer = 0 })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local default_lsp_config = {
  on_attach = custom_lsp_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

local expanded_lsp_config = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  } -- lua_ls
}

-- NOTE: Configuring language servers
for _, language_server in pairs(language_servers) do
  local config = default_lsp_config

  -- NOTE: Merging extra configurations
  if utils.has(expanded_lsp_config, language_server) then
    config = utils.merge(
      default_lsp_config, expanded_lsp_config[language_server]
      )
  end

  lspconfig[language_server].setup(config)
end

