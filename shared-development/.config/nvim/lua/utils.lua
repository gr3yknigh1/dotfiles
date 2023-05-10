-- lua/utils.lua

return {
  -- NOTE: I dunno is that properly implemented
  -- TODO: Check how table references works in lua
  merge = (function (table1, table2)
    local merged = {}
    for key, value in pairs(table1) do
      merged[key] = value
    end
    for key, value in pairs(table2) do
      merged[key] = value
    end
    return merged
  end),

  has = (function (table, key)
    return table[key] ~= nil
  end),

  file_exists = (function (name)
    local f = io.open(name, 'r')
    if f ~= nil then io.close(f) return true else return false end
  end),
}
