-- NOTE: This plugin is deprecated.
return {
  'phaazon/hop.nvim',
  version = "v2",
  config = function(opts)
    local hop = require('hop')
    vim.keymap.set({ 'n', 'v' }, '<C-j>', function()
      hop.hint_words()
    end, { remap = true })
    hop.setup(opts)
  end
}
