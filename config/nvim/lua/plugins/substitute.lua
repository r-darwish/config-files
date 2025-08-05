return {
  "gbprod/substitute.nvim",
  opts = {
    on_substitute = function()
      require("yanky.integration").substitute()
    end,
    highlight_substituted_text = {
      enabled = false,
    },
  },
  keys = {
    {
      "r",
      function()
        require("substitute").operator()
      end,
      mode = { "n" },
    },
    {
      "rr",
      function()
        require("substitute").line()
      end,
      mode = { "n" },
    },
    {
      "r",
      function()
        require("function").visual()
      end,
      mode = { "x" },
    },
  },
}
