-- lua/plugins/lsp.lua
--
-- LSP's configurations
-- Referencing to luasnip configuration from repo:
-- <https://github.com/sbulav/dotfiles/blob/master/nvim/lua/config/cmp.lua>

local lspconfig        = require('lspconfig')
local cmp              = require('cmp')
local luasnip          = require('luasnip')
local navic            = require('nvim-navic')
local navbuddy         = require('nvim-navbuddy')
local navbuddy_actions = require("nvim-navbuddy.actions")

local utils            = require('utils')
local language_servers = require('plugins.language_servers')

navic.setup({
  lsp = {
    auto_attach = false,
    preference = nil,
  },
  highlight = false,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true,
  click = false
})

navbuddy.setup({
  window = {
    border = "single",     -- "rounded", "double", "solid", "none"
    -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = "60%",         -- Or table format example: { height = "40%", width = "100%"}
    position = "50%",     -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil,      -- scrolloff value within navbuddy window
    sections = {
      left = {
        size = "20%",
        border = nil,         -- You can set border style for each section individually as well.
      },
      mid = {
        size = "40%",
        border = nil,
      },
      right = {
        -- No size option for right most section. It fills to
        -- remaining area.
        border = nil,
        preview = "leaf",         -- Right section can show previews too.
        -- Options: "leaf", "always" or "never"
      }
    },
  },
  node_markers = {
    enabled = true,
    icons = {
      leaf = "  ",
      leaf_selected = " → ",
      branch = " ",
    },
  },

  use_default_mappings = true,   -- If set to false, only mappings set
  -- by user are set. Else default
  -- mappings are used for keys
  -- that are not set by user
  mappings = {
    ["<esc>"] = navbuddy_actions.close(),     -- Close and cursor to original location
    ["q"] = navbuddy_actions.close(),

    ["j"] = navbuddy_actions.next_sibling(),         -- down
    ["k"] = navbuddy_actions.previous_sibling(),     -- up

    ["h"] = navbuddy_actions.parent(),               -- Move to left panel
    ["l"] = navbuddy_actions.children(),             -- Move to right panel
    ["0"] = navbuddy_actions.root(),                 -- Move to first panel

    ["v"] = navbuddy_actions.visual_name(),          -- Visual selection of name
    ["V"] = navbuddy_actions.visual_scope(),         -- Visual selection of scope

    ["y"] = navbuddy_actions.yank_name(),            -- Yank the name to system clipboard "+
    ["Y"] = navbuddy_actions.yank_scope(),           -- Yank the scope to system clipboard "+

    ["i"] = navbuddy_actions.insert_name(),          -- Insert at start of name
    ["I"] = navbuddy_actions.insert_scope(),         -- Insert at start of scope

    ["a"] = navbuddy_actions.append_name(),          -- Insert at end of name
    ["A"] = navbuddy_actions.append_scope(),         -- Insert at end of scope

    ["r"] = navbuddy_actions.rename(),               -- Rename currently focused symbol

    ["d"] = navbuddy_actions.delete(),               -- Delete scope

    ["f"] = navbuddy_actions.fold_create(),          -- Create fold of current scope
    ["F"] = navbuddy_actions.fold_delete(),          -- Delete fold of current scope

    ["c"] = navbuddy_actions.comment(),              -- Comment out current scope

    ["<enter>"] = navbuddy_actions.select(),         -- Goto selected symbol
    ["o"] = navbuddy_actions.select(),

    ["J"] = navbuddy_actions.move_down(),     -- Move focused node down
    ["K"] = navbuddy_actions.move_up(),       -- Move focused node up

    ["t"] = navbuddy_actions.telescope({      -- Fuzzy finder at current level.
      layout_config = {
                                     -- All options that can be
        height = 0.60,               -- passed to telescope.nvim's
        width = 0.60,                -- default can be passed here.
        prompt_position = "top",
        preview_width = 0.50
      },
      layout_strategy = "horizontal"
    }),

    ["g?"] = navbuddy_actions.help(),     -- Open mappings help window
  },
  lsp = {
    auto_attach = false,     -- If set to true, you don't need to manually use attach function
    preference = nil,        -- list of lsp server names in order of preference
  },
  source_buffer = {
    follow_node = true,     -- Keep the current node in focus on the source buffer
    highlight = true,       -- Highlight the currently focused node
    reorient = "smart",     -- "smart", "top", "mid" or "none"
    scrolloff = nil         -- scrolloff value when navbuddy is open
  }
})


vim.keymap.set('n', 'gs',navbuddy.open, { silent=true })

local function custom_lsp_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)
  end

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
