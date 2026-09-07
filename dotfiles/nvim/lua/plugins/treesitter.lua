return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function ()
    local ts = require("nvim-treesitter")
    ts.install({ "go", "python", "markdown", "lua" })
  end,
}
