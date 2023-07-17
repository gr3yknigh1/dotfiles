-- TODO Add dev mode toggle
-- TODO Fix this shit

-- NOTE Thanks TJ
P = function(x)
  print(vim.inspect(x))
  return x
end

RELOAD_MODULE = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(x)
  RELOAD_MODULE(x)
  return require(x)
end

