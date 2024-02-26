M = {}

-- TODO: Add dev mode toggle
-- TODO: Fix this shit
-- TODO: Move to custom local plugin

-- NOTE Thanks TJ
M.P = function(x)
  print(vim.inspect(x))
  return x
end

RELOAD_MODULE = function(...)
  return require("plenary.reload").reload_module(...)
end

M.R = function(x)
  RELOAD_MODULE(x)
  return require(x)
end

return M
