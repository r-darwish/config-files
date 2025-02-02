return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      case_insensitive = true,
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        local o = require("oil")

        o.open_float(o.get_current_dir(0), { preview = {} })
      end,
    },
  },
}
