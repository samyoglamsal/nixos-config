vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.signcolumn = "yes"
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.lsp.enable({
	"gopls",
	"yaml_language_server",
    "lua_ls",
    "ts_ls"
})

vim.cmd.colorscheme("gruvbox")
