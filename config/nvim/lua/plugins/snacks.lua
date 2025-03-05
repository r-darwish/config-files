return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
      dashboard = {
        enabled = false,
        sections = {
          { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 1,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = vim.fn.isdirectory(".git") == 1,
            cmd = "hub status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
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
        desc = "Zoxide",
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
