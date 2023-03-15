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
    opts = {
      pickers = {
        live_grep = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
      },
    },
  },
}
