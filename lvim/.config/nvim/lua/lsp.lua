-- LSP's configuration

local utils = require("utils")

local map = utils.map
local nmap = utils.nmap

local custom_lsp_attach = function(client)
  nmap('K', vim.lsp.buf.hover)
  nmap('<c-]>', vim.lsp.buf.definition)
end


local lspconfig = require('lspconfig')

-- local servers = {
--   "tsserver",
--   "sumneko_lua"
-- }

lspconfig['tsserver'].setup({
  on_attach = custom_lsp_attach
})

local system_name = "Linux"
local sumneko_root_path = '/usr/bin/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

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
