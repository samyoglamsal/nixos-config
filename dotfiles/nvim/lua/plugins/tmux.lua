return {
  "christoomey/vim-tmux-navigator",
  init = function ()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function ()
        vim.fn.system("tmux set-option -p @pane_is_vim 1")
      end,
    })
    vim.api.nvim_create_autocmd("VimLeave", {
      callback = function ()
        vim.fn.system("tmux set-option -p @pane_is_vim 0")
      end,
    })
  end,
}
