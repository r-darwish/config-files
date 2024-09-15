return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gx", ":Telescope git_branches<CR>" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
          },
        },
      },
    },
  },
}
