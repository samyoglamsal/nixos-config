vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered when jumping up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered when jumping down" })
vim.keymap.set("n", "n", "nzz", { desc = "Keep cursor centered when searching next" })
vim.keymap.set("n", "N", "Nzz", { desc = "Keep cursor centered when searching prev" })

vim.keymap.set("n", "<leader>fb", vim.lsp.buf.format, { remap = false })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
