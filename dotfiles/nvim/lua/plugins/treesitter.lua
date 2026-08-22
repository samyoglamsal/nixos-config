return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Unmap default keybinds that overlap with some of the keybinds defined below
    -- vim.keymap.set("o", "is", "<Nop>", { noremap = true, silent = true, desc = "Disable selecting inner sentence (operator pending)" })
    -- vim.keymap.set("o", "as", "<Nop>", { noremap = true, silent = true, desc = "Disable selecting around sentence (operator pending)" })
    -- vim.keymap.set("x", "is", "<Nop>", { noremap = true, silent = true, desc = "Disable selecting inner sentence (visual)" })
    -- vim.keymap.set("x", "as", "<Nop>", { noremap = true, silent = true, desc = "Disable selecting around sentence (visual)" })

    require("nvim-treesitter.configs").setup({
      ensure_installed = { "javascript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "python" },
      ignore_install = {},
      modules = {},
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["il"] = "@assignment.lhs",
            ["ir"] = "@assignment.rhs",
            -- ["<leader>as"] = { query = "@block.outer", query_group = "locals", desc = "Select language scope" },
            -- ["<leader>is"] = { query = "@block.inner", query_group = "locals", desc = "Select language scope" },
          },
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          include_surrounding_whitespace = true,
        },
      },
    })
  end,
}
