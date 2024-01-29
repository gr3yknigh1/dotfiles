return {
  'numToStr/Comment.nvim',
  opts = {
    padding = true,   -- Add a space b/w comment and the line
    sticky = true,    -- Whether the cursor should stay at its position

    -- LHS of toggle mappings in NORMAL mode
    toggler = {
      line = 'gcc',    -- Line-comment toggle keymap
      block = 'gbc',   -- Block-comment toggle keymap
    },

    -- LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      line = 'gc',    -- Line-comment keymap
      block = 'gb',   -- Block-comment keymap
    },

    -- LHS of extra mappings
    extra = {
      above = 'gcO',   -- Add comment on the line above
      below = 'gco',   -- Add comment on the line below
      eol = 'gcA',     -- Add comment at the end of line
    },
  },
  lazy = false,
}
