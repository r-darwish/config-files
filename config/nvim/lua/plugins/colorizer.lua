return {
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  { "nvchad/volt", lazy = true },
  {
    "nvchad/minty",
    lazy = true,
    keys = {
      {
        "<leader>cc",
        function()
          require("minty.huefy").open({ border = true })
        end,
        desc = "Minty Huefy",
      },
      {
        "<leader>cC",
        function()
          require("minty.shades").open({ border = true })
        end,
        desc = "Minty Shades",
      },
    },
  },
}
