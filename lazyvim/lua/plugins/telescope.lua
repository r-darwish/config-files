return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>sj",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Jump list",
      },
    },
  },
}
