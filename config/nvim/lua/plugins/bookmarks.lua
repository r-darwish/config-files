return {
  {
    "tomasky/bookmarks.nvim",
    config = true,
    opts = {
      save_file = vim.fn.expand("$HOME/.local/share/nvim/bookmarks"),
    },
    event = "VimEnter",
    keys = {
      { "<leader>k", desc = "bookmarks" },
      {
        "<leader>kk",
        function()
          require("bookmarks").bookmark_toggle()
        end,
        desc = "toggle bookmark",
      },
      {
        "<leader>ki",
        function()
          require("bookmarks").bookmark_ann()
        end,
        desc = "edit bookmark annotation",
      },
      {
        "<leader>ks",
        function()
          require("telescope").extensions.bookmarks.list()
        end,
        desc = "search bookmarks",
      },
    },
  },
}
