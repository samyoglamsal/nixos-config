return {
  "mfussenegger/nvim-lint",
  config = function ()
    local linter = require("lint")
    linter.linters_by_ft = {
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        linter.try_lint()
      end,
    })
  end
}

