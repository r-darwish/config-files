return {
  {
    "ruifm/gitlinker.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n", nil)
        end,
        desc = "Git Link",
      },
      {
        "<leader>gy",
        mode = { "v" },
        function()
          require("gitlinker").get_buf_range_url("v", nil)
        end,
        desc = "Git Link",
      },
    },
  },
}
