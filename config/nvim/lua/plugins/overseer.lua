return {
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = "toggleterm",
      templates = {"builtin", "custom.get_tickets"},
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
    },
  },
}
