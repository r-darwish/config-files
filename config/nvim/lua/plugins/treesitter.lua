return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
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
}
