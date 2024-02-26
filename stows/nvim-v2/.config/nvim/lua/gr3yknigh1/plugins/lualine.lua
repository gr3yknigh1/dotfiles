return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require("lualine")

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

    lualine.setup(
      {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'quickfix', 'packer', 'NvimTree', 'neo-tree' },  -- NOTE: qf - diagnostics buffer
            winbar = { },
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
          lualine_y = { 'filetype', 'fileformat' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" }
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    )
  end,
}
