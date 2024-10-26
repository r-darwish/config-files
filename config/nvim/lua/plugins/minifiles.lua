return {
  "echasnovski/mini.files",
  config = true,
  keys = {
    {
      "<leader>fm",
      function()
        require("mini.files").open()
      end,
      mode = "n",
      desc = "mini.files",
    },
  },
}
