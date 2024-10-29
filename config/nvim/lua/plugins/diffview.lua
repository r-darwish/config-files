return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gD", "<cmd>DiffviewFileHistory %:p<cr>", desc = "Open File History" },
      { "<leader>gd", "<cmd>DiffviewOpen <cr>", desc = "Open File Diff" },
    },
    opts = {
      keymaps = {
        file_panel = {
          ["gf"] = function()
            local actions = require("diffview.actions")
            actions.goto_file()
            vim.cmd("tabclose #")
          end,
          ["q"] = function()
            vim.cmd("tabclose")
          end,
        },
        file_history_panel = {
          ["q"] = function()
            vim.cmd("tabclose")
          end,
        },
        view = {
          ["q"] = function()
            vim.cmd("tabclose")
          end,
        },
      },
    },
  },
}
