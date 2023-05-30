-- lua/plugins/ui.lua

-- LUALINE
local lualine = require('lualine')

-- NOTE: Too heavy
-- local navic   = require('nvim-navic')
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'quickfix', 'packer', 'NvimTree' },
      winbar = { 'quickfix', 'packer', 'NvimTree' },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {
    lualine_c = { 'navic' },
  },
  inactive_winbar = {},
  extensions = {}
})

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


-- Bufferline

local bufferline = require('bufferline')
bufferline.setup {
  options = {
    mode = "buffers",                               -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.no_italic, -- bufferline.style_preset.default | bufferline.style_preset.minimal,
    themable = true,                                --  true | false, -- allows highlight groups to be overriden i.e. sets highlights as default
    numbers = "none",                               -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "bdelete! %d",                  -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = "bdelete! %d",            -- can be a string | function | false, see "Mouse actions"
    left_mouse_command = "buffer %d",               -- can be a string | function, | false see "Mouse actions"
    middle_mouse_command = nil,                     -- can be a string | function, | false see "Mouse actions"
    indicator = {
      icon = ' ',                                 -- this should be omitted if indicator style is not 'icon'
      style = 'icon'                                -- 'icon' | 'underline' | 'none',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf) -- buf contains:
      -- name                | str        | the basename of the active file
      -- path                | str        | the full path of the active file
      -- bufnr (buffer only) | int        | the number of the active buffer
      -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
      -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    end,
    max_name_length = 18,
    max_prefix_length = 15,   -- prefix used when a buffer is de-duplicated
    truncate_names = true,    -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = 'nvim_lsp', -- false | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      -- local icon = level:match("error") and " " or " "
      return "" -- .. icon .. count
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end

      return true
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer", -- "File Explorer" | function ,
        text_align = "left",    -- "left" | "center" | "right"
        separator = true
      }
    },
    color_icons = true, -- true | false, -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
      -- or
      -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
      -- return custom_map[element.filetype]
    end,
    show_buffer_icons = true,       --  true | false, -- disable filetype icons for buffers
    show_buffer_close_icons = true, -- true | false,
    show_close_icon = true,         -- true | false,
    show_tab_indicators = true,     -- true | false,
    show_duplicate_prefix = true,   -- true | false, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true,     -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",      -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,  -- false | true,
    always_show_bufferline = true, -- true | false,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    sort_by = 'insert_after_current', -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    --     -- add custom logic
    --     return buffer_a.modified > buffer_b.modified
    -- end
  }
}

local opts = { silent = true }
vim.keymap.set('n', '<A-,>', function() bufferline.cycle(-1) end, opts)
vim.keymap.set('n', '<A-.>', function() bufferline.cycle(1) end, opts)
vim.keymap.set('n', '<A-<>', function() bufferline.move(-1) end, opts)
vim.keymap.set('n', '<A->>', function() bufferline.move(1) end, opts)

for i = 1, 9 do
  vim.keymap.set('n', ('<A-%s>'):format(i), function() bufferline.go_to(i, true) end, opts)
end

vim.keymap.set('n', '<A-c>', '<cmd>bdelete<cr>', opts)
vim.keymap.set('n', '<A-C>', '<cmd>bdelete!<cr>', opts)


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
    show_on_dirs = false,
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
