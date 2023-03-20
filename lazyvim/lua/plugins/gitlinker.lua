return {
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
      {
        "<leader>gb",
        function()
          require("gitlinker").get_buf_range_url(
            "n",
            { action_callback = require("gitlinker.actions").open_in_browser }
          )
        end,
        desc = "Browse Git",
        mode = { "n" },
      },
      {
        "<leader>gb",
        function()
          require("gitlinker").get_buf_range_url(
            "v",
            { action_callback = require("gitlinker.actions").open_in_browser }
          )
        end,
        desc = "Browse Git",
        mode = { "v" },
      },
      {
        "<leader>gl",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "Copy Git Link",
        mode = { "n" },
      },
      {
        "<leader>gl",
        function()
          require("gitlinker").get_buf_range_url("v")
        end,
        desc = "Copy Git Link",
        mode = { "v" },
      },
      {
        "<leader>gh",
        function()
          require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
        end,
        desc = "Browse Repository Home Page",
      },
    },
  },
}
