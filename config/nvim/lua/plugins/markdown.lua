return {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "jghauser/follow-md-links.nvim",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        sign = true,
      },
    },
  },
}
