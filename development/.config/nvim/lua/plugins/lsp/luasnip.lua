local ls = require('luasnip')


local snip = ls.snippet
local func = ls.function_node
local text = ls.text_node
local insert = ls.insert_node
-- local node = ls.snippet_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap('i', '<c-j>', '<cmd>lua require\'luasnip\'.jump(1)<cr>', opts)
keymap('s', '<c-j>', '<cmd>lua require\'luasnip\'.jump(1)<cr>', opts)
keymap('i', '<c-k>', '<cmd>lua require\'luasnip\'.jump(-1)<cr>', opts)
keymap('s', '<c-k>', '<cmd>lua require\'luasnip\'.jump(-1)<cr>', opts)


ls.add_snippets(nil, {
  all = {
    snip({
      trig = 'date',
      namr = 'Date',
      dscr = 'Date in the form of YYYY-MM-DD',
    }, {
      func(function()
        return { os.date('%Y-%m-%d') }
      end, {}),
    }),
  },
  cpp = {
    snip({
      trig = '#ifndef',
      namr = 'inclusion guard',
      dscr = '#ifndef HEADER; #define HEADER; #endif',
    },
    {
      text({'#ifndef '}),
      insert(1, 'HEADER_NAME'),
      text({
        '', '#define ',
      }),
      insert(2, 'HEADER_NAME'),
      text({'', '', '#endif // ',
      }),
      insert(3, 'HEADER_NAME'),
    }),
  }
})
