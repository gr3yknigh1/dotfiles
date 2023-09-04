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

vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>dt', '<cmd>Telescope diagnostics<CR>')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- if package.loaded['lspsaga'] ~= nil then
    --   vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc ++keep<cr>', opts)
    -- else
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- end

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- if package.loaded['lspsaga'] ~= nil then
    --   vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
    -- else
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    -- end

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- vim.api.nvim_create_autocmd(
--   { "BufEnter", "BufNewFile" },
--   {
--     pattern = { "*" },
--     callback = function(ev)
--       local opts = { buffer = ev.buf }
--
--       -- NOTE Fixing bug with missing keymapping which is trying to deleting on
--       -- changing buffer and closing hover_doc with ++keep flag
--       local lspsaga = require('lspsaga')
--       vim.keymap.set('n', lspsaga.config.scroll_preview.scroll_down, function()
--         -- lspsaga.diagnostics.code_action_cb.scroll_with_preview(1)
--       end, opts)
--       vim.keymap.set('n', lspsaga.config.scroll_preview.scroll_up, function()
--         -- lspsaga.diagnostics.code_action_cb.scroll_with_preview(-1)
--       end, opts)
--     end,
--   }
-- )

local navbuddy = require('nvim-navbuddy')

local function custom_lsp_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    -- navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

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
  completion = {
    autocomplete = false,
  },
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
        cmp.select_prev_item()
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
  }),
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
    end
  end
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
  },
  python = {
    snip({
      trig = "main",
      namr = "entry point",
      dscr = "main function",
    },
    {
      text({ "from __future__ import annotations" }),
      text({ "", "" }),
      text({ "", "" }),
      text({ "", "def main() -> int:" }),
      text({ "", "    print(\"Hello world\")" }),
      text({ "", "    return 0" }),
      text({ "", "" }),
      text({ "", "" }),
      text({ "", "if __name__ == \"__main__\":"}),
      text({ "", "    raise SystemExit(main())" }),
    }),
  }
})
