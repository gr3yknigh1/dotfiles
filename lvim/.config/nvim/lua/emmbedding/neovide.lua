
-- Neovide configuration
-- @NOTE Configuration documentation link
-- @LINK https://neovide.dev/configuration.html
if vim.fn.exists('g:neovide') and vim.g.neovide then
  print('Hello from Neovide!')

  local font_name = 'Iosevka Nerd Font'
  local default_font_size = 9
  local font_size = default_font_size
  local function get_guifont()
    return font_name .. ':h' .. tostring(font_size)
  end

  vim.opt.guifont = get_guifont()

  vim.g.neovide_scale_factor = 1.0

  -- vim.g.neovide_transparency = 1
  -- vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
  -- vim.g.neovide_floating_blur_amount_x = 2.0
  -- vim.g.neovide_floating_blur_amount_y = 2.0
  -- vim.g.neovide_scroll_animation_length = 0.3

  vim.g.neovide_fullscreen = false

  vim.g.neovide_cursor_trail_size = 0.4

  -- @NOTE Avaiable options for vim.g.neovide_cursor_vfx_mode:
  --   - railgun
  --   - torpedo
  --   - pixiedust
  --   - sonicboom
  --   - ripple
  --   - wireframe
  vim.g.neovide_cursor_vfx_mode = 'ripple'

  vim.keymap.set('n', '<C-=>', function()
    font_size = font_size + 1;
    vim.opt.guifont = get_guifont()
  end)
  vim.keymap.set('n', '<C-->', function()
    font_size = font_size - 1;
    vim.opt.guifont = get_guifont()
  end)
  vim.keymap.set('n', '<C-0>', function()
    font_size = default_font_size;
    vim.opt.guifont = get_guifont()
  end)
end


