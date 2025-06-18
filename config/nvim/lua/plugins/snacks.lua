return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      gitbrowse = {
        what = "permalink",
      },
      picker = {
        formatters = {
          file = {
            truncate = 120,
            filename_first = true,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<C-v>"] = { "focus_preview", mode = { "n", "i" } },
              ["<C-x>"] = { "focus_list", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<C-v>"] = { "focus_preview", mode = { "n" } },
            },
          },
          preview = {
            keys = {
              ["<C-v>"] = { "focus_list", mode = { "n" } },
            },
          },
        },
      },
    },
    keys = {
      {
        "<A-z>",
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "t", true)
          vim.schedule(function()
            require("snacks.zen").zoom()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
          end)
        end,
        mode = { "t" },
      },
      {
        "<A-z>",
        function()
          require("snacks.zen").zoom()
        end,
        mode = { "n", "v" },
      },
      {
        "<leader>/",
        function()
          require("snacks.picker").grep({
            cwd = require("lazyvim.util.root").get(),
            search = require("darwish.utils").get_visual_selection(),
          })
        end,
        mode = { "x" },
        desc = "Grep the selected value",
      },
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide({ confirm = "picker_files" })
        end,
        desc = "Zoxide",
      },
      {
        "<leader>fl",
        function()
          Snacks.picker.lines()
        end,
        desc = "Lines",
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
          local search = nil
          local utils = require("darwish.utils")

          if utils.in_visual_mode() then
            search = utils.get_visual_selection()
          end
          Snacks.picker.grep({
            cwd = require("lazyvim.util.root").git(),
            search = search,
          })
        end,
        desc = "Grep (Git Dir)",
        mode = { "x", "n" },
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
