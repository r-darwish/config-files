return {
  { import = "lazyvim.plugins.extras.editor.overseer" },
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "custom.create_pr", "custom.docker_build", "custom.compose_up" },
      task_list = {
        max_height = { 1000, 0.4 },
      },
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
        "<leader>oc",
        desc = "Dispose all tasks",
        function()
          local overseer = require("overseer")
          ---@type overseer.Task[]
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
            return
          end

          for _, task in ipairs(tasks) do
            if not task:is_running() then
              task:dispose()
            end
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
