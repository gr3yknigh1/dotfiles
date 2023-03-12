-- Lualine
--
-- Layout:
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
-- Sections:
-- branch (git branch)
-- buffers (shows currently available buffers)
-- diagnostics (diagnostics count from your preferred source)
-- diff (git diff status)
-- encoding (file encoding)
-- fileformat (file format)
-- filename
-- filesize
-- filetype
-- hostname
-- location (location in file in line:column format)
-- mode (vim mode)
-- progress (%progress in file)
-- tabs (shows currently available tabs)
-- windows (shows currently available windows)

local lualine = require('lualine')

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {"NvimTree"},
            winbar = {},
        },
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {'location'}
    },
    tabline = {
    },
    winbar = {
    },
    inactive_winbar = {
    },
    extensions = {}
}

local lualine_is_hide = false
local default_laststatus_value = vim.o.laststatus
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

vim.keymap.set("n", "<leader>lh", toggle_lualine)
