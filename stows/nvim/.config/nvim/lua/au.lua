-- https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da
--
-- NOTE: Move this file to your neovim lua runtime path ie. ~/.config/nvim/lua/au.lua
-- Simple autocmd with one event: au.<event> = string | fn | { pattern: string, action: string | fn }
--

local cmd = vim.api.nvim_command

local function autocmd(this, event, spec)
  local is_table = type(spec) == 'table'
  local pattern = is_table and spec[1] or '*'
  local action = is_table and spec[2] or spec
  if type(action) == 'function' then
    action = this.set(action)
  end
  local e = type(event) == 'table' and table.concat(event, ',') or event
  cmd('autocmd ' .. e .. ' ' .. pattern .. ' ' .. action)
end

local S = {
  __au = {},
}

local X = setmetatable({}, {
  __index = S,
  __newindex = autocmd,
  __call = autocmd,
})

function S.exec(id)
  S.__au[id]()
end

function S.set(fn)
  local id = string.format('%p', fn)
  S.__au[id] = fn
  return string.format('lua require("au").exec("%s")', id)
end

function S.group(grp, cmds)
  cmd('augroup ' .. grp)
  cmd('autocmd!')
  if type(cmds) == 'function' then
    cmds(X)
  else
    for _, au in ipairs(cmds) do
      autocmd(S, au[1], { au[2], au[3] })
    end
  end
  cmd('augroup END')
end

return X
