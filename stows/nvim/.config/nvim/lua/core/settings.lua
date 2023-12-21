-- lua/core/settings.lua
-- basic editor's settings

vim.opt.shell = 'fish'

vim.opt.termguicolors = true
-- if vim.fn.has('termguicolors') then
-- end

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.colorcolumn='120'

vim.opt.numberwidth = 2
vim.opt.cursorline = true

vim.opt.encoding='utf-8'
vim.opt.fileformat='unix'

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd[[set nofoldenable]]

vim.opt.wrap = false
vim.opt.scrolloff = 5

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'trail:~'
-- vim.opt.listchars:append 'eol:¶'
vim.opt.listchars:append 'eol:↲'
vim.opt.listchars:append 'tab:» '
-- vim.opt.listchars:append 'tab:>~'
vim.opt.list = true

vim.opt.clipboard:append 'unnamedplus'

-- Mouse
vim.opt.mouse = 'a'

-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indentations
local indentation_size = 4
vim.opt.tabstop     = indentation_size
vim.opt.shiftwidth  = indentation_size
vim.opt.softtabstop = indentation_size
vim.opt.autoindent  = true
vim.opt.smartindent = true
vim.opt.expandtab   = true

-- AUTOCOMMANDS
-- TODO Replace with default nvim api calls
local au = require('au')

au({ 'BufWinEnter', 'WinEnter' }, {
  'term://*',
  function()
    vim.cmd('startinsert')
  end
})

au.BufLeave = {
  'term://*',
  function()
    vim.cmd('stopinsert')
  end
}

vim.cmd[[let g:c_syntax_for_h = 1]];




-- The amount of indent can be set with the `g:python_indent` |Dictionary|, which
-- needs to be created before adding the items: >
vim.cmd[[let g:python_indent = {}]]
-- The examples given are the defaults.  Note that the dictionary values are set
-- to an expression, so that you can change the value of 'shiftwidth' later
-- without having to update these values.
--
-- Indent after an open paren: >
vim.cmd[[let g:python_indent.open_paren = 'shiftwidth()']]
-- Indent after a nested paren: >
vim.cmd[[let g:python_indent.nested_paren = 'shiftwidth()']]
-- Indent for a continuation line: >
vim.cmd[[let g:python_indent.continue = 'shiftwidth() * 2']]

-- By default, the closing paren on a multiline construct lines up under the first
-- non-whitespace character of the previous line.
-- If you prefer that it's lined up under the first character of the line that
-- starts the multiline construct, reset this key: >

vim.cmd[[let g:python_indent.closed_paren_align_last_line = v:false]]

-- The method uses |searchpair()| to look back for unclosed parentheses.  This
-- can sometimes be slow, thus it timeouts after 150 msec.  If you notice the
-- indenting isn't correct, you can set a larger timeout in msec: >
-- 	let g:python_indent.searchpair_timeout = 500

-- If looking back for unclosed parenthesis is still too slow, especially during
-- a copy-paste operation, or if you don't need indenting inside multi-line
-- parentheses, you can completely disable this feature: >
-- 	let g:python_indent.disable_parentheses_indenting = 1
--
-- For backward compatibility, these variables are also supported: >
-- 	g:pyindent_open_paren
-- 	g:pyindent_nested_paren
-- 	g:pyindent_continue
-- 	g:pyindent_searchpair_timeout
-- 	g:pyindent_disable_parentheses_indenting
