vim.g['lazygit_floating_window_winblend'] = 0
vim.g['lazygit_floating_window_scaling_factor'] = 0.9
vim.g['lazygit_floating_window_corner_chars'] = {'╭', '╮', '╰', '╯'}
vim.g['lazygit_floating_window_use_plenary'] = 0
vim.g['lazygit_use_neovim_remote'] = 0
vim.g['lazygit_use_custom_config_file_path'] = 0
vim.g['lazygit_config_file_path'] = ''

-- NOTE: See also commands
--  - LazyGit
--  - LazyGitConfig
--  - LazyGitCurrentFile
--  - LazyGitFilter
--  - LazyGitFilterCurrentFile
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>')
vim.keymap.set('n', '<leader>lc', '<cmd>LazyGitCurrentFile<cr>')

