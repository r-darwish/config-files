return {
  "L3MON4D3/LuaSnip",
  opts = function()
    require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })
  end,
  keys = {
    {
      "<C-.>",
      function()
        require("luasnip").jump(1)
      end,
      mode = { "s", "i" },
      desc = "Jump to the next luasnip param",
    },
    {
      "<C-,>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "s", "i" },
      desc = "Jump to the previous luasnip param",
    },
    {
      "<C-x>",
      function()
        require("luasnip").expand({})
      end,
      mode = { "s", "i" },
      desc = "Expand a snippet",
    },
  },
}
