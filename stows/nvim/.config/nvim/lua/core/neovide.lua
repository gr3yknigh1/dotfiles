-- lua/core/neovide.lua
-- https://neovide.dev/configuration.html

if vim.g.neovide then

  local function get_guifont(font_name, font_size)
    -- <font_name>:h<font_size>
    -- example: Iosevka Nerd Font:h9
    return font_name .. ':h' .. tostring(font_size)
  end

  local font_name         = 'JetBrainsMono Nerd Font'
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5

  vim.g.neovide_profiler = false

  local default_font_size = 20
  local font_size         = default_font_size

  vim.opt.guifont = get_guifont(font_name, font_size)

  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_transparency = 1.0
  vim.g.transparency         = 1.0

  -- vim.g.neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))

  vim.g.neovide_floating_blur_amount_x  = 2.0
  vim.g.neovide_floating_blur_amount_y  = 2.0

  vim.g.neovide_scroll_animation_length = 0.3

  vim.g.neovide_fullscreen              = false
  vim.g.neovide_cursor_trail_size       = 0.4
  vim.g.neovide_hide_mouse_when_typing  = true

  -- NOTE: Avaiable options for vim.g.neovide_cursor_vfx_mode:
  --   - railgun
  --   - torpedo
  --   - pixiedust
  --   - sonicboom
  --   - ripple
  --   - wireframe
  vim.g.neovide_cursor_vfx_mode         = 'sonicboom'

  vim.keymap.set('n', '<C-=>', function()
    font_size = font_size + 1;
    vim.opt.guifont = get_guifont(font_name, font_size)
  end)
  vim.keymap.set('n', '<C-->', function()
    font_size = font_size - 1;
    vim.opt.guifont = get_guifont(font_name, font_size)
  end)
  vim.keymap.set('n', '<C-0>', function()
    font_size = default_font_size;
    vim.opt.guifont = get_guifont(font_name, font_size)
  end)

  vim.keymap.set('t', '<S-Space>', '<Space>')
  vim.keymap.set('t', '<C-S-Space>', '<Space>')
end

