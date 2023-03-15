return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "benfowler/telescope-luasnip.nvim",
        config = function()
          require("telescope").load_extension("luasnip")
        end,
      },
    },
    keys = {
      {
        "<C-s>",
        function()
          require("telescope").extensions.luasnip.luasnip()
        end,
        desc = "LuaSnippets",
        mode = { "i" },
      },
      {
        "<leader>sj",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Jump List",
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
