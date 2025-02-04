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
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["<bs>"] = { "actions.parent", mode = "n" },
      ["<C-p>"] = { "actions.preview_scroll_up", mode = "n" },
      ["<C-n>"] = { "actions.preview_scroll_down", mode = "n" },
      ["t"] = { "actions.open_terminal", mode = "n" },
      ["gd"] = function()
        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
      end,
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
