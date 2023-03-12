local au = require("au")

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

local function bind_make_commands()
  if file_exists(vim.fn.getcwd() .. "/Makefile") then
    vim.keymap.set("n", "<leader>mf", "<cmd>make format<cr>")
    vim.keymap.set("n", "<leader>ma", "<cmd>make all<cr>")
    vim.keymap.set("n", "<leader>mc", "<cmd>make clean<cr>")
    vim.keymap.set("n", "<leader>mr", "<cmd>make run<cr>")
    vim.keymap.set("n", "<leader>mt", "<cmd>make tests<cr>")
  end
end

bind_make_commands()

-- au({ "BufWinEnter", "WinEnter" }, {
--   "*.{c,cpp,h,hpp}",
--   function()
--     bind_make_commands()
--   end
-- })

