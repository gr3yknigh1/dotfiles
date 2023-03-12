-- Nvim Tree

local nvim_tree = require("nvim-tree")

local nvim_tree_lib  = require("nvim-tree.lib")
local nvim_tree_view = require("nvim-tree.view")

local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

local git_add = function()
  local node = nvim_tree_lib.get_node_at_cursor()
  local gs = node.git_status

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end
  nvim_tree_lib.refresh_tree()
end

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
  -- open as vsplit on current node
  local action = "edit"
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
  local action = "vsplit"
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
  sort_by = "name",
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
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
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
    -- width = 30,
    -- height = 30,
    mappings = {
      custom_only = false,
      list = {
        { key = "/", action = "live_filter" },
        { key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all },
        { key = "ga", action = "git_add", action_cb = git_add },
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
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
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$", "^/node_modules" },
    exclude = { },
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
        global = false,
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
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                  filetype = {
                    "notify",
                    "packer",
                    "qf",
                    "diff",
                    "fugitive",
                    "fugitiveblame"
                  },
                  buftype = { "nofile", "terminal", "help" },
              },
          },
      },
      remove_file = {
          close_window = true,
      },
  },
  trash = {
      cmd = "gio trash",
      require_confirm = true,
  },
  live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = false,
  },
  log = {
      enable = false,
      truncate = false,
      types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
      },
  },
}) -- END_DEFAULT_OPTS


vim.keymap.set("n", "<Leader><Space>", "<cmd>NvimTreeFocus<CR>")
vim.keymap.set("n", "<Leader><Space>", "<cmd>NvimTreeToggle<CR>")
