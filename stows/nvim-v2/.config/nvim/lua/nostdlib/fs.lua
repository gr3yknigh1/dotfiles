M = {}

local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
if is_windows == true then
  M.path_separator = "\\"
else
  M.path_separator = "/"
end


--- Split string into a table of strings using a separator.
--- @param inputString string The string to split.
--- @param sep string The separator to use.
--- @return table table A table of strings.
M.split = function(inputString, sep)
  local fields = {}

  local pattern = string.format("([^%s]+)", sep)
  local _ = string.gsub(inputString, pattern, function(c)
    fields[#fields + 1] = c
  end)

  return fields
end

--- Joins arbitrary number of paths together.
--- @param ... string The paths to join.
--- @return string
M.path_join = function(...)
  local args = { ... }
  if #args == 0 then
    return ""
  end

  local all_parts = {}
  if type(args[1]) == "string" and args[1]:sub(1, 1) == M.path_separator then
    all_parts[1] = ""
  end

  for _, arg in ipairs(args) do
    local arg_parts = M.split(arg, M.path_separator)
    vim.list_extend(all_parts, arg_parts)
  end
  return table.concat(all_parts, M.path_separator)
end

--- Is file exists or not.
--- @param name string
--- @return boolean
M.is_file_exists = function(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end


--- Returns current file path or CWD if buffer isn't save to file.
--- @return string
M.reveal_file_or_directory = function()
  local reveal_file = vim.fn.expand('%:p')
  if (reveal_file == '') then
    reveal_file = vim.fn.getcwd()
  else
    local f = io.open(reveal_file, "r")
    if (f) then
      f.close(f)
    else
      reveal_file = vim.fn.getcwd()
    end
  end
  return reveal_file
end

return M
