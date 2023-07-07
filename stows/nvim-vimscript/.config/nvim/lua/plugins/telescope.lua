-- Telescope

local actions = require("telescope.actions")
require('telescope').setup{
    defaults = {
        file_ignore_patterns = { ".git", "node_modules", ".mono", ".import" },
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--ignore-file',
          '.gitignore'
        },
    }
}

local function nmap(keys, func, opts)
    vim.keymap.set("n", keys, func, opts)
end

nmap("<leader>ff", "<cmd>Telescope find_files hidden=true<CR>")
nmap("<leader>fg", "<cmd>Telescope live_grep<CR>")
nmap("<leader>fb", "<cmd>Telescope buffers<CR>")
nmap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nmap("<leader>fd", "<cmd>Telescope diagnostics<CR>")
