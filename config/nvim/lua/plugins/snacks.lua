return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      gitbrowse = {
        what = "permalink",
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<C-l>"] = { "focus_preview", mode = { "n", "i" } },
              ["<C-x>"] = { "focus_list", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<C-l>"] = { "focus_preview", mode = { "n" } },
            },
          },
          preview = {
            keys = {
              ["<C-h>"] = { "focus_list", mode = { "n" } },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide({ confirm = "picker_files" })
        end,
        desc = "Zoxide",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects({
            confirm = "picker_files",
            dev = "~/src",
          })
        end,
        desc = "Projects",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({
            cwd = require("lazyvim.util.root").git(),
          })
        end,
        desc = "Grep (Git Dir)",
      },
      {
        "<leader>fP",
        function()
          Snacks.picker.files({
            cwd = vim.fn.stdpath("data") .. "/lazy",
          })
        end,
        desc = "Plugins",
      },
      {
        "<leader>fs",
        function()
          Snacks.picker.files({ cwd = "~/src" })
        end,
        desc = "Zoxide",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_log_line({
            actions = {
              browse_commit = function(_, item)
                if not item then
                  return
                end

                require("darwish.git").browse_commit(item.commit)
              end,
            },
            win = { input = { keys = { ["<c-o>"] = { "browse_commit", mode = { "n", "i" } } } } },
          })
        end,
      },
    },
  },
}
