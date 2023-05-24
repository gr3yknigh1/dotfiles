-- lua/plugins/lsp.lua
--
-- LSP's configurations
-- Referencing to luasnip configuration from repo:
-- <https://github.com/sbulav/dotfiles/blob/master/nvim/lua/config/cmp.lua>

local lspconfig        = require('lspconfig')
local cmp              = require('cmp')
local luasnip          = require('luasnip')

local utils            = require('utils')
local language_servers = require('plugins.language_servers')

local function custom_lsp_attach(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

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
          globals = { 'vim' },
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


-- CMP
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      if not luasnip then
        return
      end
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'path' }
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- LUASNIP
local snip = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node
-- local func = luasnip.function_node
-- local node = luasnip.snippet_node
-- local choice = luasnip.choice_node
-- local dynamicn = luasnip.dynamic_node

local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<c-j>', '<cmd>lua require\'luasnip\'.jump(1)<cr>', opts)
vim.keymap.set('s', '<c-j>', '<cmd>lua require\'luasnip\'.jump(1)<cr>', opts)
vim.keymap.set('i', '<c-k>', '<cmd>lua require\'luasnip\'.jump(-1)<cr>', opts)
vim.keymap.set('s', '<c-k>', '<cmd>lua require\'luasnip\'.jump(-1)<cr>', opts)

luasnip.add_snippets(nil, {
  all = {
  },
  cpp = {
    snip({
        trig = '#ifndef',
        namr = 'inclusion guard',
        dscr = '#ifndef HEADER; #define HEADER; #endif',
      },
      {
        text({ '#ifndef ' }),
        insert(1, 'HEADER_NAME'),
        text({
          '', '#define ',
        }),
        insert(2, 'HEADER_NAME'),
        text({ '', '', '#endif // ',
        }),
        insert(3, 'HEADER_NAME'),
      }),
  }
})