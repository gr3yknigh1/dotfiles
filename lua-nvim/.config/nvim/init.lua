-- @gr3yknigh1
-- 2022
--
-- Neovim's lua configuration

require('basic')
require('keybindings')
require('utils')

require('plugins')
require('apperience')

require('emmbedding.vscode')
require('emmbedding.neovide')

-- Plugins
require('plugins.ui')
require('plugins.tools.telescope')
require('plugins.tools.lazygit')

require('plugins.mason')
require('plugins.lang.nvim_lspconfig')
require('plugins.lang.cmp')
require('plugins.lang.luasnip')
require('plugins.lang.treesitter')
-- require('plugins.dap')

