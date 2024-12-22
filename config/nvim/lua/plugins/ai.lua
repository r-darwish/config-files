return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  {
    "zbirenbaum/copilot.lua",
    keys = {
      { "<leader>at", "<cmd>Copilot toggle<CR>" },
    },
    build = nil,
    event = nil,
    opts = {
      suggestion = {
        keymap = {
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = false,
      },
    },
  },
}
