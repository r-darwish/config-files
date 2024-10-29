return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window.mappings["C"] = {
        function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.notify("Current directory changed to " .. path)
          vim.fn.chdir(path)
        end,
        desc = "Change Directory",
      }
    end,
  },
}
