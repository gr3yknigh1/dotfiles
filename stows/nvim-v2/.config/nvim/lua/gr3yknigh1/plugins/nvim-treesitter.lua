return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdateSync",
  config = function()
    local configs = require("nvim-treesitter.configs")

    -- NOTE: Thanks.
    -- <https://github.com/nvim-treesitter/nvim-treesitter/issues/3605#issuecomment-1644591006>
    local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"

    -- vim.opt.runtimepath:append(parser_install_dir)

    -- for _, v in ipairs(vim.opt.runtimepath:get()) do
    --   if (string.match(v, "lazy/nvim%-treesitter")) then
    --     vim.opt.runtimepath:remove(v)
    --   end
    -- end

    configs.setup({
      -- ensure_installed = "all",
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        disable = {},
      },
      additional_vim_regex_highlighting = true,
      indent = {
        enable = true
      },
      -- parser_install_dir = parser_install_dir,
    })
  end
}
