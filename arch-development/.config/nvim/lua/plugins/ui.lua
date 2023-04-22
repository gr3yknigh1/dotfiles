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
    lualine.hide({unhide=true})
  else
    vim.o.laststatus = 0
    vim.o.cmdheight = 0
    lualine.hide({unhide=false})
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
        (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
        or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
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
      return buffer.is_modified and '●' or ''
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
    bg = get_hex('ColorColumn', 'bg'),
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

for i = 1,9 do
  vim.keymap.set('n', ('<A-%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), opts)
end

vim.keymap.set('n', '<A-c>', '<cmd>bdelete<cr>', opts)
vim.keymap.set('n', '<A-C>', '<cmd>bdelete!<cr>', opts)

vim.keymap.set('n', '<A-p>c', '<Plug>(cokeline-pick-close)', opts)
vim.keymap.set('n', '<A-p>f', '<Plug>(cokeline-pick-focus)', opts)



-- NVIM TREE

local nvim_tree      = require('nvim-tree')
local nvim_tree_lib  = require('nvim-tree.lib')
local nvim_tree_view = require('nvim-tree.view')

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO  = 0.5

local function collapse_all()
  require('nvim-tree.actions.tree-modifiers.collapse-all').fn()
end

local function edit_or_open()
  -- open as vsplit on current node
  local action = 'edit'
  local node = nvim_tree_lib.get_node_at_cursor()
  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
    nvim_tree_view.close() -- Close the tree if file was opened
  elseif node.nodes ~= nil then
    nvim_tree_lib.expand_or_collapse(node)
  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
    -- nvim_tree_view.close() -- Close the tree if file was opened
  end
end

local function vsplit_preview()
  -- open as vsplit on current node
  local action = 'vsplit'
  local node = nvim_tree_lib.get_node_at_cursor()
  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
  elseif node.nodes ~= nil then
    nvim_tree_lib.expand_or_collapse(node)
  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
  end
  -- Finally refocus on tree if it was lost
  nvim_tree_view.focus()
end

nvim_tree.setup({
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  ignore_buf_on_tab_change = {},
  sort_by = 'name',
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  tab = {
    sync = {
      open = true
    }
  },
  view = {
    adaptive_size = false,
    centralize_selection = false,
    hide_root_folder = false,
    side = 'left',
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = math.floor(vim.opt.columns:get() * WIDTH_RATIO),
    -- width  = 30,
    -- height = 30,
    mappings = {
      custom_only = false,
      list = {
        { key = '/', action = 'live_filter' },
        { key = 'l', action = 'edit', action_cb = edit_or_open },
        { key = 'h', action = 'close_node' },
        { key = 'H', action = 'collapse_all', action_cb = collapse_all },
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = 'none',
    root_folder_modifier = ':~',
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = '└',
        edge = '│',
        item = '│',
        none = ' ',
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      padding = ' ',
      symlink_arrow = ' ➛ ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
    special_files = {
      'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'CMakeLists.txt'
    },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = 'xdg-open',
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  filters = {
    dotfiles = false,
    custom = { '^.git$', '^/node_modules' },
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = true,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
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
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = 'gio trash',
    require_confirm = true,
  },
  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = false,
  },
})


vim.keymap.set('n', '<leader><Space>', '<cmd>NvimTreeFocus<cr>')
vim.keymap.set('n', '<leader><Space>', '<cmd>NvimTreeToggle<cr>')
