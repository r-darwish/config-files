return {
  {
    "L3MON4D3/LuaSnip",
    keys = {
      {
        "<C-x>",
        function()
          local ls = require("luasnip")
          ls.expand()
        end,
        mode = { "i" },
        remap = true,
      },
    },
  },
}
