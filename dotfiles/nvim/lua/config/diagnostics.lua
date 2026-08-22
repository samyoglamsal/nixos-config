vim.keymap.set(
  "n",
  "gK",
  function()
    local status = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = status })
  end,
  { desc = "Toggle diagnostic virtual_lines" }
)

vim.diagnostic.config({
  virtual_text = false,
})
