-- lua/plugins/tools.lua

-- HEX


-- defaults
require 'hex'.setup {

  -- cli command used to dump hex data
  dump_cmd = 'xxd -g 1 -u',

  -- cli command used to assemble from hex data
  assemble_cmd = 'xxd -r',

  -- function that runs on BufReadPre to determine if it's binary or not
  is_buf_binary_pre_read = function()
    -- logic that determines if a buffer contains binary data or not
    -- must return a bool
  end,

  -- function that runs on BufReadPost to determine if it's binary or not
  is_buf_binary_post_read = function()
    -- logic that determines if a buffer contains binary data or not
    -- must return a bool
  end,
}

-- LAZYGIT
vim.g['lazygit_floating_window_winblend'] = 0
vim.g['lazygit_floating_window_scaling_factor'] = 0.9
vim.g['lazygit_floating_window_border_chars'] = { '╭', '╮', '╰', '╯' }
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


-- TREESITTER
local treesitter_configs = require('nvim-treesitter.configs')

treesitter_configs.setup({
  ensure_installed = {
    'c',
    'c_sharp',
    'cmake',
    'comment',
    'cpp',
    'fish',
    'gdscript',
    'gitignore',
    'json',
    'lua',
    'make',
    'markdown',
    'python',
    'rust',
    'markdown_inline',
  },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'


-- TELESCOPE
local telescope         = require('telescope')
local telescope_actions = require('telescope.actions')
local telescope_builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      '.git',
      '^node_modules',
      '^vendor',
    },
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close
      },
    },
  },
  pickers = {
    find_files = { hidden = true, layout_strategy = 'center' },
    live_grep = {
      additional_args = function(opts)
        return { "--hidden" }
      end
    },
  },
  extentions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },

  }
})

telescope.load_extension("file_browser")

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
-- vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>')
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers)
vim.keymap.set('n', '<leader>fl', telescope_builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)
vim.keymap.set('n', '<leader>fe', telescope.extensions.file_browser.file_browser)


-- ETC Plugins

local autopairs = require('nvim-autopairs')
autopairs.setup({
  disable_filetype = { 'TelescopePromt' },
})

local surround = require('nvim-surround')
surround.setup({})

local comment = require('Comment')
comment.setup()

local gitsigns = require('gitsigns')
gitsigns.setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})


-- Hop
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('n', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('n', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('n', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', function()
  hop.hint_words()
end, { remap = true })
