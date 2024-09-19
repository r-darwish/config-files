return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-p>",
        node_incremental = "<C-p>",
        scope_incremental = "<C-g>",
        node_decremental = "<C-n>",
      },
    },
  },
}
