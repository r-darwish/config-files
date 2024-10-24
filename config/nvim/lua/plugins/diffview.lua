return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Open File History" },
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
      },
    },
  },
}
