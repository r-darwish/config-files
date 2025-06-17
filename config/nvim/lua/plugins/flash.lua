---@module "flash"

return {
  "folke/flash.nvim",
  ---@type Flash.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
}
