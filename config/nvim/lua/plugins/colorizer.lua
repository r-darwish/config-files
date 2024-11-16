return {
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  { "nvzone/volt", lazy = true },
  {
    "nvzone/minty",
    lazy = true,
    keys = {
      {
        "<leader>cc",
        function()
          require("minty.huefy").open()
        end,
        desc = "Minty Huefy",
      },
      {
        "<leader>cC",
        function()
          require("minty.shades").open()
        end,
        desc = "Minty Shades",
      },
    },
  },
}
