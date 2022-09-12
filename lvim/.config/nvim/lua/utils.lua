-- @gr3yknigh1
-- 2022
-- 
-- Utility functions

return {

  map = (function(modes, keys, func, opts)
    vim.keymap.set(modes, keys, func, opts)
  end),

  nmap = (function(keys, func, opts)
    map("n", keys, func, opts)
  end),

  vmap = (function(keys, func, opts)
    map("v", keys, func, opts)
  end),

  vnmap = (function(keys, func, opts)
    map({"n", "v"}, keys, func, opts)
  end),

  tmap = (function(keys, func, opts)
    map("t", keys, func, opts)
  end)
}
