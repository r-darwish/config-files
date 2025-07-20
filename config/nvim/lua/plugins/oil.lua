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
      ["<C-h>"] = { "<C-w>h", mode = "n" },
      ["<C-l>"] = { "<C-w>l", mode = "n" },
      ["S"] = {
        function()
          ---@type oil.SelectOpts
          local args = {}
          if require("darwish.utils").should_split_vertically() then
            args.vertical = true
          else
            args.horizontal = true
          end
          require("oil").select(args)
        end,
        mode = { "n" },
      },
      ["<C-s>"] = {
        function()
          require("oil").save()
        end,
        mode = "n",
      },
      ["<C-n>"] = { "actions.preview_scroll_down", mode = "n" },
      ["<C-v>"] = "actions.preview",
      ["t"] = { "actions.open_terminal", mode = "n" },
      ["<c-f>"] = {
        function()
          local dir = require("oil").get_current_dir()
          Snacks.picker.files({ cwd = dir })
        end,
        desc = "Find files in the current directory",
      },
      ["<c-g>"] = {
        function()
          local dir = require("oil").get_current_dir()
          Snacks.picker.grep({ cwd = dir })
        end,
        desc = "Initiate grep in the current directory",
      },
      ["gd"] = {
        function()
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        end,
        desc = "Toggle more fields",
      },
      ["<leader>gg"] = {
        function()
          require("snacks.lazygit").open({ cwd = require("oil").get_current_dir() })
        end,
        desc = "Launch LazyGit",
      },
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    {
      "<leader>e",
      function()
        local o = require("oil")
        o.open(o.get_current_dir(0), {})
      end,
    },
  },
}
