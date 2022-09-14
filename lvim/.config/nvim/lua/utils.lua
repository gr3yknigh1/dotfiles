-- @gr3yknigh1
-- 2022
-- 
-- Utility functions

return {

  map = (function(modes, keys, func, opts)
    vim.keymap.set(modes, keys, func, opts)
  end),

  nmap = (function(keys, func, opts)
    vim.keymap.set("n", keys, func, opts)
  end),

  vmap = (function(keys, func, opts)
    vim.keymap.set("v", keys, func, opts)
  end),

  vnmap = (function(keys, func, opts)
    vim.keymap.set({"n", "v"}, keys, func, opts)
  end),

  tmap = (function(keys, func, opts)
    vim.keymap.set("t", keys, func, opts)
  end)
}
