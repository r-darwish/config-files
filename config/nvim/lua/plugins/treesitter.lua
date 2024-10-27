return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["at"] = { query = "@statement.outer", desc = "Select a statement" },
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assigent.rhs", desc = "Select right hand side of an assignment" },
          },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-p>",
          node_incremental = "<A-p>",
          scope_incremental = "<A-g>",
          node_decremental = "<A-n>",
        },
      },
    },
  },
}
