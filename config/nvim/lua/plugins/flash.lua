---@module "flash"

return {
  "folke/flash.nvim",
  ---@type Flash.Config
  ---@diagnostic disable-next-line: missing-fields
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
