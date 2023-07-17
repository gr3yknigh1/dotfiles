-- local navic            = require('nvim-navic')
local navbuddy         = require('nvim-navbuddy')
local navbuddy_actions = require("nvim-navbuddy.actions")

-- navic.setup({
--   lsp = {
--     auto_attach = false,
--     preference = nil,
--   },
--   highlight = false,
--   separator = " > ",
--   depth_limit = 0,
--   depth_limit_indicator = "..",
--   safe_output = true,
--   click = false
-- })

navbuddy.setup({
  window = {
    border = "rounded", -- "rounded", "double", "solid", "none"
    -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = "60%",     -- Or table format example: { height = "40%", width = "100%"}
    position = "50%", -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil,  -- scrolloff value within navbuddy window
    sections = {
      left = {
        size = "20%",
        border = nil, -- You can set border style for each section individually as well.
      },
      mid = {
        size = "40%",
        border = nil,
      },
      right = {
        -- No size option for right most section. It fills to
        -- remaining area.
        border = nil,
        preview = "leaf", -- Right section can show previews too.
        -- Options: "leaf", "always" or "never"
      }
    },
  },
  node_markers = {
    enabled = true,
    icons = {
      leaf = "  ",
      leaf_selected = " → ",
      branch = " ",
    },
  },

  icons = {
    File          = "󰈙 ",
    Module        = " ",
    Namespace     = "󰌗 ",
    Package       = " ",
    Class         = "󰌗 ",
    Method        = "󰆧 ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "󰕘 ",
    Interface     = "󰕘 ",
    Function      = "󰊕 ",
    Variable      = "󰆧 ",
    Constant      = "󰏿 ",
    String        = " ",
    Number        = "󰎠 ",
    Boolean       = "◩ ",
    Array         = "󰅪 ",
    Object        = "󰅩 ",
    Key           = "󰌋 ",
    Null          = "󰟢 ",
    EnumMember    = " ",
    Struct        = "󰌗 ",
    Event         = " ",
    Operator      = "󰆕 ",
    TypeParameter = "󰊄 ",
  },

  use_default_mappings = true, -- If set to false, only mappings set
  -- by user are set. Else default
  -- mappings are used for keys
  -- that are not set by user
  mappings = {
    ["<esc>"] = navbuddy_actions.close(), -- Close and cursor to original location
    ["q"] = navbuddy_actions.close(),

    ["j"] = navbuddy_actions.next_sibling(),     -- down
    ["k"] = navbuddy_actions.previous_sibling(), -- up

    ["h"] = navbuddy_actions.parent(),           -- Move to left panel
    ["l"] = navbuddy_actions.children(),         -- Move to right panel
    ["0"] = navbuddy_actions.root(),             -- Move to first panel

    ["v"] = navbuddy_actions.visual_name(),      -- Visual selection of name
    ["V"] = navbuddy_actions.visual_scope(),     -- Visual selection of scope

    ["y"] = navbuddy_actions.yank_name(),        -- Yank the name to system clipboard "+
    ["Y"] = navbuddy_actions.yank_scope(),       -- Yank the scope to system clipboard "+

    ["i"] = navbuddy_actions.insert_name(),      -- Insert at start of name
    ["I"] = navbuddy_actions.insert_scope(),     -- Insert at start of scope

    ["a"] = navbuddy_actions.append_name(),      -- Insert at end of name
    ["A"] = navbuddy_actions.append_scope(),     -- Insert at end of scope

    ["r"] = navbuddy_actions.rename(),           -- Rename currently focused symbol

    ["d"] = navbuddy_actions.delete(),           -- Delete scope

    ["f"] = navbuddy_actions.fold_create(),      -- Create fold of current scope
    ["F"] = navbuddy_actions.fold_delete(),      -- Delete fold of current scope

    ["c"] = navbuddy_actions.comment(),          -- Comment out current scope

    ["<enter>"] = navbuddy_actions.select(),     -- Goto selected symbol
    ["o"] = navbuddy_actions.select(),

    ["J"] = navbuddy_actions.move_down(), -- Move focused node down
    ["K"] = navbuddy_actions.move_up(),   -- Move focused node up

    ["t"] = navbuddy_actions.telescope({  -- Fuzzy finder at current level.
      layout_config = {
        -- All options that can be
        height = 0.60, -- passed to telescope.nvim's
        width = 0.60,  -- default can be passed here.
        prompt_position = "top",
        preview_width = 0.50
      },
      layout_strategy = "horizontal"
    }),

    ["g?"] = navbuddy_actions.help(), -- Open mappings help window
  },
  lsp = {
    auto_attach = false, -- If set to true, you don't need to manually use attach function
    preference = nil,    -- list of lsp server names in order of preference
  },
  source_buffer = {
    follow_node = true, -- Keep the current node in focus on the source buffer
    highlight = true,   -- Highlight the currently focused node
    reorient = "smart", -- "smart", "top", "mid" or "none"
    scrolloff = nil     -- scrolloff value when navbuddy is open
  }
})


vim.keymap.set('n', 'gs', navbuddy.open, { silent = true })
