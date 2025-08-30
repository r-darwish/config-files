return {
  {
    "augmentcode/augment.vim",
    lazy = true,
    config = function()
      vim.g.augment_workspace_folders = { LazyVim.root.git() }
    end,
    keys = {
      { "<leader>aa", "<cmd>Augment chat-toggle<cr>", desc = "Toggle Augment" },
      { "<leader>ac", "<cmd>Augment chat<cr>", desc = "Send a message to augment", mode = { "n", "x" } },
      {
        "<leader>ag",
        function()
          require("darwish.utils").launch_zellij({ "auggie", "-w", LazyVim.root.get() }, { floating = true })
        end,
        desc = "Launch auggie at the project root",
      },
      {
        "<leader>aG",
        function()
          require("darwish.utils").launch_zellij({ "auggie", "-w", LazyVim.root.git() }, { floating = true })
        end,
        desc = "Launch auggie at the project git root",
      },
    },
  },
}
