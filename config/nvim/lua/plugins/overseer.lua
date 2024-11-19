return {
  { import = "lazyvim.plugins.extras.editor.overseer" },
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "custom.create_pr", "custom.docker_build", "custom.compose_up" },
    },
    keys = {
      {
        "<leader>ol",
        desc = "Restart last task",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], "restart")
          end
        end,
      },
      {
        "<leader>of",
        desc = "Open last task output in quickfix",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            vim.cmd("cd " .. LazyVim.root.get())
            overseer.run_action(tasks[1], "open output in quickfix")
          end
        end,
      },
    },
  },
}
