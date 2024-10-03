return {
  {
    "jvgrootveld/telescope-zoxide",
    keys = {
      {
        "<leader>fz",
        function()
          require("telescope").extensions.zoxide.list()
        end,
        desc = "Zoxide",
      },
    },
  },
}
