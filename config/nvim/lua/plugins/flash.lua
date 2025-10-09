---@module "flash"

return {
  "folke/flash.nvim",
  ---@type Flash.Config
  ---@diagnostic disable-next-line: missing-fields
  keys = {
    {
      "<c-space>",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          labels = "123456789",
          actions = {
            ["<c-space>"] = "next",
            ["<BS>"] = "prev",
          },
        })
      end,
      desc = "Treesitter Incremental Selection",
    },
  },
  opts = {
    label = {
      rainbow = {
        enabled = true,
      },
    },
    modes = {
      char = {
        jump_labels = false,
      },
    },
  },
}
