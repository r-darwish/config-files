if os.getenv("TERMUX_VERSION") ~= nil then
  return {
    { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
    {
      "hrsh7th/nvim-cmp",
      enabled = true,
    },
  }
else
  return {
    "saghen/blink.cmp",
    opts = {
      enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
    },
  }
end
