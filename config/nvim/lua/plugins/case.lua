return {
  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({
        prefix = "ga",
      })
    end,
    keys = {
      "ga",
    },
    cmd = {
      "Subs",
      "TextCaseStartReplacingCommand",
    },
    priority = 1000,
    lazy = false,
  },
}
