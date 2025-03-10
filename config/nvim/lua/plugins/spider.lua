return {
  "chrisgrieser/nvim-spider",
  ---@type Spider.config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    skipInsignificantPunctuation = false,
  },
  config = true,
  keys = {
    {
      "w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of next of word",
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to end of word",
    },
    {
      "ge",
      "<cmd>lua require('spider').motion('ge')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to prev end of word",
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of previous word",
    },
  },
}
