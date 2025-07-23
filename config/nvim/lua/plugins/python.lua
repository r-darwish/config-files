---@module "conform"

return {
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_organize_imports" },
      },
    },
  },
}
