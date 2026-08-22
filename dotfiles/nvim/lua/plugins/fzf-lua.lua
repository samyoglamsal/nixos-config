return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<leader>fg", "<CMD>FzfLua live_grep<CR>", desc = "(fzf) Project grep" },
    { "<leader>ff", "<CMD>FzfLua files<CR>", desc = "(fzf) Search project files" },
  },
}
