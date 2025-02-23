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
      ["<C-v>"] = "actions.preview",
      ["t"] = { "actions.open_terminal", mode = "n" },
      ["<c-f>"] = function()
        local dir = require("oil").get_current_dir()
        require("fzf-lua.providers.files").files({ cwd = dir })
      end,
      ["<c-g>"] = function()
        local dir = require("oil").get_current_dir()
        require("fzf-lua.providers.grep").live_grep({ cwd = dir })
      end,
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
        o.open(o.get_current_dir(0), { preview = {} })
      end,
    },
  },
}
