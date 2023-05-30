-- lua/plugins/ui.lua

-- LUALINE
local lualine = require('lualine')

lualine.setup({})

local lualine_is_hide = false
-- local default_laststatus_value = vim.o.laststatus
local default_cmdheight_value = vim.o.cmdheight

local function toggle_lualine()
  if lualine_is_hide then
    vim.o.laststatus = 2
    vim.o.cmdheight = default_cmdheight_value
    lualine.hide({ unhide = true })
  else
    vim.o.laststatus = 0
    vim.o.cmdheight = 0
    lualine.hide({ unhide = false })
  end
  lualine_is_hide = not lualine_is_hide
end

vim.keymap.set('n', '<leader>lh', toggle_lualine)

-- Cokeline
local get_hex = require('cokeline/utils').get_hex
local mappings = require('cokeline/mappings')

local comments_fg = get_hex('Comment', 'fg')
local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3

local components = {
  space = {
    text = ' ',
    truncation = { priority = 1 }
  },

  two_spaces = {
    text = '  ',
    truncation = { priority = 1 },
  },

  separator = {
    text = function(buffer)
      return buffer.index ~= 1 and '▏' or ''
    end,
    truncation = { priority = 1 }
  },

  devicon = {
    text = function(buffer)
      return
          (mappings.is_picking_focus() or mappings.is_picking_close())
          and buffer.pick_letter .. ' '
          or buffer.devicon.icon
    end,
    fg = function(buffer)
      return
          (mappings.is_picking_focus() and yellow)
          or (mappings.is_picking_close() and red)
          or buffer.devicon.color
    end,
    style = function(_)
      return
          (mappings.is_picking_focus() or mappings.is_picking_close())
          and 'italic,bold'
          or nil
    end,
    truncation = { priority = 1 }
  },

  index = {
    text = function(buffer)
      return buffer.index .. ': '
    end,
    truncation = { priority = 1 }
  },

  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    fg = comments_fg,
    style = 'italic',
    truncation = {
      priority = 3,
      direction = 'left',
    },
  },

  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    style = function(buffer)
      return
          ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
            and 'bold,underline')
          or (buffer.is_focused and 'bold')
          or (buffer.diagnostics.errors ~= 0 and 'underline')
          or nil
    end,
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },

  diagnostics = {
    text = function(buffer)
      return
          (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
          or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
          or ''
    end,
    fg = function(buffer)
      return
          (buffer.diagnostics.errors ~= 0 and errors_fg)
          or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
          or nil
    end,
    truncation = { priority = 1 },
  },

  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    fg = function(buffer)
      return buffer.is_modified and green or nil
    end,
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

require('cokeline').setup({
  show_if_buffers_are_at_least = 2,

  buffers = {
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    new_buffers_position = 'next',
  },

  rendering = {
    max_buffer_width = 30,
  },

  default_hl = {
    fg = function(buffer)
      return
          buffer.is_focused
          and get_hex('Normal', 'fg')
          or get_hex('Comment', 'fg')
    end,
    bg = get_hex("GruvboxBg0"),
  },

  components = {
    components.space,
    components.separator,
    components.space,
    components.devicon,
    components.space,
    components.index,
    components.unique_prefix,
    components.filename,
    components.diagnostics,
    components.two_spaces,
    components.close_or_unsaved,
    components.space,
  },
})

local opts = { silent = true }
vim.keymap.set('n', '<A-,>', '<Plug>(cokeline-focus-prev)', opts)
vim.keymap.set('n', '<A-.>', '<Plug>(cokeline-focus-next)', opts)
vim.keymap.set('n', '<A-<>', '<Plug>(cokeline-switch-prev)', opts)
vim.keymap.set('n', '<A->>', '<Plug>(cokeline-switch-next)', opts)

for i = 1, 9 do
  vim.keymap.set('n', ('<A-%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), opts)
end

vim.keymap.set('n', '<A-c>', '<cmd>bdelete<cr>', opts)
vim.keymap.set('n', '<A-C>', '<cmd>bdelete!<cr>', opts)

vim.keymap.set('n', '<A-p>c', '<Plug>(cokeline-pick-close)', opts)
vim.keymap.set('n', '<A-p>f', '<Plug>(cokeline-pick-focus)', opts)



-- NVIM TREE

local nvim_tree = require('nvim-tree')

nvim_tree.setup({
  renderer = {
    special_files = {
      'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'CMakeLists.txt'
    },
    symlink_destination = true,
  },
  system_open = {
    cmd = 'xdg-open',
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
  },
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = { '^.git$', '^/node_modules' },
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 1000,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = true,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = {
            'notify',
            'packer',
            'qf',
            'diff',
            'fugitive',
            'fugitiveblame'
          },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },
  trash = {
    cmd = 'gio trash',
  },
  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = false,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts_(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end


    -- Default mappings. Feel free to modify or remove as you wish.
    --
    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts_('CD'))
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts_('Open: In Place'))
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts_('Info'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts_('Rename: Omit Filename'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts_('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts_('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts_('Open: Horizontal Split'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts_('Close Directory'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts_('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts_('Open Preview'))
    vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts_('Next Sibling'))
    vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts_('Previous Sibling'))
    vim.keymap.set('n', '.', api.node.run.cmd, opts_('Run Command'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts_('Up'))
    vim.keymap.set('n', 'a', api.fs.create, opts_('Create'))
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts_('Move Bookmarked'))
    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts_('Toggle No Buffer'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts_('Copy'))
    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts_('Toggle Git Clean'))
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts_('Prev Git'))
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts_('Next Git'))
    vim.keymap.set('n', 'd', api.fs.remove, opts_('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts_('Trash'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts_('Expand All'))
    vim.keymap.set('n', 'e', api.fs.rename_basename, opts_('Rename: Basename'))
    vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts_('Next Diagnostic'))
    vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts_('Prev Diagnostic'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts_('Clean Filter'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts_('Filter'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts_('Help'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts_('Copy Absolute Path'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts_('Toggle Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts_('Toggle Git Ignore'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts_('Last Sibling'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts_('First Sibling'))
    vim.keymap.set('n', 'm', api.marks.toggle, opts_('Toggle Bookmark'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts_('Open'))
    vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts_('Open: No Window Picker'))
    vim.keymap.set('n', 'p', api.fs.paste, opts_('Paste'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts_('Parent Directory'))
    vim.keymap.set('n', 'q', api.tree.close, opts_('Close'))
    vim.keymap.set('n', 'r', api.fs.rename, opts_('Rename'))
    vim.keymap.set('n', 'R', api.tree.reload, opts_('Refresh'))
    vim.keymap.set('n', 's', api.node.run.system, opts_('Run System'))
    vim.keymap.set('n', 'S', api.tree.search_node, opts_('Search'))
    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts_('Toggle Hidden'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts_('Collapse'))
    vim.keymap.set('n', 'x', api.fs.cut, opts_('Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts_('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts_('Copy Relative Path'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts_('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts_('CD'))
    -- END_DEFAULT_ON_ATTACH


    -- Mappings migrated from view.mappings.list
    --
    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    vim.keymap.set('n', '/', api.live_filter.start, opts_('Filter'))
    vim.keymap.set('n', 'l', api.node.open.edit, opts_('Open'))
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts_('Close Directory'))
    vim.keymap.set('n', 'H', api.tree.collapse_all, opts_('Collapse'))
  end
})


vim.keymap.set('n', '<leader><Space>', '<cmd>NvimTreeFocus<cr>')
vim.keymap.set('n', '<leader><Space>', '<cmd>NvimTreeToggle<cr>')
