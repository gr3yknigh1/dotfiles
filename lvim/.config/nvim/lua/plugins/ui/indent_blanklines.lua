-- Indent Blanklines

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD]]

require("indent_blankline").setup({
  space_char_blankline = " ",
  show_current_context = true,
  show_end_of_line = true,
  show_current_context_start = true,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
})
