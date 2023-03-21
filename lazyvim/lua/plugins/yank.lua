return {
  {
    "gbprod/substitute.nvim",
    lazy = true,
    keys = {
      {
        "R",
        function()
          require("substitute").operator()
        end,
      },
      {
        "r",
        function()
          require("substitute").visual()
        end,
        mode = "x",
      },
    },
    opts = {
      highlight_substituted_text = {
        enabled = false,
      },
    },
  },
}
