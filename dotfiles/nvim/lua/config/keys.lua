vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered when jumping up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered when jumping down" })
vim.keymap.set("n", "n", "nzz", { desc = "Keep cursor centered when searching next" })
vim.keymap.set("n", "N", "Nzz", { desc = "Keep cursor centered when searching prev" })

-- LSP
vim.keymap.set("n", "<leader>fb", vim.lsp.buf.format, { remap = false })
-- vim.keymap.set("n", "<leader>k", function ()
--   vim.diagnostic.config({ virtual_lines = { current_line = true}, virtual_text = false })

--   vim.api.nvim_create_autocmd("CursorMoved", {
--     group = vim.api.nvim_create_autogroup('line-diagnostics', { clear = true }),
--     callback = function ()
--       vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
--     end,
--   })
-- end)
