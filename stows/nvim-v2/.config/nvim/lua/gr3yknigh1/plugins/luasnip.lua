return {
  "L3MON4D3/LuaSnip",
  config = function()
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()
    -- LUASNIP
    local snip = luasnip.snippet
    local text = luasnip.text_node
    local insert = luasnip.insert_node
    -- local func = luasnip.function_node
    -- local node = luasnip.snippet_node
    -- local choice = luasnip.choice_node
    -- local dynamicn = luasnip.dynamic_node

    local opts = { noremap = true, silent = true }
    vim.keymap.set('i', '<C-j>', '<cmd>lua require\'luasnip\'.jump(1)<cr>', opts)
    vim.keymap.set('s', '<C-j>', '<cmd>lua require\'luasnip\'.jump(1)<cr>', opts)
    vim.keymap.set('i', '<C-k>', '<cmd>lua require\'luasnip\'.jump(-1)<cr>', opts)
    vim.keymap.set('s', '<C-k>', '<cmd>lua require\'luasnip\'.jump(-1)<cr>', opts)

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
            text({ "", "if __name__ == \"__main__\":" }),
            text({ "", "    raise SystemExit(main())" }),
          }),
      }
    })
  end
}
