-- @gr3yknigh1
-- 2022
--
-- Completions

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
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
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
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


-- LSP's configuration

local custom_lsp_attach = function()
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = 0 })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })

  vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set('n', '<Leader>dN', vim.diagnostic.goto_prev, { buffer = 0 })

  vim.keymap.set('n', '<Leader>dt', "<cmd>Telescope diagnostics<CR>", { buffer = 0 })

  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = 0 })
end


local lspconfig = require('lspconfig')


require('lspconfig').angularls.setup({
  on_attach = custom_lsp_attach
})
-- local servers = {
--   "tsserver",
--   "sumneko_lua"
-- }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    }
})

lspconfig['tsserver'].setup({
  on_attach = custom_lsp_attach
})

lspconfig['pyright'].setup({
  on_attach = custom_lsp_attach
})

lspconfig['ccls'].setup({
  on_attach = custom_lsp_attach,
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    }
  }
})

lspconfig['rust_analyzer'].setup({
  on_attach = custom_lsp_attach
})

-- local system_name = "Linux"
local sumneko_root_path = "/usr/lib/lua-language-server"
local sumneko_binary = "/usr/bin/lua-language-server"

lspconfig['sumneko_lua'].setup({
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  -- An example of settings for an LSP server.
  --    For more options, see nvim-lspconfig
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    }
  },

  on_attach = custom_lsp_attach
})
